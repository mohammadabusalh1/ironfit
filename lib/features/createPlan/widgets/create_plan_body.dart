import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/exrciseCard.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/features/createPlan/widgets/deopdown.dart';
import 'package:ironfit/features/createPlan/widgets/ex.dart';

class CreatePlanBody extends StatefulWidget {
  const CreatePlanBody({super.key});

  @override
  _CreatePlanBodyState createState() => _CreatePlanBodyState();
}

class _CreatePlanBodyState extends State<CreatePlanBody> {
  final TextEditingController _planNameController = TextEditingController();
  final TextEditingController _planDescriptionController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<TrainingDay> trainingDays = [];

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
        onPressed: () => _addTrainingDay(context),
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
        return _buildTrainingDayCard(day);
      },
    );
  }

  Widget _buildTrainingDayCard(TrainingDay day) {
    final splitDay = day.day!.split('-');
    return Card(
      color: Palette.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              splitDay[0],
              style: const TextStyle(
                  color: Palette.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: day.exercises.map((exercise) {
                return Row(
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

  void _addTrainingDay(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _buildDayDialog(context),
    );
  }

  Widget _buildDayDialog(BuildContext context) {
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

  Widget _buildSavePlanButton() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: _savePlan,
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.mainAppColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: const Text("حفظ الخطة",
            style: TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }

  void _savePlan() async {
    if (_validatePlan()) {
      try {
        final User? user = _auth.currentUser;
        if (user != null) {
          final planData = {
            'name': _planNameController.text,
            'description': _planDescriptionController.text,
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
              .add(planData);
          Get.back();
          Get.snackbar('نجاح', 'تم حفظ الخطة بنجاح',
              messageText: Text(
                'تم حفظ الخطة بنجاح',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.right,
              ),
              titleText: Text(
                'نجاح',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.right,
              ),
              backgroundColor: Colors.green,
              colorText: Colors.white);
        } else {
          Get.snackbar('خطأ', 'يجب تسجيل الدخول لحفظ الخطة',
              messageText: Text(
                'يجب تسجيل الدخول لحفظ الخطة',
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
        }
      } catch (e) {
        print(e);
        Get.snackbar('خطأ', 'حدث خطأ أثناء حفظ الخطة',
            messageText: Text(
              'حدث خطأ أثناء حفظ الخطة',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.right,
            ),
            titleText: Text(
              'خطاء',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.right,
            ),
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }
  }

  bool _validatePlan() {
    if (_planNameController.text.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إدخال اسم الخطة',
          messageText: Text(
            'يرجى إدخال اسم الخطة',
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
    if (_planDescriptionController.text.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إدخال وصف الخطة',
          messageText: Text(
            'يرجى إدخال وصف الخطة',
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
    if (trainingDays.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إضافة يوم تدريب واحد على الأقل',
          messageText: Text(
            'يرجى إضافة يوم تدريب واحد على الأقل',
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
    for (var day in trainingDays) {
      if (day.exercises.isEmpty) {
        Get.snackbar('خطأ', 'يرجى إضافة تمرين واحد على الأقل لكل يوم تدريب',
            messageText: Text(
              'يرجى إضافة تمرين واحد على الأقل لكل يوم تدريب',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.right,
            ),
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return false;
      }
    }
    return true;
  }

  void _addExerciseToDay(TrainingDay day) {
    List<Map<String, dynamic>> exercisesJson =
        List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    showDialog(
      context: context,
      builder: (context) => _buildExerciseDialog(day, exercisesJson),
    );
  }

  Widget _buildExerciseDialog(
      TrainingDay day, List<Map<String, dynamic>> exercisesJson) {
    final TextEditingController roundsController = TextEditingController();
    final TextEditingController repetitionsController = TextEditingController();

    String? selectedExerciseName;
    String? selectedExerciseImage;

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
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text("أضف تمرين", style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dropdown for exercise selection
                SearchableDropdown(
                    items: exercisesJson,
                    value: selectedExerciseName,
                    onChanged: (selectedExercise) {
                      setState(() {
                        selectedExerciseName = selectedExercise;
                        selectedExerciseImage = exercisesJson.firstWhere(
                              (exercise) =>
                                  exercise['Exercise_Name'] ==
                                  selectedExerciseName,
                              orElse: () => {},
                            )['Exercise_Image'] ??
                            'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg';
                      });
                    },
                    labelText: "التمرين"),
                const SizedBox(height: 16),
                // TextFields for rounds and repetitions
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
              onPressed: () {
                if (selectedExerciseName != null &&
                    _validateExercise(selectedExerciseName!,
                        roundsController.text, repetitionsController.text)) {
                  setState(() {
                    day.exercises.add(Exercise(
                      name: selectedExerciseName!,
                      rounds: int.parse(roundsController.text),
                      repetitions: int.parse(repetitionsController.text),
                      image: selectedExerciseImage ??
                          'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg',
                    ));
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
  final String? image;

  Exercise({
    required this.name,
    required this.rounds,
    required this.repetitions,
    this.image,
  });
}
