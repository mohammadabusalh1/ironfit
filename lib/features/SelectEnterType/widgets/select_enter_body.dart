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

class SelectEnterBody extends StatefulWidget {
  const SelectEnterBody({super.key});

  @override
  _SelectEnterBodyState createState() => _SelectEnterBodyState();
}

class _SelectEnterBodyState extends State<SelectEnterBody>
    with SingleTickerProviderStateMixin {
  final TokenService tokenService = TokenService();
  final SharedPreferencesManager prefsManager = SharedPreferencesManager();
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateDashboard();
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
            height: MediaQuery.of(context).size.height * 0.96,
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
                              'title', 'selectEnter'),
                          style: AppStyles.textCairo(
                              24, Palette.white, FontWeight.bold),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          LocalizationService.translateFromPage(
                              'description', 'selectEnter'),
                          style: AppStyles.textCairo(
                              14, Palette.mainAppColorWhite, FontWeight.normal),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        BuildIconButton(
                          text:
                              LocalizationService.translateFromGeneral('login'),
                          onPressed: () {
                            Get.toNamed(Routes.singIn);
                          },
                          backgroundColor: Palette.mainAppColor,
                          textColor: Palette.white,
                          icon: Icons.login_outlined,
                          iconSize: 20,
                          width: Get.width,
                        ),
                        SizedBox(height: 12),
                        BuildIconButton(
                          text: LocalizationService.translateFromGeneral(
                              'create_account'),
                          onPressed: () {
                            Get.toNamed(Routes.singUp);
                          },
                          backgroundColor: Palette.mainAppColorWhite,
                          textColor: Palette.mainAppColorNavy,
                          iconColor: Palette.mainAppColorNavy,
                          icon: Icons.person_add_alt_1_outlined,
                          iconSize: 20,
                          width: Get.width,
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
