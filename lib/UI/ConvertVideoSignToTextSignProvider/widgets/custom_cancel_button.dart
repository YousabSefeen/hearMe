import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/core/languages/controller/app_localizations.dart';

import '../../../core/constants/app_colors_managers.dart';
import '../../../core/languages/controller/language_provider.dart';

class CustomCancelButton extends StatelessWidget {
  const CustomCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish =
        Provider.of<LanguageProvider>(context).languageCode == 'en';
    return TextButton(
      onPressed: () => Navigator.pop(context),
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(TextStyle(
          fontSize: 20.sp,
          color: Colors.white,
          fontWeight: isEnglish ? FontWeight.w800 : FontWeight.w900,
          letterSpacing: isEnglish ? 1 : 0,
        )),
        overlayColor: WidgetStateProperty.all(Colors.grey),
        foregroundColor: WidgetStateProperty.all(AppColorsManager.black),
        backgroundColor: WidgetStateProperty.all(AppColorsManager.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        elevation: MaterialStateProperty.all(4),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
            vertical: isEnglish ? 15.h : 10.h,
            horizontal: isEnglish ? 10.w : 15.w)),
      ),
      child: Text(
        'cancel'.translate(context),
      ),
    );
  }
}
