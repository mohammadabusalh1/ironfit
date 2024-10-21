import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

Widget buildCarouselItem(Map<String, String> item, {double? padding}) {
  // Ensure that the keys exist before accessing them
  String image = item['image'] ?? item['Exercise_Image'] ?? Assets.notFound;
  String title = item['name'] ?? item['Exercise_Name'] ?? 'No Name';
  String subtitle = item['subtitle'] ?? '';

  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          image.isEmpty ? Assets.notFound : image, // Changed to network to load from URL, replace with asset if needed
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
      Align(
        alignment: AlignmentDirectional.bottomStart,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, padding ?? 150, 0, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(title, true),
              buildText(subtitle, false),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildText(String text, bool isTitle) {
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
