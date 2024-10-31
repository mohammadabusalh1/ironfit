import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/widgets/PagesHeader.dart';
import 'package:ironfit/core/presentation/widgets/StatisticsCard.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/features/dashboard/widgets/card_widget.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isDataLoaded = false;
String fullName = 'إسم المستخد';
String email = 'لا يوجد بيانات';
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
  Future<void> _checkToken() async {
    SharedPreferences prefs = await preferencesService.getPreferences();
    String? token = prefs.getString('token');

    if (token == null) {
      Get.toNamed(Routes.singIn); // Navigate to coach dashboard
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStatisticsData();
    if (!isDataLoaded) {
      _checkToken();
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
    // Get user data from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection(
            'coaches') // or 'coaches', depending on where you store user data
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
      print("User data not found");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  subtitle: LocalizationService.translateFromGeneral('myGyms'),
                  imagePath: Assets.myGymImage,
                  description:
                      LocalizationService.translateFromGeneral('addGymInfo'),
                ),
                const SizedBox(height: 24),
                _buildCardWidget(
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

  Widget _buildDashboardHeader() {
    return DashboardHeader(
      backgroundImage: Assets.dashboardBackground, // Background image path
      trainerImage: imageUrl, // Trainer image path
      trainerName: fullName, // Trainer's name
      trainerEmail: email, // Trainer's email
    );
  }

  Widget _buildStatisticsRow(BuildContext context, Map<String, dynamic> data) {
    return Row(
      children: [
        _buildStatisticsCard(
            "${data['trainees']} ${LocalizationService.translateFromGeneral('trainee')}",
            LocalizationService.translateFromGeneral('trainees'),
            context,
            Icons.person_outline),
        const Spacer(), // Adjusted for consistent spacing
        _buildStatisticsCard(
            data['subscriptions'].toString() + "+%",
            LocalizationService.translateFromGeneral('subscription'),
            context,
            Icons.percent_outlined),
      ],
    );
  }

  Widget _buildStatisticsCard(
      String subTitle, String title, BuildContext context, IconData icon) {
    return StatisticsCard(
      cardSubTitle: subTitle,
      cardTitle: title,
      width: MediaQuery.of(context).size.width * 0.4,
      height: 90,
      icon: icon,
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
