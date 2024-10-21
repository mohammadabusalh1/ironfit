import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/ExerciseListWidget.dart';
import 'package:ironfit/core/presentation/widgets/exrciseCard.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/createPlan/widgets/create_plan_body.dart';
import 'package:ironfit/features/createPlan/widgets/deopdown.dart';
import 'package:ironfit/features/createPlan/widgets/ex.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPlanBody extends StatefulWidget {
  const EditPlanBody({super.key, required this.planId});

  final String planId;

  @override
  _EditPlanBodyState createState() => _EditPlanBodyState();
}

class _EditPlanBodyState extends State<EditPlanBody> {
  final TextEditingController _planNameController = TextEditingController();
  final TextEditingController _planDescriptionController =
      TextEditingController();
  List<Map<String, dynamic>> exercisesJson =
      List<Map<String, dynamic>>.from(jsonDecode(jsonString));

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedExerciseName;
  String? selectedExerciseImage;

  List<TrainingDay> trainingDays = [];

  @override
  void initState() {
    super.initState();
    _fetchPlanData();
  }

  Future<void> _fetchPlanData() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        Get.snackbar('Error', 'User is not authenticated',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      final planDoc = await _firestore
          .collection('coaches')
          .doc(user.uid)
          .collection('plans')
          .doc(widget.planId)
          .get();

      if (!planDoc.exists) {
        Get.snackbar('Error', 'The requested plan does not exist.',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      final planData = planDoc.data();

      if (planData == null || planData.isEmpty) {
        Get.snackbar('Error', 'Plan data is missing or empty',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      // Safely access fields and provide fallback values
      final planName = planData['name'] ?? 'No plan name';
      final planDescription =
          planData['description'] ?? 'No description available';

      _planNameController.text = planName;
      _planDescriptionController.text = planDescription;

      setState(() {
        trainingDays = (planData['trainingDays'] as Map?)?.entries.map((e) {
              final day = e.key;
              final exercises = (e.value as List?)?.map((exercise) {
                    return Exercise(
                      name: exercise['name'] ?? 'Unnamed exercise',
                      rounds: exercise['rounds'] ?? 0,
                      repetitions: exercise['repetitions'] ?? 0,
                      image:
                          exercise['image'] ?? 'https://default-image-url.jpg',
                    );
                  }).toList() ??
                  [];

              return TrainingDay(day: day, exercises: exercises);
            }).toList() ??
            [];
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch plan data: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildTextField(
                    controller: _planNameController,
                    label: "إسم الخطة",
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _planDescriptionController,
                    label: "وصف الخطة",
                  ),
                  const SizedBox(height: 24),
                  _buildAddDayButton(context),
                  const SizedBox(height: 24),
                  _buildTrainingDaysList(),
                  const SizedBox(height: 24),
                  _buildSavePlanButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          HeaderImage(),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 50, 24, 50),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(),
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
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      TextInputType? keyboardType}) {
    return TextField(
      keyboardType: keyboardType ?? TextInputType.text,
      style: const TextStyle(color: Palette.white, fontSize: 14),
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            color: Palette.mainAppColor,
          ),
        ),
        labelStyle: const TextStyle(color: Palette.subTitleGrey, fontSize: 14),
      ),
    );
  }

  Widget _buildAddDayButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: () => _addTrainingDay(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: const Text("اضافة يوم",
            style: TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }

  Widget _buildTrainingDaysList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: trainingDays.length,
      itemBuilder: (context, index) {
        final day = trainingDays[index];
        return _buildTrainingDayCard(day, index);
      },
    );
  }

