import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

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
      {required TextEditingController controller, required String label}) {
    return TextField(
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
          backgroundColor: Palette.mainAppColor,
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
    return Card(
      color: Palette.secondaryColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day.day,
              style: const TextStyle(
                  color: Palette.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...day.exercises.map((exercise) {
              return ListTile(
                title: Text(exercise,
                    style: const TextStyle(color: Palette.white)),
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
                child: const Text("أضف تمرين",
                    style: TextStyle(color: Palette.black)),
              ),
            ),
          ],
        ),
      ),
    );
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
          title: const Text("إختر يوم التدريب"),
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
    final TextEditingController exerciseNameController =
        TextEditingController();
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
          title: const Text("أضف تمرين"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                  controller: exerciseNameController, // Use the new controller
                  label: "اسم التمرين"),
              const SizedBox(height: 16),
              _buildTextField(
                  controller: roundsController, label: "عدد الجولات"),
              const SizedBox(height: 16),
              _buildTextField(
                  controller: repetitionsController, label: "عدد التكرارات"),
              const SizedBox(height: 16),
              const Image(image: AssetImage(Assets.IronFitLogo2)),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final newExercise =
                    exerciseNameController.text; // Get text from controller
                print(newExercise);
                if (newExercise.isNotEmpty) {
                  // Check if it's not empty
                  setState(() {
                    day.exercises.add(newExercise);
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
}

class TrainingDay {
  final String day;
  final List<String> exercises;

  TrainingDay({required this.day, required this.exercises});
}
