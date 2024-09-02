import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/UI/ConvertVideoSignToTextSignProvider/widgets/custom_loading.dart';
import 'package:sign_language/core/languages/controller/app_localizations.dart';

import '../../../controller/convert_video_sign _to_text_sign_provider.dart';
import '../../../core/constants/app_colors_managers.dart';

import '../../../core/languages/controller/language_provider.dart';
import '../widgets/custom_back_button.dart';

class ConvertVideoSignToTextSignResultScreen extends StatelessWidget {
  const ConvertVideoSignToTextSignResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isEnglish = languageProvider.languageCode == 'en';
    return Consumer<ConvertVideoSignToTextSignProvider>(
      builder: (context, values, _) {
        return Directionality(
          textDirection: languageProvider.defaultDirection,
          child: Scaffold(
            backgroundColor: AppColorsManager.white,
            appBar: AppBar(
              backgroundColor: AppColorsManager.white,
              leading: const CustomBackButton(),
            ),
            body: values.isLoading
                ? const CustomLoading()
                : Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: isEnglish
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'capturedText'.translate(context),
                                      style: textTheme.titleLarge,
                                    ),
                                    TextSpan(
                                      text: values.displayText,
                                      style: textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 70),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 300.w,
                                padding: EdgeInsets.only(left: 17.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                child: Lottie.asset(
                                    values.isSpeaking
                                        ? 'assets/animations/mouth_speaks.json'
                                        : 'assets/animations/mouth_stops.json',
                                    height: MediaQuery.sizeOf(context).height *
                                        0.55),
                              ),
                              const SizedBox(height: 30),
                              IconButton(
                                onPressed: () => values.textToSpeech(),
                                icon: CircleAvatar(
                                  backgroundColor: AppColorsManager.black,
                                  radius: 30.sp,
                                  child: Icon(
                                    Icons.spatial_tracking_outlined,
                                    size: 35.sp.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
