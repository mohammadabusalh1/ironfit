import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/exrciseCard.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/createPlan/widgets/ex.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
import 'package:ironfit/features/editPlan/widgets/ExerciseDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePlanBody extends StatefulWidget {
  const CreatePlanBody({super.key});

  @override
  _CreatePlanBodyState createState() => _CreatePlanBodyState();
}

class _CreatePlanBodyState extends State<CreatePlanBody> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final planController = TextEditingController();
  final descriptionController = TextEditingController();

  List<TrainingDay> trainingDays = [];

  List<Map<String, dynamic>> exercisesJson =
      List<Map<String, dynamic>>.from(jsonDecode(jsonString));

  String planName = '';
  String planDescription = '';
  String selectedExerciseName = '';
  String selectedExerciseImage = '';
  String rounds = '';
  String repetitions = '';

  PreferencesService preferencesService = PreferencesService();
  Future<void> _checkToken() async {
    SharedPreferences prefs = await preferencesService.getPreferences();
    String? token = prefs.getString('token');

    if (token == null) {
      Get.toNamed(Routes.singIn); // Navigate to coach dashboard
    }
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      BuildTextField(
                        controller: planController,
                        onChange: (value) => setState(() {
                          planName = value;
                        }),
                        label: "إسم الخطة",
                      ),
                      const SizedBox(height: 16),
                      BuildTextField(
                        controller: descriptionController,
                        onChange: (value) =>
                            setState(() => planDescription = value),
                        label: "وصف الخطة",
                      ),
                      const SizedBox(height: 24),
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
                onPressed: () => _addTrainingDay(context),
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
                      color: Palette.white,
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
        return Column(
          children: [
            _buildTrainingDayCard(day, index),
            const SizedBox(height: 16),
          ],
        );
      },
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

  void _addTrainingDay(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _buildDayDialog(context),
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
                            image: exercise.image,
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

  Widget _buildDayDialog(BuildContext context) {
    String? selectedDay;
    return Theme(
      data: Theme.of(context).copyWith(
          dialogBackgroundColor: Colors.grey[900],
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Palette.white, fontSize: 16),
            bodyMedium: TextStyle(color: Palette.white, fontSize: 14),
            headlineLarge: TextStyle(
                color: Palette.white,
                fontWeight: FontWeight.bold,
                fontSize: 24),
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
              style: TextStyle(color: Palette.white)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                dropdownColor: Colors.grey[800],
                hint: const Text("يوم التدريب",
                    style: TextStyle(color: Palette.white)),
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
                                style: const TextStyle(color: Palette.white)),
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

  void _savePlan() async {
    if (_validatePlan()) {
      try {
        final User? user = _auth.currentUser;
        if (user != null) {
          final planData = {
            'name': planName,
            'description': planDescription,
            'createdAt': FieldValue.serverTimestamp(),
            // ignore: prefer_for_elements_to_map_fromiterable
            'trainingDays': Map.fromIterable(trainingDays,
                key: (day) => day.day.toString().split('-')[1],
                value: (day) {
                  return day.exercises.map((exercise) {
                    return {
                      'name': exercise.name, // Exercise name
                      'repetitions':
                          exercise.repetitions, // Number of repetitions
                      'rounds': exercise.rounds, // Number of rounds
                      'image': exercise.image // Image for the exercise
                    };
                  }).toList(); // Convert the exercises to a list
                }),
          };

          await _firestore
              .collection('coaches')
              .doc(user.uid)
              .collection('plans')
              .add(planData)
              .then((value) {
            Get.toNamed(Routes.trainees);
          });
          Get.snackbar('نجاح', 'تم حفظ الخطة بنجاح',
              messageText: Text(
                'تم حفظ الخطة بنجاح',
                style: TextStyle(color: Palette.white),
                textAlign: TextAlign.right,
              ),
              titleText: Text(
                'نجاح',
                style: TextStyle(color: Palette.white, fontSize: 20),
                textAlign: TextAlign.right,
              ),
              backgroundColor: Colors.green,
              colorText: Palette.white);
        } else {
          Get.snackbar('خطأ', 'يجب تسجيل الدخول لحفظ الخطة',
              messageText: Text(
                'يجب تسجيل الدخول لحفظ الخطة',
                style: TextStyle(color: Palette.white),
                textAlign: TextAlign.right,
              ),
              titleText: Text(
                'خطأ',
                style: TextStyle(color: Palette.white, fontSize: 20),
                textAlign: TextAlign.right,
              ),
              backgroundColor: Colors.red,
              colorText: Palette.white);
        }
      } catch (e) {
        print(e);
        Get.snackbar('خطأ', 'حدث خطأ أثناء حفظ الخطة',
            messageText: Text(
              'حدث خطأ أثناء حفظ الخطة',
              style: TextStyle(color: Palette.white),
              textAlign: TextAlign.right,
            ),
            titleText: Text(
              'خطاء',
              style: TextStyle(color: Palette.white, fontSize: 20),
              textAlign: TextAlign.right,
            ),
            backgroundColor: Colors.red,
            colorText: Palette.white);
      }
    }
  }

  bool _validatePlan() {
    if (planName.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إدخال اسم الخطة',
          messageText: Text(
            'يرجى إدخال اسم الخطة',
            style: TextStyle(color: Palette.white),
            textAlign: TextAlign.right,
          ),
          titleText: Text(
            'خطأ',
            style: TextStyle(color: Palette.white, fontSize: 20),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
          colorText: Palette.white);
      return false;
    }
    if (planDescription.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إدخال وصف الخطة',
          messageText: Text(
            'يرجى إدخال وصف الخطة',
            style: TextStyle(color: Palette.white),
            textAlign: TextAlign.right,
          ),
          titleText: Text(
            'خطأ',
            style: TextStyle(color: Palette.white, fontSize: 20),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
          colorText: Palette.white);
      return false;
    }
    if (trainingDays.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إضافة يوم تدريب واحد على الأقل',
          messageText: Text(
            'يرجى إضافة يوم تدريب واحد على الأقل',
            style: TextStyle(color: Palette.white),
            textAlign: TextAlign.right,
          ),
          titleText: Text(
            'خطأ',
            style: TextStyle(color: Palette.white, fontSize: 20),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
          colorText: Palette.white);
      return false;
    }
    for (var day in trainingDays) {
      if (day.exercises.isEmpty) {
        Get.snackbar('خطأ', 'يرجى إضافة تمرين واحد على الأقل لكل يوم تدريب',
            messageText: Text(
              'يرجى إضافة تمرين واحد على الأقل لكل يوم تدريب',
              style: TextStyle(color: Palette.white),
              textAlign: TextAlign.right,
            ),
            backgroundColor: Colors.red,
            colorText: Palette.white);
        return false;
      }
    }
    return true;
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
}

class TrainingDay {
  final String day;
  final List<Exercise> exercises;

  TrainingDay({required this.day, required this.exercises});
}

class Exercise {
  final String name;
  final int rounds;
  final int repetitions;
  final String image;

  Exercise({
    required this.name,
    required this.rounds,
    required this.repetitions,
    this.image =
        'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg',
  });

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'] ?? map['Exercise_Name'] as String,
      image: map['image'] ?? map['Exercise_Image'] as String,
      rounds: map['rounds'] ?? 0 as int,
      repetitions: map['repetitions'] ?? 0 as int,
    );
  }
}
