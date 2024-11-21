import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/exrciseCard.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/features/createPlan/widgets/create_plan_body.dart';

class CustomTabBarWidget extends StatefulWidget {
  final plan;
  const CustomTabBarWidget({super.key, required this.plan});
  @override
  _CustomTabBarWidgetState createState() => _CustomTabBarWidgetState();
}

class _CustomTabBarWidgetState extends State<CustomTabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this); // 7 days in a week
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          buildTabBar(),
          Expanded(
            child: buildTabBarView(),
          ),
        ],
      ),
    );
  }

  // Reusable TabBar component
  Widget buildTabBar() {
    return TabBar(
      isScrollable: true, // Allow horizontal scrolling
      labelColor: Colors.white, // Replace with your theme color
      unselectedLabelColor: Colors.grey, // Replace with your theme color
      labelStyle: const TextStyle(
        fontFamily: 'Inter Tight',
        letterSpacing: 0.0,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'Inter Tight',
        letterSpacing: 0.0,
      ),
      indicatorColor: Palette.mainAppColor, // Replace with your theme color
      controller: _tabController,
      onTap: (index) {
        // Handle tab selection logic here
      },
      tabs: [
        Tab(text: LocalizationService.translateFromGeneral('monday')),
        Tab(text: LocalizationService.translateFromGeneral('tuesday')),
        Tab(text: LocalizationService.translateFromGeneral('wednesday')),
        Tab(text: LocalizationService.translateFromGeneral('thursday')),
        Tab(text: LocalizationService.translateFromGeneral('friday')),
        Tab(text: LocalizationService.translateFromGeneral('saturday')),
        Tab(text: LocalizationService.translateFromGeneral('sunday')),
      ],
    );
  }

  // Reusable TabBarView component
  Widget buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        buildTabContent(
            LocalizationService.translateFromGeneral('mondayExercises'),
            (widget.plan?['trainingDays']?['mon'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            LocalizationService.translateFromGeneral('tuesdayExercises'),
            (widget.plan?['trainingDays']?['tue'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            LocalizationService.translateFromGeneral('wednesdayExercises'),
            (widget.plan?['trainingDays']?['wed'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            LocalizationService.translateFromGeneral('thursdayExercises'),
            (widget.plan?['trainingDays']?['thu'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            LocalizationService.translateFromGeneral('fridayExercises'),
            (widget.plan?['trainingDays']?['fri'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            LocalizationService.translateFromGeneral('saturdayExercises'),
            (widget.plan?['trainingDays']?['sat'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            LocalizationService.translateFromGeneral('sundayExercises'),
            (widget.plan?['trainingDays']?['sun'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
      ],
    );
  }

  // Reusable content builder for each tab
  Widget buildTabContent(String content, List<Exercise> exercises) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24),
            Center(
              child: Text(content, style: const TextStyle(color: Palette.white)),
            ),
            const SizedBox(height: 24),
            ...exercises.map((exercise) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: ExrciseCard(
                image: exercise.image,
                title: exercise.name,
                subtitle1: "${exercise.rounds} ${LocalizationService.translateFromGeneral('rounds')}",
                subtitle2: "${exercise.repetitions} ${LocalizationService.translateFromGeneral('repetitions')}",
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
