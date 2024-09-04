import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/UI/ConvertVideoSignToTextSignProvider/widgets/custom_back_button.dart';
import 'package:sign_language/controller/speech_to_sign_images_provider.dart';

import '../widgets/build_image_carousel_slider.dart';

class ToSignSpeechResultScreen extends StatelessWidget {
  const ToSignSpeechResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: const CustomBackButton(),
        ),
        backgroundColor: Colors.black,
        body:
            Consumer<SpeechToSignImagesProvider>(builder: (context, values, _) {
          if (values.isLoading) {
            return Center(
              child: Lottie.asset(
                'assets/animations/loading.json',
                height: MediaQuery.sizeOf(context).height,
              ),
            );
          } else {
            return Center(
              child: Container(
                child: values.recorderImagesFinalResult.isNotEmpty
                    ? BuildImageCarouselSlider(
                        itemCount: values.recorderImagesFinalResult.length,
                        images: values.recorderImagesFinalResult,
                      )
                    : Text(
                        'An Error Occured',
                        style: TextStyle(fontSize: 30.sp, color: Colors.red),
                      ),
              ),
            );
          }
        }));
  }
}
