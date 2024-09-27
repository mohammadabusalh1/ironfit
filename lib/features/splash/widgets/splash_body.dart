import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/style/assets.dart';


class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                Assets.IronFitLogo2,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCard(BuildContext context, String day) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: const Color(0x38454038),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFFFFBB02),
                      fontSize: 14,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'ظهر + باي',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0x93FFFFFF),
                      fontSize: 10,
                      letterSpacing: 0.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.date_range,
                color: Colors.white,
                size: 40,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
