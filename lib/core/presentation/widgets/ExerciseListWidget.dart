import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/CarouselItem.dart';

class ExercisesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> exercisesJson;

  ExercisesScreen({required this.exercisesJson});

  @override
  _ExercisesScreenState createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  ScrollController _scrollController = ScrollController();
  int _itemCount = 10;
  List<Map<String, dynamic>> _filteredExercises = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _filteredExercises = widget.exercisesJson;
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

  void _searchExercises(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredExercises = widget.exercisesJson;
      } else {
        _filteredExercises = widget.exercisesJson
            .where((exercise) => exercise['Exercise_desc']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
      _itemCount = 10; // Reset item count when search query changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          // Add your search field here
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'إبحث عن تمارين...',
                prefixIcon: Icon(Icons.search),
                hintStyle: TextStyle(color: Palette.gray),
              ),
              onChanged: _searchExercises,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 400,
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
                                  ['Exercise_Name'],
                              'Exercise_Image': _filteredExercises[index]
                                  ['Exercise_Image']
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
