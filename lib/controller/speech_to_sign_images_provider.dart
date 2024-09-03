import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:sign_language/core/languages/controller/app_localizations.dart';

import '../UI/screens/to_sign_speech_result_screen.dart';
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

  translateSpeech(BuildContext context) async {
    if (!isClicked) {
      _customSnackBar(
        context: context,
        msg: 'recorderIsEmptyMsg'.translate(context),
      );
    } else {
      await stop();

      audioSource = ap.AudioSource.uri(Uri.parse(path!));

      if (context.mounted) {
        Navigator.of(context).push(
          CustomAnimationRoute(
            screen: ToSignSpeechResultScreen(
              path: path!,
            ),
            isHomeScreen: false,
          ),
        );
      }
      notifyListeners();
    }
  }

  Future<void> sendSpeechToModelAi(BuildContext context) async {
    if (!isClicked) {
      _customSnackBar(
        context: context,
        msg: 'recorderIsEmptyMsg'.translate(context),
      );
    } else {
      await stop();

      audioSource = ap.AudioSource.uri(Uri.parse(path!));

      if (context.mounted) {
        Navigator.of(context).push(
          CustomAnimationRoute(
            screen: ToSignSpeechResultScreen(
              path: path!,
            ),
            isHomeScreen: false,
          ),
        );
      }
    }
  }

  _customSnackBar({
    required BuildContext context,
    required String msg,
  }) {
    SnackBar sB = SnackBar(
      padding: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.r),
      )),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(sB);
  }
}
