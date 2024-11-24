import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/confirmRemove.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/exrciseCard.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/theme.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/createPlan/widgets/create_plan_body.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
import 'package:ironfit/features/editPlan/widgets/ExerciseDialog.dart';
import 'package:lottie/lottie.dart';

class EditPlanBody extends StatefulWidget {
  const EditPlanBody({super.key, required this.planId});

  final String planId;

  @override
  _EditPlanBodyState createState() => _EditPlanBodyState();
}

class _EditPlanBodyState extends State<EditPlanBody> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String planName = LocalizationService.translateFromGeneral('noName');
  String planDescription =
      LocalizationService.translateFromGeneral('noDescription');
  String selectedExerciseName = '';
  String selectedExerciseImage = '';
  String rounds = '';
  String repetitions = '';
  late TextEditingController planController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

  List<TrainingDay> trainingDays = [];

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();
  late String dir;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    _fetchPlanData();
    dir = LocalizationService.getDir();
  }

  Future<void> _fetchPlanData() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        print('User is not authenticated');
        return;
      }

      final planDoc =
          await _firestore.collection('plans').doc(widget.planId).get();

      if (!planDoc.exists) {
        print('Plan document does not exist');
        return;
      }

      final planData = planDoc.data();

      if (planData == null || planData.isEmpty) {
        print('Plan data is empty');
        return;
      }

      // Safely access fields and provide fallback values
      final fetchedPlanName = planData['name'] ?? 'No plan name';
      final fetchedPlanDescription =
          planData['description'] ?? 'No description available';
      setState(() {
        planName = fetchedPlanName;
        planController = TextEditingController(text: fetchedPlanName);
        planDescription = fetchedPlanDescription;
        descriptionController =
            TextEditingController(text: fetchedPlanDescription);
        trainingDays = (planData['trainingDays'] as Map?)?.entries.map((e) {
              final day = e.key;
              final exercises = (e.value as List?)?.map((exercise) {
                    return Exercise(
                      name: exercise['name'] ?? 'Unnamed exercise',
                      rounds: exercise['rounds'] ?? 0,
                      repetitions: exercise['repetitions'] ?? 0,
                      image:
                          exercise['image'] ?? 'https://default-image-url.jpg',
                      time: exercise['time'],
                      useTime: exercise['useTime'] ?? false,
                    );
                  }).toList() ??
                  [];

              return TrainingDay(day: day, exercises: exercises);
            }).toList() ??
            [];
      });
    } catch (e) {
      print('Error fetching plan data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
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
                        dir: dir,
                        controller: planController,
                        onChange: (value) => setState(() {
                          planName = value;
                        }),
                        label: LocalizationService.translateFromGeneral(
                            'planName'),
                        icon: Icons.edit,
                      ),
                      const SizedBox(height: 16),
                      BuildTextField(
                        dir: dir,
                        icon: Icons.description,
                        controller: descriptionController,
                        onChange: (value) =>
                            setState(() => planDescription = value),
                        label: LocalizationService.translateFromGeneral(
                            'planDescription'),
                      ),
                      _buildTrainingDaysList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 92, // Distance from the bottom
            right: 24, // Distance from the left side
            child: InkWell(
              onTap: () => _addTrainingDay(),
              child: Lottie.asset(
                'assets/jsonIcons/add150.json',
              ),
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
          const HeaderImage(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Row(
              children: [
                ReturnBackButton(dir),
                const SizedBox(width: 12),
                Opacity(
                  opacity: 0.8,
                  child: Text(
                    LocalizationService.translateFromGeneral('editPlan'),
                    style: AppStyles.textCairo(
                        20, Palette.mainAppColorWhite, FontWeight.w800),
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
              color: Palette.mainAppColorWhite.withOpacity(0.4),
              style: BorderStyle.solid,
              width: 2)),
      color: Palette.mainAppColoryellow2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => _editTrainingDay(context, day, index),
                  child: Row(
                    children: [
                      Text(
                        dayName == 'sun'
                            ? LocalizationService.translateFromGeneral('sunday')
                            : dayName == 'mon'
                                ? LocalizationService.translateFromGeneral(
                                    'monday')
                                : dayName == 'tue'
                                    ? LocalizationService.translateFromGeneral(
                                        'tuesday')
                                    : dayName == 'wed'
                                        ? LocalizationService
                                            .translateFromGeneral('wednesday')
                                        : dayName == 'thu'
                                            ? LocalizationService
                                                .translateFromGeneral(
                                                    'thursday')
                                            : dayName == 'fri'
                                                ? LocalizationService
                                                    .translateFromGeneral(
                                                        'friday')
                                                : LocalizationService
                                                    .translateFromGeneral(
                                                        'saturday'),
                        style: AppStyles.textCairo(
                            18, Palette.white, FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => _editTrainingDay(context, day, index),
                        icon: const Icon(Icons.edit_note,
                            color: Palette.mainAppColorWhite),
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Palette.mainAppColorWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => _removeTrainingDay(index),
                  icon: const Icon(Icons.delete, color: Palette.redDelete),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ReorderableListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final Exercise item = day.exercises.removeAt(oldIndex);
                  day.exercises.insert(newIndex, item);
                });
              },
              children: day.exercises
                  .map(
                    (exercise) => Column(
                      key: ValueKey('${day.exercises.indexOf(exercise)}'),
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.drag_handle,
                              size: 22,
                              color: Palette.mainAppColorWhite,
                            ),
                            const Spacer(),
                            ExrciseCard(
                              onTap: () => _handleEditExercise(
                                  day, day.exercises.indexOf(exercise)),
                              spaceBetweenItems: 10,
                              padding: 0,
                              withIconButton: false,
                              title: exercise.name,
                              subtitle1:
                                  "${exercise.rounds} ${LocalizationService.translateFromGeneral('rounds')}",
                              subtitle2:
                                  "${exercise.useTime ? exercise.time : exercise.repetitions} ${exercise.time != null ? LocalizationService.translateFromGeneral('seconds') : LocalizationService.translateFromGeneral('repetitions')}",
                              image: exercise.image,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => _removeExercise(day, exercise),
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        // Add space between rows
                        const SizedBox(
                            height: 10), // Adjust the height as per your need
                      ],
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: BuildIconButton(
                text: LocalizationService.translateFromGeneral('addExercise'),
                onPressed: () => _addExerciseToDay(day),
                backgroundColor: Palette.mainAppColorWhite,
                width: 130,
                fontSize: 12,
                textColor: Palette.mainAppColorNavy,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeExercise(TrainingDay day, Exercise exercise) async {
    if (await confirmCancel(context)) {
      setState(() {
        day.exercises.remove(exercise);
      });
    }
  }

  void _removeTrainingDay(int index) async {
    if (await confirmCancel(context)) {
      setState(() {
        trainingDays.removeAt(index);
      });
    }
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
        data: customThemeData,
        child: Directionality(
          textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            title: Text(
                LocalizationService.translateFromGeneral('chooseTrainingDay'),
                style: AppStyles.textCairo(
                    14, Palette.mainAppColorWhite, FontWeight.w500)),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<String>(
                  dropdownColor: Palette.secondaryColor,
                  hint: Text(
                      LocalizationService.translateFromGeneral('trainingDay'),
                      style: AppStyles.textCairo(
                          14, Palette.mainAppColorWhite, FontWeight.w500)),
                  value: selectedDay,
                  onChanged: (newValue) {
                    setState(() {
                      selectedDay = newValue;
                    });
                  },
                  items: [
                    {
                      'value': 'sun',
                      'label':
                          LocalizationService.translateFromGeneral('sunday')
                    },
                    {
                      'value': 'mon',
                      'label':
                          LocalizationService.translateFromGeneral('monday')
                    },
                    {
                      'value': 'tue',
                      'label':
                          LocalizationService.translateFromGeneral('tuesday')
                    },
                    {
                      'value': 'wed',
                      'label':
                          LocalizationService.translateFromGeneral('wednesday')
                    },
                    {
                      'value': 'thu',
                      'label':
                          LocalizationService.translateFromGeneral('thursday')
                    },
                    {
                      'value': 'fri',
                      'label':
                          LocalizationService.translateFromGeneral('friday')
                    },
                    {
                      'value': 'sat',
                      'label':
                          LocalizationService.translateFromGeneral('saturday')
                    },
                  ]
                      .map((day) => DropdownMenuItem(
                            value: '${day['label']}-${day['value']}',
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(day['label']!,
                                  style: AppStyles.textCairo(
                                      14, Palette.white, FontWeight.w500)),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
            actions: [
              BuildIconButton(
                text: LocalizationService.translateFromGeneral('save'),
                onPressed: () {
                  if (selectedDay != null) {
                    setState(() {
                      trainingDays
                          .add(TrainingDay(day: selectedDay!, exercises: []));
                    });
                    Navigator.pop(context);
                  }
                },
                width: 90,
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(LocalizationService.translateFromGeneral('cancel'),
                    style: AppStyles.textCairo(
                        14, Palette.mainAppColorWhite, FontWeight.w500)),
              ),
            ],
            actionsAlignment: MainAxisAlignment.start,
          ),
        ));
  }

  void _addExerciseToDay(TrainingDay day) {
    Future<void> addExercise(Exercise exercise) async {
      setState(() {
        day.exercises.add(exercise);
      });
    }

    showDialog(
      context: context,
      builder: (context) => ExerciseDialog(
        addExercise: addExercise,
      ),
    );
  }

  void editExercise(TrainingDay day, int index, Exercise updatedExercise) {
    setState(() {
      day.exercises[index] = updatedExercise;
    });
  }

  void _handleEditExercise(TrainingDay day, int index) {
    Exercise currentExercise = day.exercises[index];

    // Open an edit dialog to update exercise details
    showDialog(
      context: context,
      builder: (context) => ExerciseDialog(
        addExercise: (updatedExercise) {
          editExercise(day, index, updatedExercise);
        },
        initialExercise:
            currentExercise, // Pass the current exercise data to edit
      ),
    );
  }

  void _editTrainingDay(BuildContext context, TrainingDay day, int index) {
    showDialog(
      context: context,
      builder: (context) =>
          _buildEditDayDialog(context, initialDay: day, index: index),
    );
  }

  Widget _buildEditDayDialog(BuildContext context,
      {TrainingDay? initialDay, int? index}) {
    var daySplit = initialDay?.day.split('-');
    String? selectedDay = daySplit!.length > 1
        ? daySplit[1] // Extract the day value
        : daySplit[0];

    return Theme(
        data: customThemeData,
        child: Directionality(
          textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            title: Text(
                LocalizationService.translateFromGeneral('chooseTrainingDay'),
                style: AppStyles.textCairo(14, Palette.white, FontWeight.w500)),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<String>(
                  dropdownColor: Colors.grey[800],
                  hint: Text(
                      LocalizationService.translateFromGeneral('trainingDay'),
                      style: AppStyles.textCairo(
                          14, Palette.white, FontWeight.w500)),
                  value: selectedDay,
                  onChanged: (newValue) {
                    setState(() {
                      selectedDay = newValue;
                    });
                  },
                  items: [
                    {
                      'value': 'sun',
                      'label':
                          LocalizationService.translateFromGeneral('sunday')
                    },
                    {
                      'value': 'mon',
                      'label':
                          LocalizationService.translateFromGeneral('monday')
                    },
                    {
                      'value': 'tue',
                      'label':
                          LocalizationService.translateFromGeneral('tuesday')
                    },
                    {
                      'value': 'wed',
                      'label':
                          LocalizationService.translateFromGeneral('wednesday')
                    },
                    {
                      'value': 'thu',
                      'label':
                          LocalizationService.translateFromGeneral('thursday')
                    },
                    {
                      'value': 'fri',
                      'label':
                          LocalizationService.translateFromGeneral('friday')
                    },
                    {
                      'value': 'sat',
                      'label':
                          LocalizationService.translateFromGeneral('saturday')
                    },
                  ]
                      .map((day) => DropdownMenuItem(
                            value: day['value'], // Correct value assignment
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(day['label']!,
                                  style: AppStyles.textCairo(
                                      14, Palette.white, FontWeight.w500)),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
            actions: [
              BuildIconButton(
                width: 90,
                text: LocalizationService.translateFromGeneral('save'),
                onPressed: () {
                  if (selectedDay != null) {
                    setState(() {
                      if (index != null) {
                        // Edit existing day
                        trainingDays[index] = TrainingDay(
                            day: selectedDay!,
                            exercises: trainingDays[index].exercises);
                      } else {
                        // Add new day
                        trainingDays
                            .add(TrainingDay(day: selectedDay!, exercises: []));
                      }
                    });
                    Navigator.pop(context);
                  }
                },
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(LocalizationService.translateFromGeneral('cancel'),
                    style: AppStyles.textCairo(
                        14, Palette.white, FontWeight.w500)),
              ),
            ],
            actionsAlignment: MainAxisAlignment.start,
          ),
        ));
  }

  Future<void> _savePlan() async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('plans').doc(widget.planId).update({
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
                            'time': e.time,
                            'useTime': e.time != null ? true : false,
                          })
                      .toList()
          }
        });
        Get.toNamed(Routes.trainees);
        customSnackbar.showSuccessMessage(context);
        Get.toNamed(Routes.myPlans);
      }
    } catch (e) {
      customSnackbar.showFailureMessage(context);
    }
  }
}
