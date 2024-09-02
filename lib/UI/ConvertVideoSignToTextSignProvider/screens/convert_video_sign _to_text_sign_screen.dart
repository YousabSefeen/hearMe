import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/UI/ConvertVideoSignToTextSignProvider/widgets/custom_cancel_button.dart';
import 'package:sign_language/UI/ConvertVideoSignToTextSignProvider/widgets/custom_registration_button.dart';

import '../../../controller/convert_video_sign _to_text_sign_provider.dart';

class ConvertVideoSignToTextSignScreen extends StatelessWidget {
  const ConvertVideoSignToTextSignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Icon(Icons.arrow_back_ios, size: 22.sp, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(180.r),
                ),
                child: Lottie.asset('assets/animations/video.json'),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: 50),
                  CustomRegistrationButton(
                    onPressed: () => context
                        .read<ConvertVideoSignToTextSignProvider>()
                        .getVideoFile(context, ImageSource.camera),
                  ),
                  const SizedBox(width: 7),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => context
                          .read<ConvertVideoSignToTextSignProvider>()
                          .getVideoFile(context, ImageSource.gallery),
                      icon: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.file_open,
                          size: 27.sp,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 50),
              const CustomCancelButton(),
            ],
          ),
        ),
      ),
    );
  }
}
