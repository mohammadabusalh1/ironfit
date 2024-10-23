import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/exrciseCard.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/createPlan/widgets/create_plan_body.dart';
import 'package:ironfit/features/createPlan/widgets/ex.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
import 'package:ironfit/features/editPlan/widgets/ExerciseDialog.dart';

class EditPlanBody extends StatefulWidget {
  const EditPlanBody({super.key, required this.planId});

  final String planId;

  @override
  _EditPlanBodyState createState() => _EditPlanBodyState();
}

class _EditPlanBodyState extends State<EditPlanBody> {
  List<Map<String, dynamic>> exercisesJson =
      List<Map<String, dynamic>>.from(jsonDecode(jsonString));

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String planName = '';
  String planDescription = '';
  String selectedExerciseName = '';
  String selectedExerciseImage = '';
  String rounds = '';
  String repetitions = '';

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
      final fetchedPlanName = planData['name'] ?? 'No plan name';
      final fetchedPlanDescription =
          planData['description'] ?? 'No description available';
      setState(() {
        planName = fetchedPlanName;
        planDescription = fetchedPlanDescription;
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
    return Stack(
      alignment: Alignment.topRight,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    BuildTextField(
                      value: planName,
                      onChange: (value) => setState(() => planName = value),
                      label: "إسم الخطة",
                    ),
                    const SizedBox(height: 16),
                    BuildTextField(
                      value: planDescription,
                      onChange: (value) =>
                          setState(() => planDescription = value),
                      label: "وصف الخطة",
                    ),
                    _buildTrainingDaysList(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 24, // Distance from the bottom
          right: 24, // Distance from the left side
          child: SizedBox(
            width: 60,
            height: 60,
            child: IconButton(
              style: IconButton.styleFrom(
                fixedSize: const Size(50, 50),
                backgroundColor: Palette.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              icon: const Icon(
                Icons.add,
                color: Palette.mainAppColor,
                size: 24,
              ),
              onPressed: () => _addTrainingDay(),
            ),
          ),
        ),
        Positioned(
          bottom: 92, // Distance from the bottom
          right: 24, // Distance from the left side
          child: SizedBox(
            width: 60,
            height: 60,
            child: IconButton(
              style: IconButton.styleFrom(
                fixedSize: const Size(50, 50),
                backgroundColor: Palette.greenActive,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              icon: const Icon(
                Icons.done,
                color: Palette.white,
                size: 24,
              ),
              onPressed: () => _savePlan(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          const HeaderImage(),
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
                    const SizedBox(
                        height: 10), // Adjust the height as per your need
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

  void _addExerciseToDay(TrainingDay day) {
    Future<void> _addExercise(Exercise exercise) async {
      setState(() {
        day.exercises.add(exercise);
      });
      Navigator.pop(context);
    }

    showDialog(
      context: context,
      builder: (context) => ExerciseDialog(
        addExercise: _addExercise,
        exercisesJson: exercisesJson,
      ),
    );
  }

  Future<void> _savePlan() async {
    try {
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('coaches')
            .doc(user.uid)
            .collection('plans')
            .doc(widget.planId)
            .update({
          'name': planName,
          'description': planDescription,
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
        }).then((value) {
          Navigator.pop(context);
        });
        Get.snackbar(
          'نجاح',
          'تم حفظ التعديلات بنجاح',
          titleText: const Text(
            'نجاح',
            style: TextStyle(color: Palette.white),
            textAlign: TextAlign.right,
          ),
          messageText: const Text('تم حفظ التعديلات بنجاح',
              style: TextStyle(color: Palette.white),
              textAlign: TextAlign.right),
          backgroundColor: Palette.secondaryColor,
        );
        Get.toNamed(Routes.myPlans);
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء حفظ البيانات: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
