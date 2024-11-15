import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/assets.dart';

class HeaderImage extends StatelessWidget {
  final double high;
  final double width;
  final double borderRadius;
  final String headerImage;
  const HeaderImage({
    Key? key,
    this.high = 0,
    this.borderRadius = 8,
    this.headerImage = Assets.header,
    this.width = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            headerImage,
            width: width == 0 ? double.infinity : width,
            height:
                high == 0 ? MediaQuery.of(context).size.height * 0.25 : high,
            fit: BoxFit.cover,
          ),
          Container(
            width: width == 0 ? double.infinity : width,
            height: high == 0 ? MediaQuery.of(context).size.height * 0.25 : high,
            color:
                Colors.black.withOpacity(0.7), // Black filter with 50% opacity
          ),
        ],
      ),
    );
  }
}
