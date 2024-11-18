import 'package:flutter/material.dart';
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
  final Exercise? initialExercise; // Optional initial exercise to edit

  const ExerciseDialog(
      {Key? key, required this.addExercise, this.initialExercise})
      : super(key: key);

  @override
  _ExerciseDialogState createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {
  List<dynamic> selectedExercises = [];
  String rounds = '';
  String repetitions = '';
  late String dir;

  late TextEditingController roundsController = TextEditingController();
  late TextEditingController repetitionsController = TextEditingController();
  bool isAddNewImage = false;

  @override
  void initState() {
    super.initState();
    dir = LocalizationService.getDir();

    // Initialize state based on initial exercise if provided
    if (widget.initialExercise != null) {
      selectedExercises = [
        widget.initialExercise
      ]; // Adjust as per your data structure
      rounds = widget.initialExercise!.rounds.toString();
      repetitions = widget.initialExercise!.repetitions.toString();
      roundsController = TextEditingController(text: rounds);
      repetitionsController = TextEditingController(text: repetitions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: customThemeData,
      child: Directionality(
        textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text(
            widget.initialExercise != null
                ? LocalizationService.translateFromGeneral('editExercise')
                : LocalizationService.translateFromGeneral('addExercise'),
            style: TextStyle(color: Palette.white),
          ),
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
                    final val = await showDialog(
                      context: context,
                      builder: (context) => ExercisesScreen(
                        fileName: 'back_exercises',
                      ),
                    );

                    if (val != null) {
                      setState(() {
                        isAddNewImage = true;
                        selectedExercises = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 12),
                if (selectedExercises.isNotEmpty)
                  ...selectedExercises.map(
                    (e) => Text(
                      widget.initialExercise != null
                          ? widget.initialExercise!.name
                          : e['Exercise_Name'], // Adjust based on your data structure
                      style: AppStyles.textCairo(
                        12,
                        Palette.mainAppColorWhite,
                        FontWeight.w500,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                BuildTextField(
                  dir: dir,
                  onChange: (value) {
                    setState(() {
                      rounds = value;
                    });
                  },
                  controller: roundsController, // Set initial value if editing
                  label: LocalizationService.translateFromGeneral('rounds'),
                  keyboardType: TextInputType.number,
                  icon: Icons.refresh,
                ),
                const SizedBox(height: 12),
                BuildTextField(
                  dir: dir,
                  onChange: (value) {
                    setState(() {
                      repetitions = value;
                    });
                  },
                  controller:
                      repetitionsController, // Set initial value if editing
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
                if (widget.initialExercise != null &&
                    selectedExercises.length == 1) {
                  if (isAddNewImage) {
                    Exercise exercise = Exercise(
                      name: selectedExercises[0][
                          'Exercise_Name'], // Adjust based on your data structure
                      image: selectedExercises[0][
                          'Exercise_Image'], // Adjust based on your data structure
                      rounds: int.parse(rounds),
                      repetitions: int.parse(repetitions),
                    );
                    widget.addExercise(exercise);
                  } else {
                    Exercise exercise = Exercise(
                      name: selectedExercises[0]
                          .name, // Adjust based on your data structure
                      image: selectedExercises[0]
                          .image, // Adjust based on your data structure
                      rounds: int.parse(rounds),
                      repetitions: int.parse(repetitions),
                    );
                    widget.addExercise(exercise);
                  }
                } else if (selectedExercises.isNotEmpty) {
                  selectedExercises.forEach((e) {
                    Exercise exercise = Exercise(
                      name: e[
                          'Exercise_Name'], // Adjust based on your data structure
                      image: e[
                          'Exercise_Image'], // Adjust based on your data structure
                      rounds: int.parse(rounds),
                      repetitions: int.parse(repetitions),
                    );

                    widget.addExercise(exercise);
                  });
                }
                Navigator.pop(context);
              },
              child: Text(
                LocalizationService.translateFromGeneral('save'),
                style: TextStyle(color: Palette.black),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                LocalizationService.translateFromGeneral('cancel'),
                style: TextStyle(color: Palette.white),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.start,
        ),
      ),
    );
  }
}
