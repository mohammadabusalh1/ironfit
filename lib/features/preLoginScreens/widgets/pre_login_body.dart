import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                              'تسجيل سلس للمتدربين وتتبع التمارين كل ذلك في منصة واحدة',
                          showNextButton: true,
                        ),
                        _buildPage(
                          imagePath: Assets.preLogin2,
                          text:
                              'يقوم المدربون بإنشاء خطط تمرين مخصصة مصممة خصيصًا لتلبية الأهداف الخاصة لكل متدرب',
                          showNextButton: true,
                        ),
                        _buildPage(
                          imagePath: Assets.preLogin3,
                          text:
                              'ابدأ التدريب المخصص وتتبع التقدم، مما يجعل إدارة اللياقة البدنية أسهل لكل من المدربين والمتدربين',
                          showNextButton: false,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
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
          height: MediaQuery.of(context).size.height * 0.96,
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
              Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        text,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontSize: 16,
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
                      const SizedBox(height: 24),
                      if (showNextButton)
                        Align(
                          alignment: Alignment.bottomCenter,
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
                      if (!showNextButton)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildButton(
                                text: 'ابدأ الآن',
                                icon: Icons.west,
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setBool('hasSeenPreLoginScreen', true);
                                  Get.toNamed(Routes.singUp);
                                },
                                width: MediaQuery.of(context).size.width * 0.85,
                                backgroundColor: Palette.mainAppColorWhite,
                                textColor: Palette.black,
                              ),
                            ],
                          ),
                        ),
                    ],
                  )),
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
    Color backgroundColor = Palette.mainAppColor,
    Color textColor = Palette.white,
    double width = double.infinity,
    IconAlignment iconAlignment = IconAlignment.end,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon:
          Opacity(opacity: 0.8, child: Icon(icon, size: 24, color: textColor)),
      label: Opacity(opacity: 0.8, child: Text(text)),
      iconAlignment: iconAlignment,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        minimumSize: Size(width, 48),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
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
