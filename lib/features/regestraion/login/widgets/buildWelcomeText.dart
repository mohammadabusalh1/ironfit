import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

class WelcomeText extends StatefulWidget {
  @override
  _AnimatedWelcomeText createState() => _AnimatedWelcomeText();
}

class _AnimatedWelcomeText extends State<WelcomeText>
    with TickerProviderStateMixin {
  // Controllers for various animations
  late AnimationController _textTypewriterController;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Typewriter Effect for Text (Custom typewriter behavior)
    _textTypewriterController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textTypewriterController,
        curve: Curves.easeIn,
      ),
    );

    _textTypewriterController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return _buildWelcomeText(context);
  }

  // Typewriter effect for text
  Widget _buildWelcomeText(BuildContext context) {
    return FadeTransition(
      opacity: _textFadeAnimation,
      child: Text(
        textAlign: TextAlign.center,
        LocalizationService.translateFromGeneral('welcome_message'),
        style: AppStyles.textCairo(
            16, Palette.mainAppColorWhite, FontWeight.w700),
      ),
    );
  }
}
