import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

class ExrciseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildImage(),
          SizedBox(width: 24), // Space between image and text content
          buildTextColumn(context),
          SizedBox(width: 24), // Space between text and icon button
          buildIconButton(context),
        ],
      ),
    );
  }

  // Reusable Image Widget
  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        'https://picsum.photos/seed/551/600',
        width: 94,
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
            'Rickshaw Carry',
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
        buildIconText(context, Icons.access_time_filled, '3 جولات'),
        SizedBox(width: 8), // Space between the two icon-text pairs
        buildIconText(context, Icons.electric_bolt_sharp, '12 تكرار'),
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
        backgroundColor: Palette.greenBackGround,
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
