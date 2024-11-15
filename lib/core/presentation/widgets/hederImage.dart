import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/assets.dart';

class HeaderImage extends StatelessWidget {
  final double high;
  final double borderRadius;
  const HeaderImage({
    Key? key,
    this.high = 0,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            Assets.header,
            width: MediaQuery.of(context).size.width,
            height:
                high == 0 ? MediaQuery.of(context).size.height * 0.25 : high,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            height: high == 0 ? MediaQuery.of(context).size.height * 0.25 : high,
            color:
                Colors.black.withOpacity(0.7), // Black filter with 50% opacity
          ),
        ],
      ),
    );
  }
}
