import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/ExerciseListWidget.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/features/createPlan/widgets/create_plan_body.dart';
import 'package:ironfit/features/editPlan/widgets/buildTextField.dart';

class ExerciseDialog extends StatefulWidget {
  final Function addExercise;

  const ExerciseDialog(
      {super.key, required this.addExercise});

  @override
  _ExerciseDialogState createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {
  String selectedExerciseName =
      ''; // State variable to track selected exercise name
  String selectedExerciseImage = '';
  String rounds = '';
  String repetitions = '';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dialogBackgroundColor: Colors.grey[900],
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Palette.white, fontSize: 16),
          bodyMedium: TextStyle(color: Palette.white, fontSize: 14),
          headlineLarge: TextStyle(
              color: Palette.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.mainAppColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title:
               Text(LocalizationService.translateFromGeneral(
                  'addExercise'), style: const TextStyle(color: Palette.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.mainAppColorWhite,
                  ),
                  onPressed: () async {
                    // Open the ExercisesScreen dialog and wait for selected exercise
                    final val = await showDialog(
                        context: context,
                        builder: (context) =>
                            _buildTrainDialog());

                    // If an exercise is selected, update the state to reflect it
                    if (val != null) {
                      setState(() {
                        selectedExerciseName = val['Exercise_Name'];
                        selectedExerciseImage = val['Exercise_Image'];
                      });
                    }
                  },
                  child:  Text(LocalizationService.translateFromGeneral(
                  'selectExercise'),
                      style: const TextStyle(color: Palette.black)),
                ),
                const SizedBox(height: 16),
                // Display the selected exercise name
                if (selectedExerciseName.isNotEmpty)
                  Text(
                    selectedExerciseName,
                    style: const TextStyle(color: Palette.white),
                  ),
                const SizedBox(height: 16),
                BuildTextField(
                  onChange: (value) => setState(() {
                    rounds = value;
                  }),
                  label: LocalizationService.translateFromGeneral(
                  'rounds'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                BuildTextField(
                  onChange: (value) => setState(() {
                    repetitions = value;
                  }),
                  label:  LocalizationService.translateFromGeneral(
                  'repetitions'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // If the exercise is selected, add it to the training day
                if (selectedExerciseName.isNotEmpty) {
                  Exercise exercise = Exercise(
                    name: selectedExerciseName,
                    image: selectedExerciseImage,
                    rounds: int.parse(rounds),
                    repetitions: int.parse(repetitions),
                  );
                  widget.addExercise(exercise);
                }
              },
              child: Text(LocalizationService.translateFromGeneral('save'),
                  style: const TextStyle(color: Palette.black)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LocalizationService.translateFromGeneral('cancel'),
                  style: const TextStyle(color: Palette.white)),
            ),
          ],
          actionsAlignment: MainAxisAlignment.start,
        ),
      ),
    );
  }

  Widget _buildTrainDialog() {
    return Theme(
      data: Theme.of(context).copyWith(
        dialogBackgroundColor: Colors.grey[900],
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Palette.white, fontSize: 16),
          bodyMedium: TextStyle(color: Palette.white, fontSize: 14),
          headlineLarge: TextStyle(
            color: Palette.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.mainAppColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(
              LocalizationService.translateFromGeneral(
                  'selectExercise'),
              style: const TextStyle(color: Palette.white, fontSize: 20)),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ExercisesScreen(
                fileName: 'back_exercises',
              ),
            );
          }),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LocalizationService.translateFromGeneral('cancel'),
                  style: const TextStyle(color: Palette.white)),
            ),
          ],
          actionsAlignment: MainAxisAlignment.start,
        ),
      ),
    );
  }
}
