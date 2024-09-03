import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_language/controller/speech_to_sign_images_provider.dart';
import 'package:sign_language/core/languages/controller/app_localizations.dart';

class BuildTranslateButton extends StatelessWidget {
  const BuildTranslateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: ElevatedButton(
        onPressed: () => context
            .read<SpeechToSignImagesProvider>()
            .sendSpeechToModelAi(context),
        style: const ButtonStyle(
          padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 12, horizontal: 15)),
          backgroundColor: WidgetStatePropertyAll(Colors.blue),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
        ),
        child: Text(
          'translate'.translate(context),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
