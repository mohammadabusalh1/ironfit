import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CarouselItem.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/theme.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';

class ExercisesScreen extends StatefulWidget {
  final String fileName;
  const ExercisesScreen({super.key, required this.fileName});

  @override
  _ExercisesScreenState createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  // Constants
  static const int _itemsPerPage = 10;
  static const List<String> exerciseFiles = [
    'back_exercises',
    'cardio_exercises',
    'chest_exercises',
    'lower arms_exercises',
    'lower legs_exercises',
    'neck_exercises',
    'shoulders_exercises',
    'upper arms_exercises',
    'upper legs_exercises',
    'waist_exercises'
  ];

  // State variables
  int _itemCount = _itemsPerPage;
  List<Map<String, dynamic>> _filteredExercises = [];
  List<Map<String, dynamic>> _allExercises = [];
  Set<String> _targetMuscles = {};
  String _fileNameSelected = '';
  String _targetMuscleSelected = '';
  int _stage = 1;
  bool _isLoading = true;
  late String _dir;

  final List<Map<String, String>> _selectedExercises = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _dir = LocalizationService.getDir();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _loadAllExercises();
    // await _load('back_exercises');
  }

  Future<void> _loadAllExercises() async {
    try {
      List<Map<String, dynamic>> allLoadedExercises = [];

      for (String fileName in exerciseFiles) {
        final jsonString =
            await rootBundle.loadString('assets/exresices/$fileName.json');
        final List<dynamic> jsonList = json.decode(jsonString);
        allLoadedExercises
            .addAll(jsonList.map((item) => Map<String, dynamic>.from(item)));
      }

      setState(() {
        _allExercises = allLoadedExercises;
        _filteredExercises = allLoadedExercises;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading exercises: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _load(String fileName) async {
    setState(() {
      _filteredExercises = _allExercises
          .where((exercise) =>
              _normalizeString(exercise['bodyPart']) ==
              _normalizeString(fileName.replaceAll('_exercises', '')))
          .toList();
      _itemCount = _itemsPerPage;
      _fileNameSelected = fileName;
      _loadTargetMuscles();
    });
  }

  String _normalizeString(String input) =>
      input.toLowerCase().replaceAll(' ', '_');

  void _loadTargetMuscles() {
    _targetMuscles = _filteredExercises
        .map((exercise) => exercise['target'].toString())
        .toSet();
    _targetMuscleSelected = _targetMuscles.first;
  }

  void _searchExercises(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredExercises = _fileNameSelected.isEmpty
            ? _allExercises
            : _allExercises
                .where((exercise) =>
                    _normalizeString(exercise['bodyPart']) ==
                    _normalizeString(
                        _fileNameSelected.replaceAll('_exercises', '')))
                .toList();
      } else {
        final lowercaseQuery = query.toLowerCase();
        _filteredExercises = _allExercises.where((exercise) {
          return exercise['name']
                  .toString()
                  .toLowerCase()
                  .contains(lowercaseQuery) ||
              exercise['target']
                  .toString()
                  .toLowerCase()
                  .contains(lowercaseQuery) ||
              exercise['bodyPart']
                  .toString()
                  .toLowerCase()
                  .contains(lowercaseQuery);
        }).toList();
      }
      _itemCount = _itemsPerPage;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() => _itemCount += _itemsPerPage);
    }
    setState(() => _stage = _scrollController.position.pixels == 0 ? 1 : 2);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Build methods for UI components
  Widget _buildDropdowns() {
    if (_stage != 1) return const SizedBox();

    return Column(
      children: [
        _buildBodyPartDropdown(),
        const SizedBox(height: 8),
        _buildTargetMuscleDropdown(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildBodyPartDropdown() {
    return DropdownButton<String>(
      value:
          _fileNameSelected.isEmpty ? exerciseFiles.first : _fileNameSelected,
      items: exerciseFiles.map((String fileName) {
        return DropdownMenuItem<String>(
          value: fileName,
          child: Text(
            fileName.replaceAll('_exercises', '').replaceAll('_', ' '),
            style: const TextStyle(color: Palette.white),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) _load(newValue);
      },
      dropdownColor: Palette.secondaryColor,
    );
  }

  Widget _buildTargetMuscleDropdown() {
    return DropdownButton<String>(
      value: _targetMuscleSelected,
      items: _targetMuscles.map((String target) {
        return DropdownMenuItem<String>(
          value: target,
          child: Text(
            target.replaceAll('_', ' '),
            style: const TextStyle(color: Palette.white),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => _targetMuscleSelected = newValue);
        }
      },
      dropdownColor: Palette.secondaryColor,
    );
  }

  Widget _buildExerciseList() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Palette.mainAppColorWhite,
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _itemCount.clamp(0, _filteredExercises.length),
      itemBuilder: (context, index) {
        if (index >= _filteredExercises.length) return null;

        final exercise = _filteredExercises[index];
        final isSelected = _selectedExercises
            .any((e) => e['Exercise_Name'] == exercise['name']);

        return Column(
          children: [
            GestureDetector(
              onTap: () => _toggleExerciseSelection(exercise),
              child: buildCarouselItem(
                exercise.cast<String, String>(),
                padding: 150,
                isSelected: isSelected,
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  void _toggleExerciseSelection(Map<String, dynamic> exercise) {
    setState(() {
      final exerciseName = exercise['name'];
      if (_selectedExercises.any((e) => e['Exercise_Name'] == exerciseName)) {
        _selectedExercises
            .removeWhere((e) => e['Exercise_Name'] == exerciseName);
      } else {
        _selectedExercises.add({
          'Exercise_Name': exerciseName,
          'Exercise_Image': exercise['gifUrl'],
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: customThemeData,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AlertDialog(
                title: Text(
                  LocalizationService.translateFromGeneral('selectExercise'),
                  style: const TextStyle(color: Palette.white, fontSize: 20),
                ),
                content: Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    children: [
                      _stage == 1 ? _buildDropdowns() : SizedBox(),
                      _stage == 1 ? const SizedBox(height: 8) : SizedBox(),
                      BuildTextField(
                        dir: _dir,
                        label: LocalizationService.translateFromGeneral(
                            'searchPrompt'),
                        onChange: (v) {
                          _searchExercises(v);
                        },
                        controller: _searchController,
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: _isLoading
                            ? Center(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color:
                                        Palette.secondaryColor.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircularProgressIndicator(
                                        color: Palette.mainAppColorWhite,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        LocalizationService
                                            .translateFromGeneral('loading'),
                                        style: AppStyles.textCairo(
                                            14, Palette.white, FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : _buildExerciseList(),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildIconButton(
                            width: 70,
                            height: 40,
                            fontSize: 12,
                            icon: Icons.arrow_upward,
                            backgroundColor: Palette.mainAppColorWhite,
                            iconColor: Palette.mainAppColorNavy,
                            onPressed: () {
                              setState(() {
                                _scrollController.jumpTo(0);
                              });
                            },
                          ),
                          BuildIconButton(
                            width: 75,
                            height: 40,
                            fontSize: 12,
                            text: LocalizationService.translateFromGeneral(
                                'save'),
                            onPressed: () =>
                                Navigator.of(context).pop(_selectedExercises),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              LocalizationService.translateFromGeneral(
                                  'cancel'),
                              style: const TextStyle(color: Palette.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Optional: Add a loading overlay for operations
              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black26,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
