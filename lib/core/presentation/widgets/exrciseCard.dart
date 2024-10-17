import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

class ExrciseCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final bool withIconButton;
  final double padding;
  final double spaceBetweenItems;

  const ExrciseCard({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    this.withIconButton = true,
    this.padding = 24,
    this.spaceBetweenItems = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildImage(),
          SizedBox(width: spaceBetweenItems), // Space between image and text content
          buildTextColumn(context),
          SizedBox(width: spaceBetweenItems), // Space between text and icon button
          withIconButton ? buildIconButton(context) : Container(),
        ],
      ),
    );
  }

  // Reusable Image Widget
  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        image,
        width: MediaQuery.of(Get.context!).size.width * 0.24,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }

  // Reusable Text Column Widget
  Widget buildTextColumn(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8), // Space between text and icon row
          buildIconRow(context),
        ],
      ),
    );
  }

  // Reusable Icon and Text Row Widget
  Widget buildIconRow(BuildContext context) {
    return Row(
      children: [
        buildIconText(context, Icons.access_time_filled, subtitle1),
        SizedBox(width: 8), // Space between the two icon-text pairs
        buildIconText(context, Icons.electric_bolt_sharp, subtitle2),
      ],
    );
  }

  // Reusable Icon and Text Widget
  Widget buildIconText(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Palette.primaryColor,
          size: 16,
        ),
        SizedBox(width: 4), // Space between icon and text
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  // Reusable Icon Button Widget
  Widget buildIconButton(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: Palette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      icon: Icon(
        Icons.done_all,
        color: Palette.greenActive,
        size: 24,
      ),
      onPressed: () {
        print('IconButton pressed...');
      },
    );
  }
}
