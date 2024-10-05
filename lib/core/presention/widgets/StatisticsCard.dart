import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/style/palette.dart';

// Reusable StatisticsCard Widget
class StatisticsCard extends StatelessWidget {
  final String cardSubTitle;
  final String cardTitle;
  final double width;
  final double height;

  const StatisticsCard({
    Key? key,
    required this.cardSubTitle,
    required this.cardTitle,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Palette.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(cardSubTitle,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            Text(cardTitle,
                style: const TextStyle(
                    fontSize: 14,
                    color: Palette.mainAppColor,
                    fontWeight: FontWeight.w800)),
          ],
        ));
  }
}
