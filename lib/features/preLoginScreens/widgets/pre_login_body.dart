import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/style/assets.dart';

class PreLoginBody extends StatefulWidget {
  const PreLoginBody({super.key});

  @override
  _PreLoginBodyState createState() => _PreLoginBodyState();
}

class _PreLoginBodyState extends State<PreLoginBody> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        _buildPage(
                          imagePath: Assets.preLogin1,
                          text:
                              'سهلنا عليك، قم بإدارة المتدربين والخطط الخاصة بك',
                          showNextButton: true,
                        ),
                        _buildPage(
                          imagePath: Assets.preLogin2,
                          text:
                              'سهلنا عليك، قم بإدارة المتدربين والخطط الخاصة بك',
                          showNextButton: true,
                        ),
                        _buildPage(
                          imagePath: Assets.preLogin3,
                          text:
                              'سهلنا عليك، قم بإدارة المتدربين والخطط الخاصة بك',
                          showNextButton: false,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildPageIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
      {required String imagePath,
      required String text,
      required bool showNextButton}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 20, 110),
                  child: Text(
                    text,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontSize: 21,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          color: Color(0xFF1B1B1B),
                          offset: Offset(4.0, 4.0),
                          blurRadius: 4.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (showNextButton)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                    child: _buildButton(
                      text: 'التالي',
                      icon: Icons.west,
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  ),
                ),
              if (!showNextButton)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton(
                          text: 'إنهاء',
                          icon: Icons.west,
                          onPressed: () {
                            // Handle finish action
                          },
                          width: MediaQuery.of(context).size.width * 0.40,
                          backgroundColor: Colors.white,
                          textColor: const Color(0xFF1C1503),
                        ),
                        const SizedBox(width: 24),
                        _buildButton(
                          text: '',
                          icon: Icons.east,
                          onPressed: () {
                            _pageController
                                .previousPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.ease,
                            )
                                .then((value) {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.ease,
                              );
                            });
                          },
                          width: MediaQuery.of(context).size.width * 0.40,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    Color backgroundColor = const Color(0xFFFFBB02),
    Color textColor = const Color(0xFF1C1503),
    double width = double.infinity,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 26, color: textColor),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        minimumSize: Size(width, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index
                ? const Color(0xFFFFBB02)
                : const Color(0xFFFFBB02).withOpacity(0.5),
            border: Border.all(color: const Color(0xFFFFBB02)),
          ),
        ),
      ),
    );
  }
}
