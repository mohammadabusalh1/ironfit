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

class SelectLanguageBody extends StatefulWidget {
  const SelectLanguageBody({super.key});

  @override
  _SelectLanguageBodyState createState() => _SelectLanguageBodyState();
}

class _SelectLanguageBodyState extends State<SelectLanguageBody>
    with SingleTickerProviderStateMixin {
  final TokenService tokenService = TokenService();
  final SharedPreferencesManager prefsManager = SharedPreferencesManager();
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateDashboard();
    tokenService.isLanguageSelected();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

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

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Column(
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
                    Assets.selectLangBackground,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 2,
                  left: 2,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          LocalizationService.translateFromPage(
                              'title', 'selectLang'),
                          style: AppStyles.textCairo(
                              20, Palette.white, FontWeight.bold),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          LocalizationService.translateFromPage(
                              'description', 'selectLang'),
                          style: AppStyles.textCairo(
                              12, Palette.mainAppColorWhite, FontWeight.normal),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        BuildIconButton(
                          text: LocalizationService.translateFromPage(
                              'Arabic', 'selectLang'),
                          onPressed: () {
                            LocalizationService.load('ar');
                            prefsManager.setLanguage('ar').then(
                                  (value) => Navigator.pushNamed(
                                      context, Routes.preLoginScreens),
                                );
                          },
                          backgroundColor: Palette.mainAppColor,
                          textColor: Palette.black,
                          iconColor: Palette.black,
                          icon: Icons.language_outlined,
                          width: Get.width,
                          fontSize: 14,
                        ),
                        const SizedBox(height: 8),
                        BuildIconButton(
                          text: 'English',
                          onPressed: () {
                            LocalizationService.load('en');
                            prefsManager.setLanguage('en').then(
                                  (value) => Navigator.pushNamed(
                                      context, Routes.preLoginScreens),
                                );
                          },
                          backgroundColor: Palette.mainAppColorWhite,
                          textColor: Palette.mainAppColorNavy,
                          iconColor: Palette.mainAppColorNavy,
                          icon: Icons.language_outlined,
                          width: Get.width,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
