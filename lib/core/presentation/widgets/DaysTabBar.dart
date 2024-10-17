import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/exrciseCard.dart';

class CustomTabBarWidget extends StatefulWidget {
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
        Tab(text: 'Mon'),
        Tab(text: 'Tue'),
        Tab(text: 'Wed'),
        Tab(text: 'Thu'),
        Tab(text: 'Fri'),
        Tab(text: 'Sat'),
        Tab(text: 'Sun'),
      ],
    );
  }

  // Reusable TabBarView component
  Widget buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        buildTabContent('تمارين يوم الإثنين'),
        buildTabContent('Tuesday Content'),
        buildTabContent('Wednesday Content'),
        buildTabContent('Thursday Content'),
        buildTabContent('Friday Content'),
        buildTabContent('Saturday Content'),
        buildTabContent('Sunday Content'),
      ],
    );
  }

  // Reusable content builder for each tab
  Widget buildTabContent(String content) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 24),
          Center(
            child: Text(content, style: TextStyle(color: Palette.white)),
          ),
          SizedBox(height: 24),
          ExrciseCard(
              image:
                  'https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62e-palms-down-wrist-curl-over-bench-m1-square-600x600.jpg',
              title: "Atlas Stones",
              subtitle1: "3 جولات",
              subtitle2: "12 تكرار"),
          SizedBox(height: 24),
          ExrciseCard(
              image:
                  'https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62e-palms-down-wrist-curl-over-bench-m1-square-600x600.jpg',
              title: "Atlas Stones",
              subtitle1: "3 جولات",
              subtitle2: "12 تكرار"),
          SizedBox(height: 24),
          ExrciseCard(
              image:
                  'https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62e-palms-down-wrist-curl-over-bench-m1-square-600x600.jpg',
              title: "Atlas Stones",
              subtitle1: "3 جولات",
              subtitle2: "12 تكرار"),
          SizedBox(height: 24),
          ExrciseCard(
              image:
                  'https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62e-palms-down-wrist-curl-over-bench-m1-square-600x600.jpg',
              title: "Atlas Stones",
              subtitle1: "3 جولات",
              subtitle2: "12 تكرار"),
          SizedBox(height: 24),
          ExrciseCard(
              image:
                  'https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62e-palms-down-wrist-curl-over-bench-m1-square-600x600.jpg',
              title: "Atlas Stones",
              subtitle1: "3 جولات",
              subtitle2: "12 تكرار"),
          SizedBox(height: 24),
          ExrciseCard(
              image:
                  'https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62e-palms-down-wrist-curl-over-bench-m1-square-600x600.jpg',
              title: "Atlas Stones",
              subtitle1: "3 جولات",
              subtitle2: "12 تكرار"),
        ],
      ),
    );
  }
}
