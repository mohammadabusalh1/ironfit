import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/dashboard/controllers/trainer_dashboard_controller.dart';
import 'package:ironfit/core/presention/style/palette.dart';


class TrainerDashboardBody extends StatelessWidget {
  final TranierDashboardController dashboardController = Get.find();
  final TranierDashboardController controller = Get.put(TranierDashboardController());

  TrainerDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(Assets.myTrainerImage),
              radius: 20,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Statistics Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard('Exercises', '3/12', '2.5% vs Yesterday', Icons.fitness_center),
                const SizedBox(width: 20,),
                _buildStatCard('Calories', '2,351', '0.1% vs Yesterday', Icons.local_fire_department),
              ],
            ),
            const SizedBox(height: 50),
            // Main Grid Menu
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard('Activity', 'Track your Progress', Icons.bar_chart, Routes.userStatistics),
                  _buildMenuCard('Workouts', 'Manage your Exercises', Icons.fitness_center, Routes.plan),
                  _buildMenuCard('Diets', 'Count your Calories', Icons.restaurant_menu, Routes.dashboard),
                  _buildMenuCard('Goals', 'Crush your Goals', Icons.star, Routes.dashboard),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build the top statistics card
  Widget _buildStatCard(String title, String value, String trend, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Palette.mainAppColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.grey),
                const SizedBox(width: 10),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Palette.black)),  // Text color set to black
              ],
            ),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Palette.black)),
            const SizedBox(height: 5),
            Text(trend, style: TextStyle(color: trend.contains('-') ? Colors.red : Palette.greenActive,fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }


  Widget _buildMenuCard(String title, String subtitle, IconData icon, String route) {
    return GestureDetector(
      onTap: () => Get.toNamed(route),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Palette.mainAppColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.grey),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Palette.black)),  // Text color set to black
            const SizedBox(height: 5),
            Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Palette.black)),
          ],
        ),
      ),
    );
  }
}
