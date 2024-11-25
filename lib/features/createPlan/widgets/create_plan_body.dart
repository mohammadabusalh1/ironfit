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
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
import 'package:ironfit/features/editPlan/widgets/ExerciseDialog.dart';
import 'package:lottie/lottie.dart';

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

  String planName = '';
  String planDescription = '';
  String selectedExerciseName = '';
  String selectedExerciseImage = '';
  String rounds = '';
  String repetitions = '';
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();
  late String dir;

  PreferencesService preferencesService = PreferencesService();
  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    dir = LocalizationService.getDir();
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
                        controller: descriptionController,
                        onChange: (value) =>
                            setState(() => planDescription = value),
                        label: LocalizationService.translateFromGeneral(
                            'planDescription'),
                        icon: Icons.description,
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
              width: 65,
              height: 65,
              child: IconButton(
                style: IconButton.styleFrom(
                  fixedSize: const Size(25, 25),
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
          Positioned(
            bottom: 92, // Distance from the bottom
            right: 24, // Distance from the left side
            child: InkWell(
              onTap: () => _addTrainingDay(context),
              child: Lottie.asset(
                'assets/jsonIcons/add150.json',
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
            height: MediaQuery.of(context).size.height * 0.25,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                ReturnBackButton(dir),
                const SizedBox(width: 12),
                Opacity(
                  opacity: 0.8,
                  child: Text(
                    LocalizationService.translateFromGeneral('myPrograms'),
                    style: AppStyles.textCairo(
                      20,
                      Palette.mainAppColorWhite,
                      FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          )
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
                              onTap: () {
                                _handleEditExercise(
                                    day, day.exercises.indexOf(exercise));
                              },
                              spaceBetweenItems: 10,
                              padding: 0,
                              withIconButton: false,
                              title: exercise.name,
                              subtitle1:
                                  "${exercise.rounds} ${LocalizationService.translateFromGeneral('rounds')}",
                              subtitle2:
                                  "${exercise.time != null ? exercise.time : exercise.repetitions} ${exercise.time != null ? LocalizationService.translateFromGeneral('seconds') : LocalizationService.translateFromGeneral('repetitions')}",
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

  Widget _buildEditDayDialog(BuildContext context,
      {TrainingDay? initialDay, int? index}) {
    var daySplit = initialDay?.day.split('-');
    String? selectedDay = daySplit!.length > 1 ? daySplit[1] : daySplit[0];

    return Theme(
      data: customThemeData,
      child: AlertDialog(
        title: Text(
            LocalizationService.translateFromGeneral('chooseTrainingDay'),
            style: AppStyles.textCairo(12, Palette.white, FontWeight.w600)),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DropdownButton<String>(
              dropdownColor: Palette.secondaryColor,
              hint: Text(
                  LocalizationService.translateFromGeneral('trainingDay'),
                  style:
                      AppStyles.textCairo(12, Palette.white, FontWeight.w600)),
              value: selectedDay,
              onChanged: (newValue) {
                setState(() {
                  selectedDay = newValue;
                });
              },
              items: [
                {
                  'value': 'sun',
                  'label': LocalizationService.translateFromGeneral('sunday')
                },
                {
                  'value': 'mon',
                  'label': LocalizationService.translateFromGeneral('monday')
                },
                {
                  'value': 'tue',
                  'label': LocalizationService.translateFromGeneral('tuesday')
                },
                {
                  'value': 'wed',
                  'label': LocalizationService.translateFromGeneral('wednesday')
                },
                {
                  'value': 'thu',
                  'label': LocalizationService.translateFromGeneral('thursday')
                },
                {
                  'value': 'fri',
                  'label': LocalizationService.translateFromGeneral('friday')
                },
                {
                  'value': 'sat',
                  'label': LocalizationService.translateFromGeneral('saturday')
                },
              ]
                  .map((day) => DropdownMenuItem(
                        value: day['value'], // Correct value assignment
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(day['label']!,
                              style: AppStyles.textCairo(
                                  14, Palette.white, FontWeight.w400)),
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
            width: 90,
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(LocalizationService.translateFromGeneral('cancel'),
                style: AppStyles.textCairo(
                    12, Palette.mainAppColorWhite, FontWeight.w600)),
          ),
        ],
        actionsAlignment: MainAxisAlignment.start,
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

  Widget _buildDayDialog(BuildContext context) {
    String? selectedDay;
    return Theme(
      data: customThemeData,
      child: Directionality(
        textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text(
              LocalizationService.translateFromGeneral('chooseTrainingDay'),
              style: AppStyles.textCairo(
                  16, Palette.mainAppColorWhite, FontWeight.w500)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                dropdownColor: Colors.grey[800],
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
                    'label': LocalizationService.translateFromGeneral('sunday')
                  },
                  {
                    'value': 'mon',
                    'label': LocalizationService.translateFromGeneral('monday')
                  },
                  {
                    'value': 'tue',
                    'label': LocalizationService.translateFromGeneral('tuesday')
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
                    'label': LocalizationService.translateFromGeneral('friday')
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
                                    14,
                                    Palette.mainAppColorWhite,
                                    FontWeight.w500)),
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
                  FocusScope.of(context).unfocus();
                }
              },
              width: 90,
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LocalizationService.translateFromGeneral('cancel'),
                  style:
                      AppStyles.textCairo(14, Palette.white, FontWeight.w500)),
            ),
          ],
          actionsAlignment: MainAxisAlignment.start,
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
    // If the user cancels, return early
    if (await confirmCancel(context)) {
      setState(() {
        trainingDays.removeAt(index);
      });
    }
  }

  void _editTrainingDay(BuildContext context, TrainingDay day, int index) {
    showDialog(
      context: context,
      builder: (context) => Directionality(
          textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
          child: _buildEditDayDialog(context, initialDay: day, index: index)),
    );
  }

  void _savePlan() async {
    if (_validatePlan()) {
      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );
        final User? user = _auth.currentUser;

        final planQuery = await _firestore
            .collection('plans')
            .where('name', isEqualTo: planName)
            .where('coachId', isEqualTo: user?.uid)
            .get();

        // If the plan already exists, show an error message
        if (planQuery.docs.isNotEmpty) {
          customSnackbar.showMessage(context,
              LocalizationService.translateFromGeneral('planNameExists'));
        } else {
          final planData = {
            'name': planName,
            'description': planDescription,
            'coachId': user?.uid,
            'createdAt': FieldValue.serverTimestamp(),
            // ignore: prefer_for_elements_to_map_fromiterable
            'trainingDays': Map.fromIterable(trainingDays,
                key: (day) =>
                    day.day.contains('-') ? day.day.split('-')[1] : day.day,
                value: (day) {
                  return day.exercises.map((exercise) {
                    return {
                      'name': exercise.name, // Exercise name
                      'repetitions':
                          exercise.repetitions, // Number of repetitions
                      'rounds': exercise.rounds, // Number of rounds
                      'image': exercise.image, // Image for the exercise
                      'time': exercise.time, // Time for the exercise
                      'useTime': exercise.time != null ? true : false,
                    };
                  }).toList(); // Convert the exercises to a list
                }),
          };

          await _firestore.collection('plans').add(planData);

          Navigator.pop(context);
          Get.toNamed(Routes.myPlans);
          customSnackbar.showSuccessMessage(context);
        }
      } catch (e) {
        print(e);
        customSnackbar.showFailureMessage(context);
      }
    }
  }

  void _addTrainingDay(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _buildDayDialog(context),
    );
  }

  bool _validatePlan() {
    if (planName.isEmpty) {
      customSnackbar.showMessage(
          context, LocalizationService.translateFromGeneral('enterPlanName'));
      return false;
    }
    if (planDescription.isEmpty) {
      customSnackbar.showMessage(context,
          LocalizationService.translateFromGeneral('enterPlanDescription'));
      return false;
    }
    if (trainingDays.isEmpty) {
      customSnackbar.showMessage(context,
          LocalizationService.translateFromGeneral('addAtLeastOneTrainingDay'));
      return false;
    }
    for (var day in trainingDays) {
      if (day.exercises.isEmpty) {
        customSnackbar.showMessage(
            context,
            LocalizationService.translateFromGeneral(
                'addAtLeastOneExercisePerTrainingDay'));
        return false;
      }
    }
    return true;
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
}

class TrainingDay {
  final String day;
  final List<Exercise> exercises;

  TrainingDay({required this.day, required this.exercises});
}

class Exercise {
  final String name;
  final String image;
  final int rounds;
  final int repetitions;
  final int? time;
  final bool useTime;

  Exercise({
    required this.name,
    required this.image,
    required this.rounds,
    required this.repetitions,
    this.time,
    this.useTime = false,
  });

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'] ?? map['Exercise_Name'] as String,
      image: map['image'] ?? map['Exercise_Image'] as String,
      rounds: map['rounds'] ?? 0,
      repetitions: map['repetitions'] ?? 0,
      time: map['time'] ?? 0,
      useTime: map['useTime'] ?? false,
    );
  }
}
