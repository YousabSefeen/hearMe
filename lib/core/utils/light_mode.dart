import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors_managers.dart';

class LightMode {
  static MaterialColor customYellow = const MaterialColor(0xffFBA834, {
    50: Color(0xffFBA834),
    100: Color(0xffFBA834),
    200: Color(0xffFBA834),
    300: Color(0xffFBA834),
    400: Color(0xffFBA834),
    500: Color(0xffFBA834),
    600: Color(0xffFBA834),
    700: Color(0xffFBA834),
    800: Color(0xffFBA834),
    900: Color(0xffFBA834),
  });

  static ThemeData mode(
      {required BuildContext context, required bool isEnglish}) {
    return ThemeData(
      // highlightColor:Colors.black,  Scrollbar color
      primaryColor: AppColorsManager.white,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: customYellow,
        cardColor: AppColorsManager.white,
      ).copyWith(
        secondary: Colors.amber,
        onSurface: Colors.grey.shade900,
      ),
      scaffoldBackgroundColor: AppColorsManager.green,
      cardColor: AppColorsManager.white,
      splashColor: Colors.grey.shade500,
      //use in home Screen in (DatePicker selectionColor)
      shadowColor: AppColorsManager.green,
      //use in home   in (customDrawer   *icons colors*)
      canvasColor: Colors.black,

      secondaryHeaderColor: Colors.green,
      cardTheme: CardTheme(
        elevation: 7,
        color: AppColorsManager.white,
        shadowColor: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColorsManager.green,
        foregroundColor: AppColorsManager.white,
        centerTitle: true,
        titleTextStyle: GoogleFonts.atma(
          textStyle: TextStyle(
            color: AppColorsManager.white,
            fontWeight: FontWeight.w800,
            fontSize: 30.sp,
            letterSpacing: isEnglish ? 2 : 0,
          ),
        ),
      ),
      /*elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(GoogleFonts.atma(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          )),
          overlayColor: MaterialStateProperty.all(Colors.grey),
          foregroundColor: MaterialStateProperty.all(AppColorsManager.black),
          backgroundColor: MaterialStateProperty.all(AppColorsManager.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          elevation: MaterialStateProperty.all(4),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w)),
        ),
      ),*/
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(Colors.green),
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ))),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelTextStyle: MaterialStateProperty.all(TextStyle(
          fontSize: 15.sp,
          color: AppColorsManager.black,
          fontWeight: FontWeight.w400,
        )),
        elevation: 3,
        shadowColor: Colors.orange,
        position: PopupMenuPosition.over,
      ),

      expansionTileTheme: ExpansionTileThemeData(
        collapsedIconColor: Colors.black,
        expansionAnimationStyle: AnimationStyle(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut,
          reverseDuration: const Duration(milliseconds: 400),
        ),
        clipBehavior: Clip.hardEdge,
        collapsedTextColor: Colors.black,
        tilePadding: EdgeInsets.zero,
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.zero,
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.abel(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: isEnglish ? FontWeight.w900 : FontWeight.w800,
          letterSpacing: isEnglish ? 1.5 : 0,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: isEnglish ? 15.sp : 18.sp,
          letterSpacing: isEnglish ? 1 : 0,
        ),
        titleMedium: TextStyle(
          fontSize: 17.sp,
          color: Colors.black,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
        titleLarge: GoogleFonts.atma(
          color: Colors.blue,
          fontSize: 18.sp,
          fontWeight: isEnglish ? FontWeight.w700 : FontWeight.w800,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5)),
          foregroundColor: MaterialStateColor.resolveWith(
              (states) => AppColorsManager.black),
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.white),
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.green),
        ),
      ),
    );
  }
}
