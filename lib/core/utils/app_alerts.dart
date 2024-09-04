import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_language/core/languages/controller/app_localizations.dart';

class AppAlerts {
  static customSnackBar({
    required BuildContext context,
  }) {
    SnackBar sB = SnackBar(
      padding: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      content: Text(
        'recorderIsEmptyMsg'.translate(context),
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
