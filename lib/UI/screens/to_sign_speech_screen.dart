// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
//
// import 'package:sign_language/core/languages/controller/app_localizations.dart';
//
// import '../../controller/speech_to_sign_images_provider.dart';
// import '../../core/languages/controller/language_provider.dart';
// import '../../core/utils/custom_animation_route.dart';
// import 'home_screen.dart';
//
// class ToSignSpeechScreen extends StatelessWidget {
//   const ToSignSpeechScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade900,
//       appBar: AppBar(
//         backgroundColor: Colors.grey.shade900,
//         leading: IconButton(
//           icon: CircleAvatar(
//             backgroundColor: Colors.white,
//             radius: 15.r,
//             child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
//           ),
//           onPressed: () => Navigator.of(context).pushAndRemoveUntil(
//             CustomAnimationRoute(
//               screen: const HomeScreen(),
//               isHomeScreen: false,
//             ),
//             (Route<dynamic> route) => false,
//           ),
//         ),
//       ),
//       body: Consumer<SpeechToSignImagesProvider>(
//         builder: (context, values, _) => Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(height: 70.h),
//               values.isRecordingNow
//                   ? CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 125.r,
//                       child: Lottie.asset('assets/animations/record.json'),
//                     )
//                   : CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 125.r,
//                       child: Icon(Icons.mic, size: 120.sp, color: Colors.black),
//                     ),
//               SizedBox(height: 40.h),
//               _buildText(context),
//               SizedBox(height: 40.h),
//               SizedBox(
//                 width: 300,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     buildRecordingButton(context),
//                     const SizedBox(width: 10),
//                     _buildPauseResumeControl(context),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               buttonTranslate(context),
//               SizedBox(height: 45.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   ElevatedButton buildRecordingButton(BuildContext context) {
//     final speechToSignImagesProvider =
//         context.read<SpeechToSignImagesProvider>();
//     return ElevatedButton(
//       onPressed: () {
//         speechToSignImagesProvider.isRecordingNow = true;
//
//         speechToSignImagesProvider.isClicked = true;
//
//         speechToSignImagesProvider.isRecording = true;
//
//         speechToSignImagesProvider.start();
//       },
//       style: ButtonStyle(
//           backgroundColor: const MaterialStatePropertyAll(Colors.green),
//           foregroundColor: const MaterialStatePropertyAll(Colors.white),
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//           )),
//       child: Text(
//         speechToSignImagesProvider.isClicked
//             ? 'reRecord'.translate(context)
//             : 'startRecord'.translate(context),
//         style: TextStyle(
//           fontSize: 18.sp,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }
//
//   ElevatedButton buttonTranslate(BuildContext context) {
//     final speechToSignImagesProvider =
//         context.read<SpeechToSignImagesProvider>();
//     return ElevatedButton(
//       onPressed: () => speechToSignImagesProvider.sendSpeechToModelAi(context),
//       style: const ButtonStyle(
//         backgroundColor: MaterialStatePropertyAll(Colors.blue),
//         foregroundColor: MaterialStatePropertyAll(Colors.white),
//       ),
//       child: Text(
//         'translate'.translate(context),
//         style: TextStyle(
//           fontSize: 18.sp,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPauseResumeControl(BuildContext context) {
//     final speechToSignImagesProvider =
//         context.read<SpeechToSignImagesProvider>();
//     if (!speechToSignImagesProvider.isClicked) {
//       return const SizedBox();
//     }
//
//     late Icon icon;
//     late Color color;
//
//     if (speechToSignImagesProvider.isPaused == false ||
//         speechToSignImagesProvider.isRecordingNow) {
//       icon = const Icon(Icons.pause, color: Colors.blue, size: 30);
//       color = Colors.red.withOpacity(0.1);
//     } else {
//       final ThemeData theme = Theme.of(context);
//       icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
//       color = theme.primaryColor.withOpacity(0.1);
//     }
//
//     return ClipOval(
//       child: Material(
//         color: color,
//         child: InkWell(
//           child: SizedBox(width: 56, height: 56, child: icon),
//           onTap: () {
//             speechToSignImagesProvider.isRecording = false;
//
//             speechToSignImagesProvider.isPaused
//                 ? speechToSignImagesProvider.resume()
//                 : speechToSignImagesProvider.pause();
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildText(BuildContext context) {
//     final speechToSignImagesProvider =
//         context.read<SpeechToSignImagesProvider>();
//     final isEnglish =
//         Provider.of<LanguageProvider>(context).languageCode == 'en';
//     final String minutes =
//         _formatNumber(speechToSignImagesProvider.recordDuration ~/ 60);
//     final String seconds =
//         _formatNumber(speechToSignImagesProvider.recordDuration % 60);
//
//     return Text(
//       isEnglish ? '$minutes : $seconds' : '$seconds : $minutes',
//       style:
//           TextStyle(color: Colors.white, fontSize: 50.sp, letterSpacing: 1.5),
//     );
//   }
//
//   String _formatNumber(int number) {
//     String numberStr = number.toString();
//     if (number < 10) {
//       numberStr = '0$numberStr';
//     }
//
//     return numberStr;
//   }
// }
