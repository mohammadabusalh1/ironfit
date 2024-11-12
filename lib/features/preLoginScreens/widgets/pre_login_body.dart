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
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
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
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _positionAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
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
            height: Get.height,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {});
              },
              children: [
                _buildPage(
                  imagePath: Assets.preLogin1,
                  text: LocalizationService.translateFromPage(
                      'page1Title', 'preLogin'),
                  decription: LocalizationService.translateFromPage(
                    'page1',
                    'preLogin',
                  ),
                  showNextButton: true,
                ),
                _buildPage(
                  imagePath: Assets.preLogin2,
                  text: LocalizationService.translateFromPage(
                      'page2Title', 'preLogin'),
                  decription: LocalizationService.translateFromPage(
                    'page2',
                    'preLogin',
                  ),
                  showNextButton: true,
                ),
                _buildPage(
                  imagePath: Assets.preLogin3,
                  text: LocalizationService.translateFromPage(
                    'page3Title',
                    'preLogin',
                  ),
                  decription: LocalizationService.translateFromPage(
                      'page3', 'preLogin'),
                  showNextButton: false,
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
      required bool showNextButton,
      required String decription}) {
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
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: SlideTransition(
                    position: _positionAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            text,
                            textAlign: TextAlign.start,
                            style: AppStyles.textCairo(
                                20, Palette.white, FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            decription,
                            textAlign: TextAlign.start,
                            style: AppStyles.textCairo(
                                12,
                                Palette.mainAppColorWhite.withOpacity(0.8),
                                FontWeight.normal),
                          ),
                          const SizedBox(height: 32),
                          if (showNextButton)
                            Align(
                              alignment: dir == 'ltr'
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              child: BuildIconButton(
                                text: LocalizationService.translateFromGeneral(
                                    'next'),
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                                width: Get.width * 0.4,
                                height: 45,
                                fontSize: 14,
                                textColor: Palette.subTitleBlack,
                                borderRadius: 25,
                              ),
                            ),
                          if (!showNextButton)
                            Align(
                              alignment: dir == 'ltr'
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              child: BuildIconButton(
                                text: LocalizationService.translateFromGeneral(
                                    'startNow'),
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setBool('hasSeenPreLoginScreen', true);
                                  Get.toNamed(Routes.selectEnter);
                                },
                                width: MediaQuery.of(context).size.width * 0.4,
                                backgroundColor: Palette.mainAppColorWhite,
                                textColor: Palette.black,
                                height: 45,
                                fontSize: 14,
                                borderRadius: 25,
                              ),
                            ),
                          const SizedBox(height: 24),
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