  Widget _buildTrainingDayCard(TrainingDay day, int index) {
    String dayName = day.day.contains('-') ? day.day.split('-')[1] : day.day;
    return Card(
      color: Palette.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dayName == 'sun'
                  ? 'الاحد'
                  : dayName == 'mon'
                      ? 'الاثنين'
                      : dayName == 'tue'
                          ? 'الثلاثاء'
                          : dayName == 'wed'
                              ? 'الاربعاء'
                              : dayName == 'thu'
                                  ? 'الخميس'
                                  : dayName == 'fri'
                                      ? 'الجمعة'
                                      : 'السبت',
              style: const TextStyle(
                  color: Palette.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: day.exercises.map((exercise) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ExrciseCard(
                            spaceBetweenItems: 5,
                            padding: 0,
                            withIconButton: false,
                            title: exercise.name,
                            subtitle1: "${exercise.rounds} جولات",
                            subtitle2: "${exercise.repetitions} تكرار",
                            image: exercise.image!,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _removeExercise(day, exercise),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                    // Add space between rows
                    SizedBox(height: 10), // Adjust the height as per your need
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _addExerciseToDay(day),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.mainAppColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("أضف تمرين",
                    style: TextStyle(color: Palette.black)),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                  onPressed: () => _removeTrainingDay(index),
                  child: const Text("حذف",
                      style: TextStyle(color: Palette.redDelete))),
            ),
          ],
        ),
      ),
    );
  }

  void _removeExercise(TrainingDay day, Exercise exercise) {
    setState(() {
      day.exercises.remove(exercise);
    });
  }

  void _removeTrainingDay(int index) async {
    bool confirmCancel = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: const Text(
            'تأكيد الإلغاء',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'هل أنت متأكد أنك تريد الحذف؟',
            textAlign: TextAlign.end,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled
              },
              child:
                  const Text('إلغاء', style: TextStyle(color: Palette.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.redDelete,
              ),
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed
              },
              child:
                  const Text('تأكيد', style: TextStyle(color: Palette.white)),
            ),
          ],
        );
      },
    );

    // If the user cancels, return early
    if (!confirmCancel) {
      return;
    }
    setState(() {
      trainingDays.removeAt(index);
    });
  }

  void _addTrainingDay() {
    showDialog(
      context: context,
      builder: (context) => _buildDayDialog(),
    );
  }

  Widget _buildDayDialog() {
    String? selectedDay;
    return Theme(
      data: Theme.of(context).copyWith(
          dialogBackgroundColor: Colors.grey[900],
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
            bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
            headlineLarge: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Palette.mainAppColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text("إختر يوم التدريب",
              style: TextStyle(color: Colors.white)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                dropdownColor: Colors.grey[800],
                hint: const Text("يوم التدريب",
                    style: TextStyle(color: Colors.white)),
                value: selectedDay,
                onChanged: (newValue) {
                  setState(() {
                    selectedDay = newValue;
                  });
                },
                items: const [
                  {'value': 'sun', 'label': 'الأحد'},
                  {'value': 'mon', 'label': 'الأثنين'},
                  {'value': 'tue', 'label': 'الثلاثاء'},
                  {'value': 'wed', 'label': 'الأربعاء'},
                  {'value': 'thu', 'label': 'الخميس'},
                  {'value': 'fri', 'label': 'الجمعة'},
                  {'value': 'sat', 'label': 'السبت'},
                ]
                    .map((day) => DropdownMenuItem(
                          value: '${day['label']}-${day['value']}',
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(day['label']!,
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (selectedDay != null) {
                  setState(() {
                    trainingDays
                        .add(TrainingDay(day: selectedDay!, exercises: []));
                  });
                  Navigator.pop(context);
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
            ElevatedButton(
              onPressed: () {},
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

  void _addExerciseToDay(TrainingDay day) {
    showDialog(
      context: context,
      builder: (context) => _buildExerciseDialog(day, exercisesJson),
    );
  }

  Widget _buildExerciseDialog(
      TrainingDay day, List<Map<String, dynamic>> exercisesJson) {
    final TextEditingController roundsController = TextEditingController();
    final TextEditingController repetitionsController = TextEditingController();

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
                      final val = await showDialog(
                        //<--------|
                        context: context,
                        builder: (context) => _buildTrainDialog(exercisesJson),
                      );
                      setState(() {
                        selectedExerciseName = val['Exercise_Name'];
                        selectedExerciseImage = val['Exercise_Image'];
                      });
                    },
                    child: Text('صورة التمرين',
                        style: TextStyle(color: Palette.black))),
                const SizedBox(height: 16),
                _buildTextField(
                    controller: roundsController,
                    label: "عدد الجولات",
                    keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                _buildTextField(
                    controller: repetitionsController,
                    label: "عدد التكرارات",
                    keyboardType: TextInputType.number),
                const SizedBox(height: 16),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (selectedExerciseName != null &&
                    _validateExercise(selectedExerciseName!,
                        roundsController.text, repetitionsController.text)) {
                  try {
                    // Validate rounds and repetitions input
                    final int rounds = int.parse(roundsController.text);
                    final int repetitions =
                        int.parse(repetitionsController.text);

                    // Update the state with validated data
                    setState(() {
                      day.exercises.add(Exercise(
                        name: selectedExerciseName!,
                        rounds: rounds,
                        repetitions: repetitions,
                        image: selectedExerciseImage!,
                      ));
                    });

                    // Close the dialog after successfully adding the exercise
                    Navigator.pop(context);
                  } on FormatException catch (e) {
                    // Handle specific parsing error
                    print("Invalid number format: $e");
                    Get.snackbar('', '',
                        snackPosition: SnackPosition.TOP,
                        messageText: Text(
                          'الرجاء إدخال قيم صحيحة للجولات والتكرارات',
                          style: TextStyle(color: Palette.white),
                          textAlign: TextAlign.right,
                        ),
                        titleText: Text(
                          'خطأ',
                          style: TextStyle(color: Palette.white),
                          textAlign: TextAlign.right,
                        ));
                  } on Exception catch (e) {
                    // Handle other generic errors
                    print("Error: $e");
                    Get.snackbar('', '',
                        snackPosition: SnackPosition.TOP,
                        messageText: Text(
                          'الرجاء اختيار تمرين صحيح وإدخال جميع البيانات',
                          style: TextStyle(color: Palette.white),
                          textAlign: TextAlign.right,
                        ),
                        titleText: Text(
                          'خطأ',
                          style: TextStyle(color: Palette.white),
                          textAlign: TextAlign.right,
                        ));
                  }
                } else {
                  Get.snackbar('', '',
                      snackPosition: SnackPosition.TOP,
                      messageText: Text(
                        'الرجاء اختيار تمرين صحيح وإدخال جميع البيانات',
                        style: TextStyle(color: Palette.white),
                        textAlign: TextAlign.right,
                      ),
                      titleText: Text(
                        'خطأ',
                        style: TextStyle(color: Palette.white),
                        textAlign: TextAlign.right,
                      ));
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

  bool _validateExercise(String name, String rounds, String repetitions) {
    if (name.isEmpty) {
      Get.snackbar('', '',
          messageText: Text(
            'يرجى إدخال اسم التمرين',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.right,
          ),
          titleText: Text(
            'خطأ',
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    if (rounds.isEmpty || int.tryParse(rounds) == null) {
      Get.snackbar('', '',
          messageText: Text(
            'يرجى إدخال عدد صحيح للجولات',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.right,
          ),
          titleText: Text(
            'خطأ',
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    if (repetitions.isEmpty || int.tryParse(repetitions) == null) {
      Get.snackbar('', '',
          messageText: Text(
            'يرجى إدخال عدد صحيح للتكرارات',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.right,
          ),
          titleText: Text(
            'خطأ',
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    return true;
  }

  Widget _buildSavePlanButton() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: () => _savePlan(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.mainAppColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: const Text("حفظ التعديلات",
            style: TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }

  Future<void> _savePlan() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('coaches')
            .doc(user.uid)
            .collection('plans')
            .doc(widget.planId)
            .update({
          'name': _planNameController.text,
          'description': _planDescriptionController.text,
          'trainingDays': {
            for (var day in trainingDays)
              (day.day.contains('-') ? day.day.split('-')[1] : day.day):
                  day.exercises
                      .map((e) => {
                            'name': e.name,
                            'rounds': e.rounds,
                            'repetitions': e.repetitions,
                            'image': e.image,
                          })
                      .toList()
          }
        });
        Get.snackbar('نجاح', 'تم حفظ التعديلات بنجاح',
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.toNamed(Routes.myPlans);
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء حفظ البيانات: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
