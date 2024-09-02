import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/UI/screens/to_sign_speech_result_screen.dart';
import 'package:sign_language/core/languages/controller/app_localizations.dart';


import '../../core/languages/controller/language_provider.dart';
import '../../core/utils/custom_animation_route.dart';
import 'home_screen.dart';

class ToSignSpeechScreen extends StatefulWidget {
  const ToSignSpeechScreen({super.key});

  @override
  _ToSignSpeechScreenState createState() => _ToSignSpeechScreenState();
}

class _ToSignSpeechScreenState extends State<ToSignSpeechScreen> {
  final FlutterSoundRecord _audioRecorder = FlutterSoundRecord();
  String? path;
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordDuration = 0;
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

  @override
  Widget build(BuildContext context) {
    final isEnglish =
        Provider.of<LanguageProvider>(context).languageCode == 'en';
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 15.r,
            child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          ),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            CustomAnimationRoute(
              screen: const HomeScreen(),
              isHomeScreen: false,
            ),
            (Route<dynamic> route) => false,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 70.h),
            isRecordingNow
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 125.r,
                    child: Lottie.asset('assets/animations/record.json'),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 125.r,
                    child: Icon(Icons.mic, size: 120.sp, color: Colors.black),
                  ),
            SizedBox(height: 40.h),
            _buildText(),
            SizedBox(height: 40.h),
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildRecordingButton(context),
                  const SizedBox(width: 10),
                  _buildPauseResumeControl(),
                ],
              ),
            ),
            const Spacer(),
            buttonTranslate(context),
            SizedBox(height: 45.h),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildRecordingButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        isRecordingNow = true;

        isClicked = true;

        isRecording = true;

        _start();
        setState(() {});
      },
      style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.green),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          )),
      child: Text(
        isClicked
            ? 'reRecord'.translate(context)
            : 'startRecord'.translate(context),
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  ElevatedButton buttonTranslate(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (!isClicked) {
          _customSnackBar(
            context: context,
            msg: 'recorderIsEmptyMsg'.translate(context),
          );
        } else {
          await _stop();
          setState(() {
            audioSource = ap.AudioSource.uri(Uri.parse(path!));
          });
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
      },
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blue),
        foregroundColor: MaterialStatePropertyAll(Colors.white),
      ),
      child: Text(
        'translate'.translate(context),
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (!isClicked) {
      return const SizedBox();
    }

    late Icon icon;
    late Color color;

    if (_isPaused == false || isRecordingNow) {
      icon = const Icon(Icons.pause, color: Colors.blue, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final ThemeData theme = Theme.of(context);
      icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            setState(() {
              isRecording = false;
            });
            _isPaused ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    final isEnglish =
        Provider.of<LanguageProvider>(context).languageCode == 'en';
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      isEnglish ? '$minutes : $seconds' : '$seconds : $minutes',
      style:
          TextStyle(color: Colors.white, fontSize: 50.sp, letterSpacing: 1.5),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();

    path = await _audioRecorder.stop();
    print('Path ${path}');

    setState(() => _isRecording = false);

    /// /data/user/0/com.example.sign_language_app/cache/audio9181443227287196195.m4a
  }

  Future<void> _pause() async {
    print('Future _pause');

    _timer?.cancel();

    await _audioRecorder.pause();

    setState(() {
      _isPaused = true;
      isRecordingNow = false;
    });
  }

  Future<void> _resume() async {
    print('Future _resume');
    _startTimer();
    await _audioRecorder.resume();

    setState(() {
      _isPaused = false;
      isRecordingNow = true;
    });
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
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
