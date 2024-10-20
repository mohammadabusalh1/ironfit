import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ironfit/core/presentation/widgets/CarouselItem.dart';

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
            exercises.map((item) => buildCarouselItem(item)).toList(),
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

}
