import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:flutter/animation.dart';

class DashboardHeader extends StatelessWidget {
  final String backgroundImage; // Background image path.
  final String trainerImage; // Trainer image path.
  final String trainerName; // Trainer's name.
  final String trainerEmail; // Trainer's email.

  const DashboardHeader({
    super.key,
    required this.backgroundImage,
    required this.trainerImage,
    required this.trainerName,
    required this.trainerEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildBackgroundImage(context),
        _buildTrainerInfo(context),
      ],
    );
  }

  // Builds the background image widget with fade animation
  Widget _buildBackgroundImage(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0, // Fade in effect
      duration: Duration(seconds: 2),
      child: ClipRRect(
        child: Image.asset(
          backgroundImage,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Builds the trainer info and notification button
  Widget _buildTrainerInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          24, MediaQuery.of(context).size.height * 0.03, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTrainerImage(context),
          const SizedBox(width: 16),
          TrainerInfo(trainerName: trainerName, trainerEmail: trainerEmail),
          Spacer(),
          _buildNotificationButton(),
        ],
      ),
    );
  }

  // Builds the trainer image widget with scale animation
  Widget _buildTrainerImage(BuildContext context) {
    return AnimatedScale(
      scale: 1.1, // Scale animation on hover/tap
      duration: Duration(seconds: 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
            trainerImage,
            width: MediaQuery.of(context).size.width * 0.16,
            height: MediaQuery.of(context).size.height * 0.08,
            fit: BoxFit.cover),
      ),
    );
  }

  // Builds the notification button with rotation animation
  Widget _buildNotificationButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 40,
        height: 40,
        color: Palette.mainAppColor,
        child: IconButton(
          onPressed: () {
            // Handle notification button action
          },
          icon: AnimatedRotation(
            turns: 1,
            duration: Duration(seconds: 1),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 24,
            ),
          ),
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
        _buildTrainerName(),
        _buildTrainerEmail(),
      ],
    );
  }

  // Builds the trainer's name text widget with fade animation
  Widget _buildTrainerName() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(seconds: 2),
      child: Text(
        trainerName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Builds the trainer's email text widget
  Widget _buildTrainerEmail() {
    return Text(
      trainerEmail,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
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
      duration: Duration(seconds: 1),
      child: AnimatedOpacity(
        opacity: 1.0, // Fade in effect
        duration: Duration(seconds: 1),
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
        AlwaysStoppedAnimation(1)
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
