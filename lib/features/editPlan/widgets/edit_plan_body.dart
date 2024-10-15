import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

class EditPlanBody extends StatefulWidget {
  final String planId; // Plan ID to identify which plan to edit.
  const EditPlanBody({super.key, required this.planId});

  @override
  _EditPlanBodyState createState() => _EditPlanBodyState();
}

class _EditPlanBodyState extends State<EditPlanBody> {
  final TextEditingController _planNameController = TextEditingController();
  final TextEditingController _planDescriptionController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<TrainingDay> trainingDays = [];

  @override
  void initState() {
    super.initState();
    _loadPlanData();
  }

  Future<void> _loadPlanData() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot planSnapshot = await _firestore
            .collection('coaches')
            .doc(user.uid)
            .collection('plans')
            .doc(widget.planId) // Fetch plan using planId
            .get();

        if (planSnapshot.exists) {
          var planData = planSnapshot.data() as Map<String, dynamic>;
          _planNameController.text = planData['name'];
          _planDescriptionController.text = planData['description'];

          // Load training days and exercises
          var daysData = planData['trainingDays'] as List;
          setState(() {
            trainingDays = daysData
                .map((dayData) => TrainingDay(
                      day: dayData['day'],
                      exercises: (dayData['exercises'] as List)
                          .map((exerciseData) => Exercise(
                              name: exerciseData['name'],
                              rounds: exerciseData['rounds'],
                              repetitions: exerciseData['repetitions']))
                          .toList(),
                    ))
                .toList();
          });
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load plan data',
          messageText: Text('Failed to load plan data'),
          backgroundColor: Colors.red,
          colorText: Colors.white);
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
                    'تعديل الخطة',
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
      {required TextEditingController controller, required String label}) {
    return TextField(
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
        child: const Text("أضف يوم",
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

  Widget _buildTrainingDayCard(TrainingDay day, int dayIndex) {
    return Card(
      color: Palette.secondaryColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day.day,
                  style: const TextStyle(
                      color: Palette.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _editDay(day, dayIndex),
                      icon: const Icon(Icons.edit, color: Palette.white),
                    ),
                    IconButton(
                      onPressed: () => _removeDay(dayIndex),
                      icon: const Icon(Icons.delete, color: Palette.redDelete),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...day.exercises.map((exercise) {
              return ListTile(
                title: Text(exercise.name,
                    style: const TextStyle(color: Palette.white)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _editExercise(day, exercise),
                      icon: const Icon(Icons.edit, color: Palette.white),
                    ),
                    IconButton(
                      onPressed: () => _removeExercise(day, exercise),
                      icon: const Icon(Icons.delete, color: Palette.redDelete),
                    ),
                  ],
                ),
              );
            }),
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
                child: const Text("أضف التدريب",
                    style: TextStyle(color: Palette.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editDay(TrainingDay day, int dayIndex) {
    showDialog(
      context: context,
      builder: (context) => _buildDayEditDialog(day, dayIndex),
    );
  }

  Widget _buildDayEditDialog(TrainingDay day, int dayIndex) {
    String? selectedDay = day.day; // Initialize with the current day's value

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
          title:
              const Text('تعديل اليوم', style: TextStyle(color: Colors.white)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                dropdownColor: Colors.grey[800],
                hint: const Text("إختر اليوم",
                    style: TextStyle(color: Colors.white)),
                value: selectedDay,
                onChanged: (newValue) {
                  setState(() {
                    selectedDay = newValue;
                  });
                },
                items: const [
                  'الأحد',
                  'الإثنين',
                  'الثلاثاء',
                  'الأربعاء',
                  'الخميس',
                  'الجمعة',
                  'السبت',
                ].map((day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(day,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (selectedDay != null) {
                  setState(() {
                    trainingDays[dayIndex].day = selectedDay!;
                  });
                  Navigator.of(context).pop();
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

  void _removeDay(int dayIndex) {
    setState(() {
      trainingDays.removeAt(dayIndex);
    });
  }

  void _editExercise(TrainingDay day, Exercise exercise) {
    showDialog(
      context: context,
      builder: (context) => _buildExerciseEditDialog(day, exercise),
    );
  }

  Widget _buildExerciseEditDialog(TrainingDay day, Exercise exercise) {
    TextEditingController _exerciseController =
        TextEditingController(text: exercise.name);
    TextEditingController _roundsController =
        TextEditingController(text: exercise.rounds.toString());
    TextEditingController _repsController =
        TextEditingController(text: exercise.repetitions.toString());

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
          title: const Text("تعديل التمرين",
              style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                    controller: _exerciseController, label: "التمرين"),
                const SizedBox(height: 16),
                _buildTextField(
                    controller: _roundsController, label: "عدد الجولات"),
                const SizedBox(height: 16),
                _buildTextField(
                    controller: _repsController, label: "عدد التكرارات"),
                const SizedBox(height: 16),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  exercise.name = _exerciseController.text;
                  exercise.rounds = int.parse(_roundsController.text);
                  exercise.repetitions = int.parse(_repsController.text);
                });
                Navigator.of(context).pop();
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
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(day,
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
    showDialog(
      context: context,
      builder: (context) => _buildExerciseDialog(day),
    );
  }

  Widget _buildExerciseDialog(TrainingDay day) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController roundsController = TextEditingController();
    final TextEditingController repetitionsController = TextEditingController();

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
                _buildTextField(
                    controller: nameController, label: "إسم التمرين"),
                const SizedBox(height: 16),
                _buildTextField(
                    controller: roundsController, label: "عدد الجولات"),
                const SizedBox(height: 16),
                _buildTextField(
                    controller: repetitionsController, label: "عدد التكرارات"),
                const SizedBox(height: 16),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_validateExercise(nameController.text,
                    roundsController.text, repetitionsController.text)) {
                  setState(() {
                    day.exercises.add(Exercise(
                      name: nameController.text,
                      rounds: int.parse(roundsController.text),
                      repetitions: int.parse(repetitionsController.text),
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
        ),
        child: const Text("حفظ الخطة",
            style: TextStyle(fontSize: 16, color: Colors.white)),
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
            .doc(widget.planId) // Use planId to save data
            .update({
          'name': _planNameController.text,
          'description': _planDescriptionController.text,
          'trainingDays': trainingDays
              .map((day) => {
                    'day': day.day,
                    'exercises': day.exercises
                        .map((exercise) => {
                              'name': exercise.name,
                              'rounds': exercise.rounds,
                              'repetitions': exercise.repetitions
                            })
                        .toList()
                  })
              .toList(),
        });
        Get.snackbar('تم', 'تم حفظ التعديلات بنجاح',
            backgroundColor: Palette.greenActive,
            colorText: Colors.white,
            titleText: Text(
              'تم',
              style: TextStyle(color: Colors.white),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
            messageText: Text(
              'تم حفظ التعديلات بنجاح',
              style: TextStyle(color: Colors.white),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ));
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل حفظ التعديلات',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          titleText: Text(
            'خطاء',
            style: TextStyle(color: Colors.white),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            'فشل حفظ التعديلات',
            style: TextStyle(color: Colors.white),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ));
    }
  }
}

class TrainingDay {
  String day;
  List<Exercise> exercises;

  TrainingDay({required this.day, required this.exercises});
}

class Exercise {
  String name;
  int rounds;
  int repetitions;

  Exercise(
      {required this.name, required this.rounds, required this.repetitions});
}
