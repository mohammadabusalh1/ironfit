import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/assets.dart';

class HeaderImage extends StatelessWidget {
  final double high;
  const HeaderImage({
    Key? key,
    this.high = 0, // Specify 'high' as a required parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.asset(
            Assets.header,
            width: double.infinity,
            height:
                high == 0 ? MediaQuery.of(context).size.height * 0.25 : high,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            height: high == 0 ? MediaQuery.of(context).size.height * 0.25 : high,
            color:
                Colors.black.withOpacity(0.8), // Black filter with 50% opacity
          ),
        ],
      ),
    );
  }
}
