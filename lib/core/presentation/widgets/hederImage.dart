import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/assets.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.asset(
            Assets.header,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            fit: BoxFit.fill,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            color:
                Colors.black.withOpacity(0.8), // Black filter with 50% opacity
          ),
        ],
      ),
    );
  }
}
