import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/core/languages/controller/app_localizations.dart';

import '../../../core/constants/app_colors_managers.dart';
import '../../../core/languages/controller/language_provider.dart';

class CustomRegistrationButton extends StatelessWidget {
  final void Function()? onPressed;
  const CustomRegistrationButton({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isEnglish =
        Provider.of<LanguageProvider>(context).languageCode == 'en';
    return  ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(TextStyle(
          fontSize: 22.sp,
          color: Colors.white,
          fontWeight:
          isEnglish ? FontWeight.w700 : FontWeight.w900,
          letterSpacing: isEnglish ? 1.5 : 0,
        )),
        overlayColor: WidgetStateProperty.all(Colors.grey),
        foregroundColor:
        WidgetStateProperty.all(AppColorsManager.black),
        backgroundColor:
        WidgetStateProperty.all(AppColorsManager.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        elevation: WidgetStateProperty.all(4),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
            vertical: 17.h, horizontal: 20.w)),
      ),
      child: Text(
        'registration'.translate(context),
        style: const TextStyle(
          shadows: [
            Shadow(
                color: Colors.green,
                blurRadius: 2,
                offset: Offset(0, 2))
          ],
        ),
      ),
    ) ;
  }
}
