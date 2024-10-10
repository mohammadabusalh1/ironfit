import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/coach_card.dart';
import 'package:ironfit/domain/entities/coach.dart';

class CoachList extends StatelessWidget {
  final List<Coach> coaches;
  final void Function(Coach coach)? onCoachTap;

  const CoachList({
    super.key,
    required this.coaches,
    this.onCoachTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: coaches.length,
        itemBuilder: (context, index) {
          final coach = coaches[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Added padding for spacing
            child: CoachCard(
              name: coach.name,
              address: coach.address,
              imagePath: coach.imagePath,
              description: coach.description,
              onTap: () => _onCoachCardTap(coach),
            ),
          );
        },
      ),
    );
  }

  void _onCoachCardTap(Coach coach) {
    if (onCoachTap != null) {
      onCoachTap!(coach); // Call the callback function if it's provided
    } else {
      // Default action if no callback is provided
      // You can navigate or show a dialog, for example
      print("Tapped on coach: ${coach.name}");
    }
  }
}
