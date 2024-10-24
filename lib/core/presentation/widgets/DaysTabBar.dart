import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/exrciseCard.dart';
import 'package:ironfit/features/createPlan/widgets/create_plan_body.dart';

class CustomTabBarWidget extends StatefulWidget {
  final plan;
  const CustomTabBarWidget({Key? key, required this.plan}) : super(key: key);
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
    return Expanded(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: buildTabBar(),
          ),
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
      labelStyle: TextStyle(
        fontFamily: 'Inter Tight',
        letterSpacing: 0.0,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Inter Tight',
        letterSpacing: 0.0,
      ),
      indicatorColor: Palette.mainAppColor, // Replace with your theme color
      controller: _tabController,
      onTap: (index) {
        // Handle tab selection logic here
      },
      tabs: [
        Tab(text: 'الإثنين'),
        Tab(text: 'الثلاثاء'),
        Tab(text: 'الأربعاء'),
        Tab(text: 'الخميس'),
        Tab(text: 'الجمعة'),
        Tab(text: 'السبت'),
        Tab(text: 'الأحد'),
      ],
    );
  }

  // Reusable TabBarView component
  Widget buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        buildTabContent(
            'تمارين يوم الاثنين',
            (widget.plan?['trainingDays']?['mon'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            'تمارين يوم الثلاثاء',
            (widget.plan?['trainingDays']?['tue'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            'تمارين يوم الاربعاء',
            (widget.plan?['trainingDays']?['wed'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            'تمارين يوم الخميس',
            (widget.plan?['trainingDays']?['thu'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            'تمارين يوم الجمعة',
            (widget.plan?['trainingDays']?['fri'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            'تمارين يوم السبت',
            (widget.plan?['trainingDays']?['sat'] as List<dynamic>?)
                    ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                    .toList() ??
                []),
        buildTabContent(
            'تمارين يوم الاحد',
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 24),
          Center(
            child: Text(content, style: TextStyle(color: Palette.white)),
          ),
          SizedBox(height: 24),
          ...exercises.map((exercise) {
            return Column(
              children: [
                ExrciseCard(
                  image: exercise.image,
                  title: exercise.name,
                  subtitle1: "${exercise.rounds} جولات",
                  subtitle2: "${exercise.repetitions} تكرار",
                ),
                SizedBox(height: 24),
              ],
            );
          }).toList(), // Spread operator to flatten the list
        ],
      ),
    );
  }
}
