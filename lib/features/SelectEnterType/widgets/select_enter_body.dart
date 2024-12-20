import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectEnterBody extends StatefulWidget {
  const SelectEnterBody({super.key});

  @override
  _SelectEnterBodyState createState() => _SelectEnterBodyState();
}

class _SelectEnterBodyState extends State<SelectEnterBody>
    with SingleTickerProviderStateMixin {
  final TokenService tokenService = TokenService();
  PreferencesService preferencesService = PreferencesService();
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  int stage = 1;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateDashboard();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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
  void dispose() {
    // Make sure to dispose the controller before calling super.dispose()
    _controller.dispose();
    super.dispose();
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
                    Assets.enterPageImage,
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
                        stage == 1
                            ? Text(
                                textAlign: TextAlign.center,
                                LocalizationService.translateFromGeneral(
                                    'areYouCoach'),
                                style: AppStyles.textCairo(
                                    24, Palette.white, FontWeight.bold),
                              )
                            : Container(),
                        stage == 2
                            ? Text(
                                textAlign: TextAlign.center,
                                LocalizationService.translateFromPage(
                                    'title', 'selectEnter'),
                                style: AppStyles.textCairo(
                                    24, Palette.white, FontWeight.bold),
                              )
                            : Container(),
                        Text(
                          textAlign: TextAlign.center,
                          LocalizationService.translateFromPage(
                              'description', 'selectEnter'),
                          style: AppStyles.textCairo(
                              14, Palette.mainAppColorWhite, FontWeight.normal),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        stage == 2
                            ? BuildIconButton(
                                text: LocalizationService.translateFromGeneral(
                                    'login'),
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.singIn);
                                },
                                backgroundColor: Palette.mainAppColor,
                                textColor: Palette.black,
                                icon: Icons.person_2_outlined,
                                iconColor: Palette.black,
                                iconSize: 18,
                                width: MediaQuery.of(context).size.width,
                                fontSize: 14,
                              )
                            : Container(),
                        const SizedBox(height: 8),
                        stage == 2
                            ? BuildIconButton(
                                text: LocalizationService.translateFromGeneral(
                                    'create_account'),
                                onPressed: () {
                                  Get.toNamed(Routes.singUp);
                                },
                                backgroundColor: Palette.mainAppColorWhite,
                                textColor: Palette.mainAppColorNavy,
                                iconColor: Palette.mainAppColorNavy,
                                icon: Icons.person_add_alt_1_outlined,
                                iconSize: 18,
                                width: MediaQuery.of(context).size.width,
                                fontSize: 14,
                              )
                            : Container(),
                        stage == 1
                            ? BuildIconButton(
                                text: LocalizationService.translateFromGeneral(
                                    'coach'),
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await preferencesService.getPreferences();
                                  setState(() {
                                    prefs.setBool('isCoach', true);
                                    stage = 2;
                                  });
                                },
                                backgroundColor: Palette.mainAppColor,
                                textColor: Palette.black,
                                iconColor: Palette.black,
                                icon: Icons.fitness_center,
                                iconSize: 18,
                                width: MediaQuery.of(context).size.width,
                                fontSize: 16,
                              )
                            : Container(),
                        const SizedBox(height: 8),
                        stage == 1
                            ? BuildIconButton(
                                text: LocalizationService.translateFromGeneral(
                                    'trainee'),
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await preferencesService.getPreferences();
                                  setState(() {
                                    prefs.setBool('isCoach', false);
                                    stage = 2;
                                  });
                                },
                                backgroundColor: Palette.mainAppColorWhite,
                                textColor: Palette.mainAppColorNavy,
                                iconColor: Palette.mainAppColorNavy,
                                icon: Icons.directions_run_outlined,
                                iconSize: 18,
                                width: MediaQuery.of(context).size.width,
                                fontSize: 16,
                              )
                            : Container(),
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
