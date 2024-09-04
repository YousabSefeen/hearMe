import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_language/core/languages/controller/app_localizations.dart';
import 'package:sign_language/core/utils/app_alerts.dart';

import '../UI/speech to sign images/screens/speech_to_sign_images_result_screen.dart';
import '../core/constants/app_values_manager.dart';
import '../core/utils/custom_animation_route.dart';

class SpeechToSignImagesProvider with ChangeNotifier {
  final FlutterSoundRecord _audioRecorder = FlutterSoundRecord();
  String? path;
  bool _isRecording = false;
  bool isPaused = false;
  int recordDuration = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();

    _audioRecorder.dispose();
    audioSource = null;

    super.dispose();
  }

  bool isRecording = false;
  bool isRecordingNow = false;
  ap.AudioSource? audioSource;

  bool isClicked = false;

  Future<void> startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        isRecordingNow = true;

        isClicked = true;

        isRecording = true;
        await _audioRecorder.start();

        bool _isRecording = await _audioRecorder.isRecording();

        _isRecording = _isRecording;
        recordDuration = 0;

        _startTimer();
        notifyListeners();
      }
    } catch (e) {
      print('an error occured in catch');
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> stop() async {
    _timer?.cancel();

    path = await _audioRecorder.stop();
    print('Path ${path}');

    _isRecording = false;
    notifyListeners();

    /// /data/user/0/com.example.sign_language_app/cache/audio9181443227287196195.m4a
  }

  Future<void> pause() async {
    print('Future  pause');

    _timer?.cancel();

    await _audioRecorder.pause();

    isPaused = true;
    isRecordingNow = false;
    notifyListeners();
  }

  Future<void> resume() async {
    print('Future _resume');
    _startTimer();
    await _audioRecorder.resume();

    isPaused = false;
    isRecordingNow = true;
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
      notifyListeners();
    });
  }

  Future<void> handleTranslateAction(BuildContext context) async {
    if (!isClicked) {
      AppAlerts.customSnackBar(
        context: context,
      );
    } else {
      await stop();

      audioSource = ap.AudioSource.uri(Uri.parse(path!));

      if (context.mounted) {
        handleRecordingCompletion(context);
      }
    }
  }

  ///******** result

  List<String> recorderImagesResult = [];
  List<String> recorderImagesFinalResult = [];
  bool isLoading = false;

  Future<void> handleRecordingCompletion(BuildContext context) async {
    Navigator.of(context).push(
      CustomAnimationRoute(
          screen: const ToSignSpeechResultScreen(), isHomeScreen: false),
    );
    handlePermissions();
    await uploadRecordToModelAi();
    notifyListeners();
  }

  handlePermissions() async {
    await Permission.storage.request().then((status) {
      if (status == PermissionStatus.granted) {
        // لديك إذن للوصول إلى التخزين
        print('لديك إذن للوصول إلى التخزين');
      } else {
        // لا تملك إذنًا للوصول إلى التخزين
        print('لا تملك إذنًا للوصول إلى التخزين');
      }
    });
  }

  Future<void> uploadRecordToModelAi() async {
    if (kDebugMode) {
      print(path);
    }

    isLoading = true;

    try {
      FormData formData =
          FormData.fromMap({'file': await MultipartFile.fromFile(path!)});

      Response response =
          await Dio(BaseOptions(connectTimeout: const Duration(minutes: 10)))
              .post(AppValuesManager.reverse, data: formData);
      if (response.statusCode == 200) {
        if (response.data['images'] != null) {
          List<dynamic> images = response.data['images'];
          for (var image in images) {
            recorderImagesResult.add(image);
          }
          if (kDebugMode) {
            print('Print ${response.data}');
            print('recorderImagesResult $recorderImagesResult');
          }
        } else {
          if (kDebugMode) {
            print('Data isNull ${response.data}');
          }
        }
      }
      await getResultFromModelAi();
    } catch (e) {
      isLoading = false;

      if (kDebugMode) {
        print('An Error Occurred: $e');
      }
    }
  }

  Future<void> getResultFromModelAi() async {
    try {
      for (var image in recorderImagesResult) {
        Response response =
            await Dio(BaseOptions(connectTimeout: const Duration(minutes: 10)))
                .get('${AppValuesManager.baseUrl}/public/$image');
        if (response.statusCode == 200 && response.data != null) {
          if (kDebugMode) {
            print('Get Result:  ${response.data}');
          }
          recorderImagesFinalResult.add(image);
        }
      }
      if (kDebugMode) {
        print(
            'recorderImagesFinalResult:  ${recorderImagesFinalResult.length}');
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;

      if (kDebugMode) {
        print('An Error Occurred in Get Function: $e');
      }
      notifyListeners();
    }
  }
}
