import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/presention/widgets/custom_text_widget.dart';

class CoachCard extends StatelessWidget {
  final String name;
  final String address;
  final String imagePath;
  final String description;
  final VoidCallback onTap;

  const CoachCard({
    super.key,
    required this.name,
    required this.address,
    required this.imagePath,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Palette.mainAppColor,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(text: name , fontWeight : FontWeight.bold,fontSize: 20,color:Palette.black,),
                    CustomTextWidget(text: address,color: Palette.subTitleBlack,),
                    CustomTextWidget(text: description,color: Palette.subTitleBlack,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
