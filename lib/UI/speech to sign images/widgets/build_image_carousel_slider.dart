import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/api_constants.dart';

class BuildImageCarouselSlider extends StatelessWidget {
  final int itemCount;

  final List<String> images;

  const BuildImageCarouselSlider(
      {super.key, required this.itemCount, required this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
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
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
        enlargeCenterPage: true,
        enlargeFactor: 0.4,
        scrollPhysics: const BouncingScrollPhysics(),
      ),
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
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
                '${ApiConstants.baseUrl}/public/${images[itemIndex]}',
              )),
        ),
        child: Text(itemIndex.toString()),
      ),
    );
  }
}
