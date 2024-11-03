import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/PagesHeader.dart';
import 'package:ironfit/core/presentation/widgets/StatisticsCard.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/features/dashboard/widgets/card_widget.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool isDataLoaded = false;
String fullName = LocalizationService.translateFromGeneral('noData');
String email = LocalizationService.translateFromGeneral('noData');
String imageUrl =
    'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg';
Map<String, dynamic> data = {
  'trainees': '0',
  'subscriptions': '0',
};

class CoachDashboardBody extends StatefulWidget {
  const CoachDashboardBody({Key? key}) : super(key: key);

  @override
  CoachDashboardState createState() => CoachDashboardState();
}

class CoachDashboardState extends State<CoachDashboardBody> {
  final CoachDashboardController controller =
      Get.put(CoachDashboardController());

  String coachId = FirebaseAuth.instance.currentUser!.uid;

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    fetchStatisticsData();
    if (!isDataLoaded) {
      fetchUserName();
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  // Future to fetch data from Firestore
  Future<void> fetchStatisticsData() async {
    try {
      // Fetch statistics data from Firebase for the current month
      CollectionReference<Map<String, dynamic>> subscriptions =
          FirebaseFirestore.instance
              .collection('coaches')
              .doc(coachId)
              .collection('subscriptions');

      QuerySnapshot<Map<String, dynamic>> snapshot = await subscriptions.get();

      DateTime thisMonthDate =
          DateTime.now().subtract(Duration(days: DateTime.now().day - 1));
      DateTime previousMonthDate = thisMonthDate.subtract(Duration(days: 30));

      List<QueryDocumentSnapshot<Map<String, dynamic>>> currentMonthFillter =
          snapshot.docs.where((element) {
        DateTime startDate = DateTime.parse(element.data()['startDate']);
        bool isInthisMonth = startDate.month == thisMonthDate.month;
        return isInthisMonth;
      }).toList();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> previousMonthFillter =
          snapshot.docs.where((element) {
        DateTime startDate = DateTime.parse(element.data()['startDate']);
        bool isInPreMonth = startDate.month == previousMonthDate.month;
        return isInPreMonth;
      }).toList();

      int currentMonthTrainees = currentMonthFillter.length;
      int previousMonthTrainees = previousMonthFillter.length;

      if (previousMonthTrainees == 0 && currentMonthTrainees > 0) {
        setState(() {
          data = {
            'trainees': snapshot.size,
            'subscriptions': 100,
          };
        });
      }
      double percentageDifference = previousMonthTrainees != 0
          ? ((currentMonthTrainees - previousMonthTrainees) /
                  previousMonthTrainees) *
              100
          : currentMonthTrainees != 0
              ? 100
              : 0;

      // Avoid division by zero

      // Return the result with percentage difference
      setState(() {
        data = {
          'trainees': snapshot.size,
          'subscriptions': percentageDifference,
        };
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchUserName() async {
    try {
      // Get user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('coaches')
          .doc(coachId)
          .get();

      if (userDoc.exists) {
        String? firstName = userDoc['firstName'];
        String? lastName = userDoc['lastName'];

        setState(() {
          fullName = '$firstName $lastName';
          email = userDoc['email'];
          imageUrl = userDoc['profileImageUrl'];
        });
      } else {
        // Handle case where user data is not found
        print("User data not found for coach ID: $coachId");
        // Consider throwing an exception or returning an error status here
      }
    } catch (e) {
      // Handle any errors that occur during the Firestore operation
      print("Error fetching user data: $e");
      // Consider throwing an exception or returning an error status here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardHeader(
          backgroundImage: Assets.dashboardBackground, // Background image path
          trainerImage: imageUrl, // Trainer image path
          trainerName: fullName, // Trainer's name
          trainerEmail: email, // Trainer's email
        ),
        const SizedBox(height: 24),
        Container(
          height: MediaQuery.of(context).size.height * 0.63,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildStatisticsRow(context, data),
                const SizedBox(height: 24),
                CardWidget(
                  onTap: () => Get.toNamed(Routes.myGyms),
                  subtitle: LocalizationService.translateFromGeneral('myGyms'),
                  imagePath: Assets.myGymImage,
                  description:
                      LocalizationService.translateFromGeneral('addGymInfo'),
                ),
                const SizedBox(height: 24),
                CardWidget(
                  onTap: () => Get.toNamed(Routes.trainees),
                  subtitle:
                      LocalizationService.translateFromGeneral('trainees'),
                  imagePath: Assets.myTrainerImage,
                  description: LocalizationService.translateFromGeneral(
                      'addTraineeInfo'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsRow(BuildContext context, Map<String, dynamic> data) {
    return Row(
      children: [
        StatisticsCard(
            cardSubTitle:
                "${data['trainees']} ${LocalizationService.translateFromGeneral('trainee')}",
            cardTitle: LocalizationService.translateFromGeneral('trainees'),
            width: MediaQuery.of(context).size.width * 0.4,
            height: 90,
            icon: Icons.person_outline),
        const Spacer(), // Adjusted for consistent spacing
        StatisticsCard(
            cardSubTitle: data['subscriptions'].toString() + "+%",
            cardTitle: LocalizationService.translateFromGeneral('subscription'),
            width: MediaQuery.of(context).size.width * 0.4,
            height: 90,
            icon: Icons.percent_outlined),
      ],
    );
  }
}
