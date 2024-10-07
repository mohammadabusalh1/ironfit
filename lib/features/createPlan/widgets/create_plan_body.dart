import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:ironfit/core/presention/style/palette.dart';

class CreatePlanBody extends StatefulWidget {
  const CreatePlanBody({super.key});

  @override
  _CreatePlanBodyState createState() => _CreatePlanBodyState();
}

class _CreatePlanBodyState extends State<CreatePlanBody> {
  final TextEditingController _planNameController = TextEditingController();
  final TextEditingController _planDescriptionController =
      TextEditingController();

  List<TrainingDay> trainingDays = [];

  void _addTrainingDay() {
    showDialog(
      context: context,
      builder: (context) {
        String? selectedDay;
        return Theme(
            data: Theme.of(context).copyWith(
                // Customize the dialog theme here
                dialogBackgroundColor:
                    Colors.grey[900], // Dialog background color
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
                  bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
                  headlineLarge: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFFFBB02), // Customize button color
                    foregroundColor:
                        const Color(0xFF1C1503), // Customize text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true, // Fill the text field background
                  fillColor: Palette
                      .secondaryColor, // Background color of the text field
                  labelStyle: TextStyle(
                      color: Colors.white, fontSize: 14), // Label text style
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Colors.transparent), // Border color when enabled
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.yellow,
                        width: 2), // Border color when focused
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.red), // Border color on error
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red,
                        width: 2), // Border color on error when focused
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // Customize text color
                  ),
                )),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: Text("إختر يوم التدريب"),
                content: DropdownButton<String>(
                  dropdownColor: Palette.secondaryColor,
                  hint: Text("يوم التدريب",
                      style: TextStyle(color: Colors.white)),
                  value: selectedDay,
                  onChanged: (newValue) {
                    setState(() {
                      selectedDay = newValue;
                    });
                  },
                  items: [
                    'الأحد',
                    'الإثنين',
                    'الثلاثاء',
                    'الأربعاء',
                    'الخميس',
                    'الجمعة',
                    'السبت',
                  ]
                      .map((day) => DropdownMenuItem(
                            value: day,
                            child: Align(
                              alignment: AlignmentDirectional
                                  .centerEnd, // Align to the right
                              child: Text(
                                day,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      if (selectedDay != null) {
                        setState(() {
                          trainingDays.add(
                              TrainingDay(day: selectedDay!, exercises: []));
                        });
                        Navigator.pop(context);
                      } // Close the dialog
                    },
                    child: const Text('حفظ'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('إلغاء'),
                  ),
                ],
                actionsAlignment: MainAxisAlignment.start,
              ),
            ));
      },
    );
  }

  void _addExerciseToDay(TrainingDay day) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController exerciseController =
            TextEditingController();
        return AlertDialog(
          title: Text("Add Exercise"),
          content: TextField(
            controller: exerciseController,
            decoration: InputDecoration(labelText: "Exercise Name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (exerciseController.text.isNotEmpty) {
                    day.exercises.add(exerciseController.text);
                  }
                });
                Navigator.pop(context);
              },
              child: Text("Add Exercise"),
            ),
          ],
        );
      },
    );
  }

  void _showExerciseDetail(String exerciseName) {
    // Example to show a dialog for exercise detail (video/image)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(exerciseName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Video/Image related to the exercise will be shown here."),
              // Add your video/image widget here
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    Assets.header,
                    width: double.infinity,
                    height: 132,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 50, 24, 50),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1C1503),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          elevation: 0,
                        ),
                        child: const Icon(
                          Icons.arrow_left,
                          color: Color(0xFFFFBB02),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Opacity(
                        opacity: 0.8,
                        child: Text(
                          'البرامج الخاصة بي',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            shadows: [
                              Shadow(
                                color: Color(0xFF2F3336),
                                offset: Offset(4.0, 4.0),
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Plan Name Input
                    TextField(
                      controller: _planNameController,
                      decoration: InputDecoration(
                        labelText: "إسم الخطة",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Palette.mainAppColor,
                          ),
                        ),
                        labelStyle: const TextStyle(
                            color: Palette.subTitleGrey, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Plan Description Input
                    TextField(
                      controller: _planDescriptionController,
                      decoration: InputDecoration(
                        labelText: "وصف الخطة",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Palette.mainAppColor,
                          ),
                        ),
                        labelStyle: const TextStyle(
                            color: Palette.subTitleGrey, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Add Day Button
                    SizedBox(
                      width: double.infinity,
                      height: 45, // Set the desired width here
                      child: ElevatedButton(
                        onPressed: _addTrainingDay,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.mainAppColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                        ),
                        child: const Text("اضافة يوم",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                    ),

                    const SizedBox(height: 24),
                    // Display Training Days and Exercises
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: trainingDays.length,
                      itemBuilder: (context, index) {
                        final day = trainingDays[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 24),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  day.day,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  children: day.exercises.map((exercise) {
                                    return ListTile(
                                      title: Text(exercise),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.play_arrow),
                                        onPressed: () =>
                                            _showExerciseDetail(exercise),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () => _addExerciseToDay(day),
                                  child: const Text("Add Exercise"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class TrainingDay {
  String day;
  List<String> exercises;

  TrainingDay({required this.day, required this.exercises});
}
