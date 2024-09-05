import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:sign_language/UI/ConvertVideoSignToTextSignProvider/screens/convert_video_sign _to_text_sign_screen.dart';
import 'package:sign_language/core/languages/controller/app_localizations.dart';

import '../../core/languages/controller/language_provider.dart';
import '../../core/utils/custom_animation_route.dart';
import '../ConvertVideoSignToTextSignProvider/widgets/home_app_bar_actions.dart';
import '../speech to sign images/screens/speech_to_sign_images_screen.dart';
import 'sign_language_guide_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish =
        Provider.of<LanguageProvider>(context, listen: false).languageCode ==
            'en';
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Lottie.asset('assets/animations/palestineFlag1.json'),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('hearME'.translate(context)),
        ),
        actions: const [HomeAppBarActions()],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _customButton(
            context: context,
            title: 'signTo'.translate(context),
            image: 'assets/images/signTo.png',
            onTap: () => Navigator.of(context).push(
              CustomAnimationRoute(
                screen: const ConvertVideoSignToTextSignScreen(),
                isHomeScreen: false,
              ),
            ),
          ),
          _customButton(
            context: context,
            title: 'toSign'.translate(context),
            image: 'assets/images/toSign.png',
            onTap: () => Navigator.of(context).push(
              CustomAnimationRoute(
                screen: const SpeechToSignImagesScreen(),
                isHomeScreen: false,
              ),
            ),
          ),
          _customButton(
            context: context,
            title: 'signLanguage'.translate(context),
            image: 'assets/images/signLanguage.png',
            onTap: () => Navigator.of(context).push(
              CustomAnimationRoute(
                screen: SignLanguageGuideScreen(),
                isHomeScreen: false,
              ),
            ),
          ),
          _customButton(
            context: context,
            title: 'Community'.translate(context),
            image: 'assets/images/community.png',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Card _customButton({
    required BuildContext context,
    required void Function()? onTap,
    required String title,
    required String image,
  }) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        splashColor: Colors.green,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 7.w),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(180.r),
                ),
                child: Image.asset(image, width: 80, height: 80),
              ),
              SizedBox(width: 15.w),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 15.sp,
                color: Colors.blueGrey.shade700,
              ),
              SizedBox(width: 7.w),
            ],
          ),
        ),
      ),
    );
  }
}
