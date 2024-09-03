import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/UI/ConvertVideoSignToTextSignProvider/widgets/custom_back_button.dart';
import 'package:sign_language/UI/speech%20to%20sign%20images/widgets/build_duration_text.dart';
import 'package:sign_language/UI/speech%20to%20sign%20images/widgets/build_recording_control_button.dart';
import 'package:sign_language/UI/speech%20to%20sign%20images/widgets/build_translate_button.dart';

import 'package:sign_language/core/languages/controller/app_localizations.dart';

import '../../../controller/speech_to_sign_images_provider.dart';
import '../../../core/languages/controller/language_provider.dart';
import '../../../core/utils/custom_animation_route.dart';
import '../../screens/home_screen.dart';

class SpeechToSignImagesScreen extends StatelessWidget {
  const SpeechToSignImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        leading: const CustomBackButton(),
      ),
      body: Consumer<SpeechToSignImagesProvider>(
        builder: (context, values, _) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 70.h),
              values.isRecordingNow
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
              const BuildDurationText(),
              SizedBox(height: 40.h),
              SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildRecordingButton(context),
                    const SizedBox(width: 10),

                    const BuildRecordingControlButton(),


                  ],
                ),
              ),
              const Spacer(),
              const BuildTranslateButton(),
            SizedBox(height: 40.h),

            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildRecordingButton(BuildContext context) {
    final speechToSignImagesProvider =
        context.read<SpeechToSignImagesProvider>();
    return ElevatedButton(
      onPressed: () => speechToSignImagesProvider.startRecording(),
      child: Text(
        speechToSignImagesProvider.isClicked
            ? 'reRecord'.translate(context)
            : 'startRecord'.translate(context),
        style: TextStyle(
            fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    );
  }


}
