import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

// Reusable DashboardHeader Widget
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

  // Builds the background image widget
  Widget _buildBackgroundImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        backgroundImage,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
        fit: BoxFit.cover,
      ),
    );
  }

  // Builds the trainer info and notification button
  Widget _buildTrainerInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTrainerImage(context),
        const SizedBox(width: 12),
        TrainerInfo(trainerName: trainerName, trainerEmail: trainerEmail),
        const SizedBox(width: 40),
        _buildNotificationButton(),
      ],
    );
  }

  // Builds the trainer image widget
  Widget _buildTrainerImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        trainerImage,
        width: MediaQuery.of(context).size.height * 0.09,
        height: MediaQuery.of(context).size.height * 0.09,
        fit: BoxFit.cover,
      ),
    );
  }

  // Builds the notification button
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
          icon: const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}

// Reusable TrainerInfo Widget
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

  // Builds the trainer's name text widget
  Widget _buildTrainerName() {
    return Text(
      trainerName,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
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
