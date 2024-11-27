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
  List<Map<String, dynamic>> selectedExercisesWithDetails = [];
  late String dir;
  bool isAddNewImage = false;

  @override
  void initState() {
    super.initState();
    dir = LocalizationService.getDir();

    // Initialize state based on initial exercise if provided
    if (widget.initialExercise != null) {
      selectedExercisesWithDetails = [
        {
          'exercise': widget.initialExercise,
          'rounds': TextEditingController(
              text: widget.initialExercise!.rounds.toString()),
          'repetitions': TextEditingController(
              text: widget.initialExercise!.repetitions.toString()),
          'time': TextEditingController(
              text: widget.initialExercise!.time?.toString() ?? ''),
          'useTime': widget.initialExercise!.time != null,
        }
      ];
    }
  }

  Widget _buildExerciseItem(Map<String, dynamic> exerciseData, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isAddNewImage
              ? exerciseData['exercise']['Exercise_Name']
              : exerciseData['exercise'].name,
          style: AppStyles.textCairo(
            12,
            Palette.mainAppColorWhite,
            FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        BuildTextField(
          dir: dir,
          controller: exerciseData['rounds'],
          label: LocalizationService.translateFromGeneral('rounds'),
          keyboardType: TextInputType.number,
          icon: Icons.refresh,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              LocalizationService.translateFromGeneral('measurementType'),
              style: AppStyles.textCairo(
                  12, Palette.mainAppColorWhite, FontWeight.w500),
            ),
            const SizedBox(width: 8),
            Switch(
              value: exerciseData['useTime']
                  ? true
                  : false,
              onChanged: (value) {
                setState(() {
                  exerciseData['useTime'] = value;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (exerciseData['useTime'] ?? false)
          BuildTextField(
            dir: dir,
            controller: exerciseData['time'],
            label: LocalizationService.translateFromGeneral('timeInSeconds'),
            keyboardType: TextInputType.number,
            icon: Icons.timer,
          )
        else
          BuildTextField(
            dir: dir,
            controller: exerciseData['repetitions'],
            label: LocalizationService.translateFromGeneral('repetitions'),
            keyboardType: TextInputType.number,
            icon: Icons.loop,
          ),
        const SizedBox(height: 16),
        if (index < selectedExercisesWithDetails.length - 1)
          Divider(color: Palette.white.withOpacity(0.3)),
        const SizedBox(height: 16),
      ],
    );
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
                    try {
                      final result = await showDialog<List<dynamic>>(
                        context: context,
                        builder: (context) => ExercisesScreen(
                          fileName: 'back_exercises',
                        ),
                      );

                      if (result != null && result.isNotEmpty) {
                        setState(() {
                          isAddNewImage = true;
                          selectedExercisesWithDetails = result
                              .map((e) => {
                                    'exercise': e,
                                    'rounds': TextEditingController(),
                                    'repetitions': TextEditingController(),
                                    'time': TextEditingController(),
                                    'useTime': false,
                                  })
                              .toList();
                        });
                      }
                    } catch (e) {
                      print('Error selecting exercise: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error selecting exercise')),
                      );
                    }
                  },
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  selectedExercisesWithDetails.length,
                  (index) => _buildExerciseItem(
                      selectedExercisesWithDetails[index], index),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                for (var exerciseData in selectedExercisesWithDetails) {
                  final rounds = int.tryParse(exerciseData['rounds'].text) ?? 0;
                  final useTime = exerciseData['useTime'] ?? false;
                  final repetitions = useTime
                      ? 0
                      : (int.tryParse(exerciseData['repetitions'].text) ?? 0);
                  final time = useTime
                      ? (int.tryParse(exerciseData['time'].text) ?? 0)
                      : null;

                  Exercise exercise;
                  if (isAddNewImage) {
                    exercise = Exercise(
                      name: exerciseData['exercise']['Exercise_Name'],
                      image: exerciseData['exercise']['Exercise_Image'],
                      rounds: rounds,
                      repetitions: repetitions,
                      time: time,
                    );
                  } else {
                    exercise = Exercise(
                      name: exerciseData['exercise'].name,
                      image: exerciseData['exercise'].image,
                      rounds: rounds,
                      repetitions: repetitions,
                      time: time,
                    );
                  }
                  widget.addExercise(exercise);
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

  @override
  void dispose() {
    for (var exercise in selectedExercisesWithDetails) {
      exercise['rounds'].dispose();
      exercise['repetitions'].dispose();
      exercise['time']?.dispose();
    }
    super.dispose();
  }
}
