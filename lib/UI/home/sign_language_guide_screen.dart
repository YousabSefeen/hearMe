import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/core/languages/controller/app_localizations.dart';

import '../../core/constants/languages_guide_values.dart';
import '../../core/languages/controller/language_provider.dart';

class SignLanguageGuideScreen extends StatelessWidget {
  const SignLanguageGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish =
        Provider.of<LanguageProvider>(context).languageCode == 'en';
    final englishLanguageGuide = LanguagesGuideValues.getEnglishLanguageGuide;
    final arabicLanguageGuide = LanguagesGuideValues.getArabicLanguageGuide;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(isEnglish ? 0.93 : 1),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          'signLanguage'.translate(context),
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                fontSize: 25.sp,
              ),
        ),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 4.5,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemCount: isEnglish
            ? englishLanguageGuide.length
            : arabicLanguageGuide.length,
        itemBuilder: (BuildContext context, int index) => Card(
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          color: Colors.grey,
          elevation: 8,
          shadowColor: Colors.black,
          child: GridTile(
            footer: Container(
              padding: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                isEnglish
                    ? englishLanguageGuide[index].title
                    : arabicLanguageGuide[index].title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                isEnglish
                    ? englishLanguageGuide[index].image
                    : arabicLanguageGuide[index].image,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


