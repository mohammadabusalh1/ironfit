import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/assets.dart';

class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({super.key});

  @override
  _AnimatedScreenState createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late Animation<double> _logoScaleAnimation;

  late AnimationController _imageFadeController;
  late Animation<double> _imageFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the logo animation controller
    _logoAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _logoScaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    _logoAnimationController.forward();

    // Initialize the fade animation for header image
    _imageFadeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _imageFadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_imageFadeController);

    _imageFadeController.forward();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _imageFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _imageFadeAnimation,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          Assets.ironFitLogo,
          width: 300.0,
          height: 120.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
