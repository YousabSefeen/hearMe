import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/core/languages/controller/app_localizations.dart';

import '../../core/languages/controller/language_provider.dart';

class SignLanguageGuideScreen extends StatelessWidget {
  SignLanguageGuideScreen({super.key});

  List<LanguagesGuideModel> arabicLan = [
    LanguagesGuideModel(image: 'assets/images/back/0.jpg', title: 'أ'),
    LanguagesGuideModel(image: 'assets/images/back/1.jpg', title: 'ب'),
    LanguagesGuideModel(image: 'assets/images/back/2.jpeg', title: 'ت'),
    LanguagesGuideModel(image: 'assets/images/back/3.jpg', title: 'ث'),
    LanguagesGuideModel(image: 'assets/images/back/4.jpeg', title: 'ج'),
    LanguagesGuideModel(image: 'assets/images/back/5.jpg', title: 'ح'),
    LanguagesGuideModel(image: 'assets/images/back/6.jpg', title: 'خ'),
    LanguagesGuideModel(image: 'assets/images/back/7.jpg', title: 'د'),
    LanguagesGuideModel(image: 'assets/images/back/8.jpeg', title: 'ذ'),
    LanguagesGuideModel(image: 'assets/images/back/9.jpg', title: 'ر'),
    LanguagesGuideModel(image: 'assets/images/back/10.jpg', title: 'ز'),
    LanguagesGuideModel(image: 'assets/images/back/11.jpg', title: 'س'),
    LanguagesGuideModel(image: 'assets/images/back/12.jpeg', title: 'ش'),
    LanguagesGuideModel(image: 'assets/images/back/13.jpg', title: 'ص'),
    LanguagesGuideModel(image: 'assets/images/back/14.jpg', title: 'ض'),
    LanguagesGuideModel(image: 'assets/images/back/15.jpg', title: 'ط'),
    LanguagesGuideModel(image: 'assets/images/back/16.jpg', title: 'ظ'),
    LanguagesGuideModel(image: 'assets/images/back/17.jpeg', title: 'ع'),
    LanguagesGuideModel(image: 'assets/images/back/18.jpg', title: 'غ'),
    LanguagesGuideModel(image: 'assets/images/back/19.jpg', title: 'ف'),
    LanguagesGuideModel(image: 'assets/images/back/20.jpg', title: 'ق'),
    LanguagesGuideModel(image: 'assets/images/back/21.jpg', title: 'ك'),
    LanguagesGuideModel(image: 'assets/images/back/22.jpg', title: 'ل'),
    LanguagesGuideModel(image: 'assets/images/back/23.jpg', title: 'م'),
    LanguagesGuideModel(image: 'assets/images/back/24.jpeg', title: 'ن'),
    LanguagesGuideModel(image: 'assets/images/back/25.jpg', title: 'ه'),
    LanguagesGuideModel(image: 'assets/images/back/26.jpg', title: 'و'),
    LanguagesGuideModel(image: 'assets/images/back/27.jpg', title: 'ي'),
  ];
  List<LanguagesGuideModel> englishLan = [
    LanguagesGuideModel(
        image: 'assets/images/english_letters/1.jpeg', title: 'A'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/2.jpeg', title: 'B'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/3.jpeg', title: 'C'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/4.jpeg', title: 'D'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/5.jpeg', title: 'E'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/6.jpeg', title: 'F'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/7.jpeg', title: 'G'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/8.jpeg', title: 'H'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/9.jpeg', title: 'I'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/10.jpeg', title: 'J'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/11.jpeg', title: 'K'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/12.jpeg', title: 'L'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/13.jpeg', title: 'M'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/14.jpeg', title: 'N'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/15.jpeg', title: 'O'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/16.jpeg', title: 'P'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/17.jpeg', title: 'Q'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/18.jpeg', title: 'R'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/19.jpeg', title: 'S'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/20.jpeg', title: 'T'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/21.jpeg', title: 'U'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/22.jpeg', title: 'V'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/23.jpeg', title: 'W'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/24.jpeg', title: 'X'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/25.jpeg', title: 'Y'),
    LanguagesGuideModel(
        image: 'assets/images/english_letters/26.jpeg', title: 'Z'),
  ];

  @override
  Widget build(BuildContext context) {
    final isEnglish =
        Provider.of<LanguageProvider>(context).languageCode == 'en';
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
        itemCount: isEnglish ? englishLan.length : arabicLan.length,
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
                isEnglish ? englishLan[index].title : arabicLan[index].title,
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
                isEnglish ? englishLan[index].image : arabicLan[index].image,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LanguagesGuideModel {
  final String image;
  final String title;

  LanguagesGuideModel({required this.image, required this.title});
}
