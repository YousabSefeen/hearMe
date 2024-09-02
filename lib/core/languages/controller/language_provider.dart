import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String languageCode = 'en';

//  this is default Direction  in first  Start app
//  because the default Current Locale is ("ar")
  TextDirection defaultDirection = TextDirection.ltr;

  onChangeLanguage(String newLanguage) async {
    languageCode = newLanguage;

    defaultDirection =
        (languageCode == "ar" ? TextDirection.rtl : TextDirection.ltr);
    notifyListeners();
    var pref = await SharedPreferences.getInstance();

    pref.setString('languageCode', languageCode);
  }

  getLanguagePref() async {
    var pref = await SharedPreferences.getInstance();
    languageCode = pref.getString('languageCode') ?? languageCode;
    final _getDeviceLocal = ui.window.locale;
    final _languageCode = _getDeviceLocal.languageCode;

    languageCode =
        pref.containsKey('languageCode') ? languageCode : _languageCode;

    defaultDirection =
        languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    notifyListeners();
  }
}
