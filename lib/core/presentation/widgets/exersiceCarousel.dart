import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ironfit/core/presentation/style/assets.dart';

class ExerciseCarousel extends StatelessWidget {
  final List<Map<String, String>> carouselItems = [
    {
      'image': Assets.preLogin1,
      'title': 'Rickshaw Carry',
      'subtitle': 'Wednesday',
    },
    {
      'image': Assets.preLogin2,
      'title': 'Single Leg Press',
      'subtitle': 'Thursday',
    },
    {
      'image': Assets.preLogin3,
      'title': 'Landmine Twist',
      'subtitle': 'Friday',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: CarouselSlider(
        items: carouselItems
            .map((item) => buildCarouselItem(item, context))
            .toList(),
        options: CarouselOptions(
          initialPage: 1,
          viewportFraction: 0.5,
          disableCenter: true,
          enlargeCenterPage: true,
          enlargeFactor: 0.25,
          enableInfiniteScroll: true,
          scrollDirection: Axis.horizontal,
          autoPlay: false,
        ),
      ),
    );
  }

  Widget buildCarouselItem(Map<String, String> item, BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            item['image']!,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomStart,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(item['title']!, context, true),
                buildText(item['subtitle']!, context, false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildText(String text, BuildContext context, bool isTitle) {
    return Text(
      text,
      style: TextStyle(
        color: isTitle ? Colors.white : Colors.grey[400],
        fontSize: isTitle ? 16 : 12,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
        shadows: isTitle
            ? [
                Shadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 2,
                ),
              ]
            : null,
      ),
    );
  }
}
