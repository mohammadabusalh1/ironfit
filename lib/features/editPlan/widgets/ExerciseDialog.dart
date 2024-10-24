import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/ExerciseListWidget.dart';
import 'package:ironfit/features/createPlan/widgets/create_plan_body.dart';
import 'package:ironfit/features/editPlan/widgets/buildTextField.dart';

class ExerciseDialog extends StatefulWidget {
  final Function addExercise;
  final List<Map<String, dynamic>> exercisesJson;

  const ExerciseDialog(
      {Key? key, required this.addExercise, required this.exercisesJson})
      : super(key: key);

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
              const Text("أضف تمرين", style: TextStyle(color: Palette.white)),
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
                            _buildTrainDialog(widget.exercisesJson));

                    // If an exercise is selected, update the state to reflect it
                    if (val != null) {
                      setState(() {
                        selectedExerciseName = val['Exercise_Name'];
                        selectedExerciseImage = val['Exercise_Image'];
                      });
                    }
                  },
                  child: const Text('إختر التمرين',
                      style: TextStyle(color: Palette.black)),
                ),
                const SizedBox(height: 16),
                // Display the selected exercise name
                if (selectedExerciseName.isNotEmpty)
                  Text(
                    '$selectedExerciseName',
                    style: const TextStyle(color: Palette.white),
                  ),
                const SizedBox(height: 16),
                BuildTextField(
                  onChange: (value) => setState(() {
                    rounds = value;
                  }),
                  label: "عدد الجولات",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                BuildTextField(
                  onChange: (value) => setState(() {
                    repetitions = value;
                  }),
                  label: "عدد التكرارات",
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
              child: const Text('حفظ', style: TextStyle(color: Palette.black)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:
                  const Text('إلغاء', style: TextStyle(color: Palette.white)),
            ),
          ],
          actionsAlignment: MainAxisAlignment.start,
        ),
      ),
    );
  }

  Widget _buildTrainDialog(List<Map<String, dynamic>> exercisesJson) {
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
          title: const Text("إختر التدريب",
              style: TextStyle(color: Palette.white)),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ExercisesScreen(
                exercisesJson: exercisesJson,
              ),
            );
          }),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:
                  const Text('إلغاء', style: TextStyle(color: Palette.white)),
            ),
          ],
          actionsAlignment: MainAxisAlignment.start,
        ),
      ),
    );
  }
}
