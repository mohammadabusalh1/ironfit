import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

class ExerciseCarousel extends StatelessWidget {
  final List<Map<String, String>> exercises;

  // Constructor to accept the list of exercises
  ExerciseCarousel({required this.exercises});

  @override
  Widget build(BuildContext context) {
    // Check if exercises are empty
    if (exercises.isEmpty) {
      return Container(
        width: double.infinity,
        height: 200,
        alignment: Alignment.center,
        child: Text(
          'No exercises available',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 200,
      child: CarouselSlider(
        items:
            exercises.map((item) => buildCarouselItem(item, context)).toList(),
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
    // Ensure that the keys exist before accessing them
    String image = item['image'] ?? 'https://example.com/default_image.jpg';
    String title = item['name'] ?? 'No Name';
    String subtitle = item['subtitle'] ?? 'No Info Available';

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            image, // Changed to network to load from URL, replace with asset if needed
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
                buildText(title, context, true),
                buildText(subtitle, context, false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildText(String text, BuildContext context, bool isTitle) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Text(
          textAlign: TextAlign.end,
          text,
          style: TextStyle(
            color: isTitle ? Palette.white : Colors.grey,
            fontSize: isTitle ? 14 : 12,
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
        ),
      ),
    );
  }
}
