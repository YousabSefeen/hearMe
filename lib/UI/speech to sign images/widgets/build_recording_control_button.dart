import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/controller/speech_to_sign_images_provider.dart';

class BuildRecordingControlButton extends StatelessWidget {
  const BuildRecordingControlButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeechToSignImagesProvider>(
      builder: (context, values, _) => CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: IconButton(
          onPressed: () {
            values.isRecording = false;

            values.isPaused ? values.resume() : values.pause();
          },
          icon: Icon(
            !values.isPaused && values.isRecordingNow
                ? Icons.pause
                : Icons.play_arrow,
            size: 22.sp,
            color: !values.isPaused && values.isRecordingNow
                ? Colors.blue
                : Colors.green,
          ),
        ),
      ),
    );
  }
}
