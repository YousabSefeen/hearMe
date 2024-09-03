import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/controller/speech_to_sign_images_provider.dart';

import '../../../core/languages/controller/language_provider.dart';

class BuildDurationText extends StatelessWidget {
  const BuildDurationText({super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish =
        Provider.of<LanguageProvider>(context).languageCode == 'en';

    return Consumer<SpeechToSignImagesProvider>(builder: (context, values, _) {
      final String minutes = _formatNumber(values.recordDuration ~/ 60);
      final String seconds = _formatNumber(values.recordDuration % 60);

      return Text(
        isEnglish ? '$minutes : $seconds' : '$seconds : $minutes',
        style:
            TextStyle(color: Colors.white, fontSize: 50.sp, letterSpacing: 1.5),
      );
    });
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }
}
