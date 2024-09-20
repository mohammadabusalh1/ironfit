import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/widgets/coach_card.dart';
import 'package:ironfit/domain/enteites/coach.dart';


class CoachList extends StatelessWidget {
  final List<Coach> coaches;

  const CoachList({super.key, required this.coaches});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: coaches.length,
        itemBuilder: (context, index) {
          final coach = coaches[index];
          return CoachCard(
            name: coach.name,
            address: coach.address,
            imagePath: coach.imagePath,
            description: coach.description,
            onTap: () {
              // Define what happens when the card is tapped
            },
          );
        },
      ),
    );
  }
}
