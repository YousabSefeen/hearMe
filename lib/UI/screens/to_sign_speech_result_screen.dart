import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_language/UI/screens/to_sign_speech_screen.dart';

import '../../core/constants/app_values_manager.dart';
import '../../core/utils/custom_animation_route.dart';

class ToSignSpeechResultScreen extends StatefulWidget {
  final String path;

  const ToSignSpeechResultScreen({super.key, required this.path});

  @override
  State<ToSignSpeechResultScreen> createState() =>
      _ToSignSpeechResultScreenState();
}

class _ToSignSpeechResultScreenState extends State<ToSignSpeechResultScreen> {
  List<String> recorderImagesResult = [];
  List<String> recorderImagesFinalResult = [];

  @override
  void initState() {
    super.initState();
    permissions();
    uploadRecord();
  }

  permissions() async {
    await Permission.storage.request().then((status) {
      if (status == PermissionStatus.granted) {
        // لديك إذن للوصول إلى التخزين
        print('لديك إذن للوصول إلى التخزين');
      } else {
        // لا تملك إذنًا للوصول إلى التخزين
        print('لا تملك إذنًا للوصول إلى التخزين');
      }
    });
  }

  bool isLoading = false;

  Future<void> uploadRecord() async {
    print(widget.path);
    setState(() {
      isLoading = true;
    });
    try {
      var dio = Dio();
      dio.options.connectTimeout = const Duration(minutes: 10);

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(widget.path),
      });

      Response response =
          await dio.post(AppValuesManager.reverse, data: formData);
      if (response.statusCode == 200) {
        if (response.data['images'] != null) {
          List<dynamic> images = response.data['images'];
          for (var image in images) {
            recorderImagesResult.add(image);
          }
          print('Print ${response.data}');
          log('recorderImagesResult $recorderImagesResult');
        } else {
          print('Data isNull ${response.data}');
        }
      }
      await get();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('An Error Occurred: $e');
    }
  }

  Future<void> get() async {
    try {
      var dio = Dio();
      dio.options.connectTimeout = const Duration(minutes: 10);

      for (var image in recorderImagesResult) {
        Response response =
            await dio.get('${AppValuesManager.baseUrl}/public/$image');
        if (response.statusCode == 200 && response.data != null) {
          print('Get Result:  ${response.data}');
          recorderImagesFinalResult.add(image);
        }
      }
      print('recorderImagesFinalResult:  ${recorderImagesFinalResult.length}');

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('An Error Occurred in Get Function: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 15.r,
              child:
                  Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
            ),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              CustomAnimationRoute(
                screen: const ToSignSpeechScreen(),
                isHomeScreen: false,
              ),
              (Route<dynamic> route) => false,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: isLoading
            ? Center(
                child: Lottie.asset(
                  'assets/animations/loading.json',
                  height: MediaQuery.sizeOf(context).height,
                ),
              )
            : Center(
                child: Container(
                  child: recorderImagesFinalResult.isNotEmpty
                      ? CarouselSlider.builder(
                          options: CarouselOptions(
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            height: 400,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.4,
                            scrollPhysics: const BouncingScrollPhysics(),
                          ),
                          itemCount: recorderImagesFinalResult.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              Container(
                            width: 500,
                            height: 500,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12.r),
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                    '${AppValuesManager.baseUrl}/public/${recorderImagesFinalResult[itemIndex]}',
                                  )),
                            ),
                            child: Text(itemIndex.toString()),
                          ),
                        )
                      : Text(
                          'An Error Occured',
                          style: TextStyle(fontSize: 30.sp, color: Colors.red),
                        ),
                ),
              ));
  }
}
