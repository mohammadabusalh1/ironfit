import 'package:flutter/material.dart';

// Reusable DashboardHeader Widget
class DashboardHeader extends StatelessWidget {
  final String backgroundImage;
  final String trainerImage;
  final String trainerName;
  final String trainerEmail;

  const DashboardHeader({
    Key? key,
    required this.backgroundImage,
    required this.trainerImage,
    required this.trainerName,
    required this.trainerEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            backgroundImage,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 12,
          top: MediaQuery.of(context).size.height * 0.07,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  trainerImage,
                  width: MediaQuery.of(context).size.height * 0.09,
                  height: MediaQuery.of(context).size.height * 0.09,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              TrainerInfo(
                trainerName: trainerName,
                trainerEmail: trainerEmail,
              ),
              const SizedBox(width: 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.black54,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Reusable TrainerInfo Widget
class TrainerInfo extends StatelessWidget {
  final String trainerName;
  final String trainerEmail;

  const TrainerInfo({
    Key? key,
    required this.trainerName,
    required this.trainerEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trainerName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          trainerEmail,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
