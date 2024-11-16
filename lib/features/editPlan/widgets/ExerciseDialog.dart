import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/ExerciseListWidget.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/theme.dart';
import 'package:ironfit/features/createPlan/widgets/create_plan_body.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';

class ExerciseDialog extends StatefulWidget {
  final Function addExercise;

  const ExerciseDialog({super.key, required this.addExercise});

  @override
  _ExerciseDialogState createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {
  List<dynamic> selectedExercises = [];
  String rounds = '';
  String repetitions = '';
  late String dir;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dir = LocalizationService.getDir();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: customThemeData,
      child: Directionality(
        textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text(LocalizationService.translateFromGeneral('addExercise'),
              style: const TextStyle(color: Palette.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BuildIconButton(
                    width: MediaQuery.of(context).size.width,
                    fontSize: 12,
                    text: LocalizationService.translateFromGeneral(
                        'selectExercise'),
                    backgroundColor: Palette.mainAppColorWhite,
                    textColor: Palette.mainAppColorNavy,
                    onPressed: () async {
                      // Open the ExercisesScreen dialog and wait for selected exercise
                      final val = await showDialog(
                          context: context,
                          builder: (context) => ExercisesScreen(
                                fileName: 'back_exercises',
                              ));

                      // If an exercise is selected, update the state to reflect it
                      if (val != null) {
                        setState(() {
                          selectedExercises = val;
                        });
                      }
                    }),
                // Display the selected exercise name
                const SizedBox(height: 12),
                if (selectedExercises.isNotEmpty)
                  ...selectedExercises.map(
                    (e) => Text(
                      e['Exercise_Name'],
                      style: AppStyles.textCairo(
                          12, Palette.mainAppColorWhite, FontWeight.w500),
                    ),
                  ),
                const SizedBox(height: 24),
                BuildTextField( dir: dir,
                  onChange: (value) => setState(() {
                    rounds = value;
                  }),
                  label: LocalizationService.translateFromGeneral('rounds'),
                  keyboardType: TextInputType.number,
                  icon: Icons.refresh,
                ),
                const SizedBox(height: 12),
                BuildTextField( dir: dir,
                  onChange: (value) => setState(() {
                    repetitions = value;
                  }),
                  label:
                      LocalizationService.translateFromGeneral('repetitions'),
                  keyboardType: TextInputType.number,
                  icon: Icons.loop,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // If the exercise is selected, add it to the training day
                if (selectedExercises.isNotEmpty) {
                  selectedExercises.forEach((e) {
                    Exercise exercise = Exercise(
                      name: e['Exercise_Name'],
                      image: e['Exercise_Image'],
                      rounds: int.parse(rounds),
                      repetitions: int.parse(repetitions),
                    );
                    widget.addExercise(exercise);
                  });
                  Navigator.pop(context);
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
}
