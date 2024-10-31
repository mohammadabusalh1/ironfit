import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/CarouselItem.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

class ExercisesScreen extends StatefulWidget {
  final String fileName;
  ExercisesScreen({required this.fileName});

  @override
  _ExercisesScreenState createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  ScrollController _scrollController = ScrollController();
  int _itemCount = 10;
  List<dynamic> _filteredExercises = [];
  List<dynamic> exercises = [];
  String fileNameSelected = '';
  List<dynamic> targetMuscles = [];
  String targetMuscleSelected = '';

  Future<void> load(fileName) async {
    String jsonString =
        await rootBundle.loadString('assets/exresices/${fileName}.json');
    List<dynamic> jsonMap = json.decode(jsonString);
    setState(() {
      _filteredExercises = exercises = jsonMap;
      _itemCount = 10;
      fileNameSelected = fileName;
    });
    loadTargetMuscles(jsonMap);
  }

  Future<void> loadTarget(target) async {
    setState(() {
      _filteredExercises =
          exercises.where((exercise) => exercise['target'] == target).toList();
    });
  }

  Future<void> loadTargetMuscles(exercises) async {
    setState(() {
      targetMuscles =
          exercises.map((exercise) => exercise['target']).toSet().toList();
      targetMuscleSelected = targetMuscles[0];
    });
  }

  void _searchExercises(String query) {
    setState(() {
      if (query.isEmpty) {
        if (targetMuscleSelected.isNotEmpty) {
          loadTarget(targetMuscleSelected);
        } else {
          _filteredExercises = exercises;
        }
      } else {
        _filteredExercises = _filteredExercises
            .where((exercise) => exercise['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
      _itemCount = 10; // Reset item count when search query changes
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    load(widget.fileName);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _itemCount += 10;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            width: double.infinity,
            child: DropdownButton<String>(
              dropdownColor: Colors.grey[800],
              hint: Text(LocalizationService.translateFromGeneral('bodyPart'),
                  style: TextStyle(color: Palette.white)),
              value: fileNameSelected,
              onChanged: (newValue) {
                setState(() {
                  fileNameSelected = newValue!;
                  load(newValue);
                });
              },
              items: [
                {
                  'value': 'back_exercises',
                  'label': LocalizationService.translateFromGeneral('back')
                },
                {
                  'value': 'cardio_exercises',
                  'label': LocalizationService.translateFromGeneral('cardio')
                },
                {
                  'value': 'chest_exercises',
                  'label': LocalizationService.translateFromGeneral('chest')
                },
                {
                  'value': 'lower arms_exercises',
                  'label': LocalizationService.translateFromGeneral('lowerArms')
                },
                {
                  'value': 'lower legs_exercises',
                  'label': LocalizationService.translateFromGeneral('lowerLegs')
                },
                {
                  'value': 'neck_exercises',
                  'label': LocalizationService.translateFromGeneral('neck')
                },
                {
                  'value': 'shoulders_exercises',
                  'label': LocalizationService.translateFromGeneral('shoulders')
                },
                {
                  'value': 'upper arms_exercises',
                  'label': LocalizationService.translateFromGeneral('upperArms')
                },
                {
                  'value': 'upper legs_exercises',
                  'label': LocalizationService.translateFromGeneral('upperLegs')
                },
                {
                  'value': 'waist_exercises',
                  'label': LocalizationService.translateFromGeneral('waist')
                },
              ]
                  .map((day) => DropdownMenuItem(
                        value: '${day['value']}',
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(day['label']!,
                              style: const TextStyle(color: Palette.white)),
                        ),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.all(8),
            width: double.infinity,
            child: DropdownButton<String>(
              dropdownColor: Colors.grey[800],
              hint: Text(LocalizationService.translateFromGeneral('bodyPart'),
                  style: TextStyle(color: Palette.white)),
              value: targetMuscleSelected,
              onChanged: (newValue) {
                setState(() {
                  targetMuscleSelected = newValue!;
                  loadTarget(newValue);
                });
              },
              items: targetMuscles
                  .map((muscle) => {
                        'value': muscle,
                        'label': LocalizationService.translateFromGeneral(
                                        muscle)
                                    .length >
                                24
                            ? LocalizationService.translateFromGeneral(muscle)
                                .substring(0, 24)
                            : LocalizationService.translateFromGeneral(muscle)
                      })
                  .map((day) => DropdownMenuItem(
                        value: '${day['value']}',
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(day['label']!,
                              style: const TextStyle(color: Palette.white)),
                        ),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: LocalizationService.translateFromGeneral('searchPrompt'),
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(color: Palette.gray),
            ),
            onChanged: _searchExercises,
          ),
          SizedBox(height: 24),
          Container(
            height: 500,
            padding: const EdgeInsets.only(bottom: 200),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _itemCount,
              itemBuilder: (context, index) {
                try {
                  if (index < _filteredExercises.length) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Perform the action with the selected exercise
                            Navigator.of(context).pop({
                              'Exercise_Name': _filteredExercises[index]
                                  ['name'],
                              'Exercise_Image': _filteredExercises[index]
                                  ['gifUrl']
                            });
                          },
                          child: buildCarouselItem(
                            _filteredExercises[index].cast<String, String>(),
                            padding: 150,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  } else {
                    return Container(); // Return an empty container for extra items
                  }
                } catch (e) {
                  print(e);
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
