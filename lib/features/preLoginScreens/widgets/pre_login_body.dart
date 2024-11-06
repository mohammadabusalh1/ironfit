import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/preferences_manager.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreLoginBody extends StatefulWidget {
  const PreLoginBody({super.key});

  @override
  _PreLoginBodyState createState() => _PreLoginBodyState();
}

class _PreLoginBodyState extends State<PreLoginBody>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _opacityAnimation;
  final TokenService tokenService = TokenService();
  final SharedPreferencesManager prefsManager = SharedPreferencesManager();

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateDashboard();
    _initializePreferences();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _positionAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom
      end: const Offset(0, 0), // End at original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully opaque
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // Start animation when widget is first rendered
    _controller.forward();
  }

  Future<void> _initializePreferences() async {
    print(await prefsManager.getLanguage());
    String languageCode =
        await prefsManager.getLanguage() ?? 'en'; // Default to 'en'
    LocalizationService.load(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {});
                  },
                  children: [
                    _buildPage(
                      imagePath: Assets.preLogin1,
                      text: LocalizationService.translateFromPage(
                          'page1', 'preLogin'),
                      showNextButton: true,
                    ),
                    _buildPage(
                      imagePath: Assets.preLogin2,
                      text: LocalizationService.translateFromPage(
                          'page2', 'preLogin'),
                      showNextButton: true,
                    ),
                    _buildPage(
                      imagePath: Assets.preLogin3,
                      text: LocalizationService.translateFromPage(
                          'page3', 'preLogin'),
                      showNextButton: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: SlideTransition(
                    position: _positionAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            text,
                            textAlign: TextAlign.center,
                            style: AppStyles.textCairo(
                                16, Palette.white, FontWeight.bold),
                          ),
                          const SizedBox(height: 28),
                          if (showNextButton)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: BuildIconButton(
                                text: LocalizationService.translateFromGeneral(
                                    'next'),
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                                width: Get.width,
                              ),
                            ),
                          if (!showNextButton)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BuildIconButton(
                                    text: LocalizationService
                                        .translateFromGeneral('startNow'),
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool(
                                          'hasSeenPreLoginScreen', true);
                                      Get.toNamed(Routes.selectEnter);
                                    },
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    backgroundColor: Palette.mainAppColorWhite,
                                    textColor: Palette.black,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
