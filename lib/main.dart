import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:sign_language/controller/speech_to_sign_images_provider.dart';



import 'UI/home/splash_screen.dart';
import 'controller/convert_video_sign _to_text_sign_provider.dart';
import 'core/languages/controller/app_localizations.dart';
import 'core/languages/controller/language_provider.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/light_mode.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider()..getLanguagePref(),
        ),
        ChangeNotifierProvider<ConvertVideoSignToTextSignProvider>(
          create: (_) => ConvertVideoSignToTextSignProvider(),
        ),
        ChangeNotifierProvider<SpeechToSignImagesProvider>(
          create: (_) => SpeechToSignImagesProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => Consumer<LanguageProvider>(
        builder: (context, values, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: values.languageCode == 'en'
              ? const Locale('en')
              : const Locale('ar', 'EG'),
          supportedLocales: const [
            Locale("en"),
            Locale("ar"),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var local in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == local.languageCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: LightMode.mode(
              context: context, isEnglish: values.languageCode == 'en'),
          themeMode: ThemeMode.light,

          home: const SplashScreen(),

          ///  home: const SpeechToSignImagesScreen(),

          routes: AppRouters.routes,
        ),
      ),
    );
  }
}
