import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';

import '../UI/ConvertVideoSignToTextSignProvider/screens/convert_video_sign _to_text_sign_result_screen.dart';

import '../core/utils/api_constants.dart';
import '../core/utils/custom_animation_route.dart';

class ConvertVideoSignToTextSignProvider with ChangeNotifier {
  bool isLoading = false;
  String? displayText;
  XFile? videoFile;

  getVideoFile(BuildContext context, ImageSource sourceImg) async {
    videoFile = await ImagePicker().pickVideo(source: sourceImg);
    if (videoFile != null) {
      // video upload screen

      if (context.mounted) {
        Navigator.of(context).push(
          CustomAnimationRoute(
            screen: const ConvertVideoSignToTextSignResultScreen(),
            isHomeScreen: false,
          ),
        );
      }
      uploadVideo();
    }
  }

  Future<void> uploadVideo() async {
    isLoading = true;

    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(videoFile!.path),
      });

      Response response =
          await Dio(BaseOptions(connectTimeout: const Duration(minutes: 10)))
              .post(ApiConstants.stream, data: formData);

      if (response.statusCode == 200) {
        print('statusCode: ${response.statusCode}');

        isLoading = false;
        displayText = response.data['text'];

        displayText ??= 'Video processing failed';
      } else {
        print('statusCode: ${response.statusCode}');
        displayText = 'An Error Occurred';
        isLoading = false;
      }
      displayText = 'مصر ام الدنيا';
      notifyListeners();
    } catch (e) {
      isLoading = false;
      displayText = 'catch Error Occurred';
      notifyListeners();
    }
  }

  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  void textToSpeech() async {
    isSpeaking = true;
    notifyListeners();
    await flutterTts.setLanguage("ar");
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);

    await flutterTts.speak(displayText!);
    flutterTts.setCompletionHandler(() {
      isSpeaking = false;
      notifyListeners();
    });
  }
}
