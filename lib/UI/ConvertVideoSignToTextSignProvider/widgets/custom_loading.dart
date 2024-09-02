import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset('assets/animations/loading.json',
            height: MediaQuery.sizeOf(context).height * 0.8),
        DefaultTextStyle(
          style: GoogleFonts.raleway(
              textStyle: TextStyle(
            color: Colors.black,
            fontSize: 25.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 3,
          )),
          child: AnimatedTextKit(
            isRepeatingAnimation: true,
            repeatForever: true,
            animatedTexts: [
              WavyAnimatedText('Loading...', speed: const Duration(seconds: 6)),
            ],
          ),
        )
      ],
    );
  }
}
