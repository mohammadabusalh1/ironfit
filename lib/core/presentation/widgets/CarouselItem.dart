import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

Widget buildCarouselItem(Map<String, String> item,
    {double? padding, bool isSelected = false}) {
  String image = item['image'] ?? item['gifUrl'] ?? Assets.notFound;
  String title = item['name'] ?? item['Exercise_Name'] ?? 'No Name';

  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          image.isEmpty ? Assets.notFound : image,
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height * 0.3,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Placeholder(
              fallbackWidth: 200,
              fallbackHeight: 200,
            );
          },
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
            ],
          ),
        ),
      ),
      if (isSelected) // Show a mark or check icon when isSelected is true
        Positioned(
          top: 8,
          right: 8,
          child: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 24,
          ),
        ),
    ],
  );
}

Widget buildText(String text, bool isTitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Align(
      alignment: AlignmentDirectional.topEnd,
      child: Text(
        textAlign: TextAlign.end,
        text.length > 17 ? '...${text.substring(0, 17)}' : text,
        style: TextStyle(
          color: isTitle ? Palette.mainAppColorWhite : Palette.gray,
          fontSize: isTitle ? 14 : 12,
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
          shadows: isTitle
              ? [
                  const Shadow(
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
