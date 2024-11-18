import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:lottie/lottie.dart';

class DashboardHeader extends StatelessWidget {
  final String trainerImage; // Trainer image path.

  const DashboardHeader({
    super.key,
    required this.trainerImage,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTrainerInfo(context);
  }

  // Builds the trainer info and notification button
  Widget _buildTrainerInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTrainerImage(context),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.chat);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Palette.mainAppColor,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Text(
                    LocalizationService.translateFromGeneral(
                        'communicateWithTrainees'),
                    style: AppStyles.textCairo(
                        12, Palette.white, FontWeight.bold)),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Lottie.asset(
                    'assets/jsonIcons/chat.json',
                    width: 10,
                    height: 10,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  // Builds the trainer image widget with scale animation
  Widget _buildTrainerImage(BuildContext context) {
    return AnimatedScale(
      scale: 1.1, // Scale animation on hover/tap
      duration: const Duration(seconds: 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          imageUrl: trainerImage,
          width: 55,
          height: 55,
          fit: BoxFit.cover,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}

// Reusable TrainerInfo Widget with fade text animation
class TrainerInfo extends StatelessWidget {
  final String trainerName; // Trainer's name.
  final String trainerEmail; // Trainer's email.

  const TrainerInfo({
    super.key,
    required this.trainerName,
    required this.trainerEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTrainerName(context),
        _buildTrainerEmail(context),
      ],
    );
  }

  // Builds the trainer's name text widget with fade animation
  Widget _buildTrainerName(BuildContext context) {
    return AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(seconds: 2),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            trainerName.length > 12
                ? '...${trainerName.substring(0, 12)}'
                : trainerName,
            style: AppStyles.textCairo(
              16,
              Palette.mainAppColorWhite,
              FontWeight.bold,
            ),
          ),
        ));
  }

  // Builds the trainer's email text widget
  Widget _buildTrainerEmail(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Text(
        trainerEmail.length > 20
            ? '...${trainerEmail.substring(0, 20)}'
            : trainerEmail,
        style: AppStyles.textCairo(
          12,
          Palette.gray,
          FontWeight.w500,
        ),
      ),
    );
  }
}

// Scale and fade animation for the logo
class LogoWidget extends StatelessWidget {
  final String logoPath;

  const LogoWidget({super.key, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: 1.2, // Scale effect
      duration: const Duration(seconds: 1),
      child: AnimatedOpacity(
        opacity: 1.0, // Fade in effect
        duration: const Duration(seconds: 1),
        child: Image.asset(
          logoPath,
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// 3D effect widget on the core pages
class DashboardCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const DashboardCard({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        const AlwaysStoppedAnimation(1)
      ]), // This can be replaced with actual animation logic
      builder: (context, child) {
        return Transform(
          transform: Matrix4.rotationZ(0.1)..scale(1.1),
          child: child,
        );
      },
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            Image.asset(imagePath),
            Text(title),
          ],
        ),
      ),
    );
  }
}
