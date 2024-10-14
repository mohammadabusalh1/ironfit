import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/widgets/PagesHeader.dart';
import 'package:ironfit/core/presentation/widgets/StatisticsCard.dart';
import 'package:ironfit/core/presentation/widgets/getCoachId.dart';
import 'package:ironfit/features/dashboard/widgets/card_widget.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoachDashboardBody extends StatelessWidget {
  final CoachDashboardController controller =
      Get.put(CoachDashboardController());

  // Future to fetch data from Firestore
  Future<Map<String, dynamic>> fetchStatisticsData() async {
    try {
      // Fetch statistics data from Firebase
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('coaches')
          .doc(await fetchCoachId())
          .get();

      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        return {
          'trainees': data['trainees'] ?? 0,
          'subscriptions': data['subscriptions'] ?? 0,
        };
      } else {
        throw Exception('Document not found');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return {'trainees': 0, 'subscriptions': 0}; // Default values
    }
  }

  CoachDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchStatisticsData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('خطأ: ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data!;
          return Column(
            children: [
              _buildDashboardHeader(),
              const SizedBox(height: 24),
              Container(
                height: MediaQuery.of(context).size.height * 0.63,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildStatisticsRow(context, data),
                      const SizedBox(height: 24),
                      _buildCardWidget(
                        onTap: () => Get.toNamed(Routes.myGyms),
                        subtitle: 'الصالات الرياضية الخاص بي',
                        imagePath: Assets.myGymImage,
                        description: 'أضف معلومات النادي الرياضي الخاص بك',
                      ),
                      const SizedBox(height: 24),
                      _buildCardWidget(
                        onTap: () => Get.toNamed(Routes.trainees),
                        subtitle: 'المتدربين',
                        imagePath: Assets.myTrainerImage,
                        description: 'أضف معلومات المتدربين الخاصين بك',
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return const Center(child: Text('لا توجد بيانات'));
      },
    );
  }

  Widget _buildDashboardHeader() {
    return const DashboardHeader(
      backgroundImage: Assets.dashboardBackground, // Background image path
      trainerImage: Assets.myTrainerImage, // Trainer image path
      trainerName: "محمد ابو صالح", // Trainer's name
      trainerEmail: "oG2gU@example.com", // Trainer's email
    );
  }

  Widget _buildStatisticsRow(BuildContext context, Map<String, dynamic> data) {
    return Row(
      children: [
        _buildStatisticsCard(data['trainees'].toString(), "متدرب", context),
        const Spacer(), // Adjusted for consistent spacing
        _buildStatisticsCard(
            data['subscriptions'].toString(), "الإشتراك", context),
      ],
    );
  }

  Widget _buildStatisticsCard(
      String subTitle, String title, BuildContext context) {
    return StatisticsCard(
      cardSubTitle: subTitle,
      cardTitle: title,
      width: MediaQuery.of(context).size.width * 0.4,
      height: 90,
    );
  }

  Widget _buildCardWidget({
    required void Function() onTap,
    required String subtitle,
    required String imagePath,
    required String description,
  }) {
    return CardWidget(
      onTap: onTap,
      subtitle: subtitle,
      imagePath: imagePath,
      description: description,
    );
  }
}
