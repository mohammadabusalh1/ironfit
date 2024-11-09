import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/PagesHeader.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/exersiceCarousel.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

String trainerName = '';
String trainerEmail = '';
String trainerImage =
    'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg';

class TrainerDashboardBody extends StatefulWidget {
  const TrainerDashboardBody({super.key});

  @override
  _TrainerDashboardBodyState createState() => _TrainerDashboardBodyState();
}

class _TrainerDashboardBodyState extends State<TrainerDashboardBody> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, String>> exercises = [];

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  bool isDataLoaded = false;

  late BannerAd bannerAd;
  bool isBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    bannerAd = BannerAd(
        adUnitId: 'ca-app-pub-2914276526243261/1838418242',
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }));
    bannerAd.load();
    _fetchTrainerData();
    if (!isDataLoaded) {
      _fetchTrainerNameAndImage();
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  Future<void> _fetchTrainerNameAndImage() async {
    try {
      User? user = _auth.currentUser;

      // Check if user is authenticated
      if (user == null) {
        print('User is not logged in');
        return;
      }

      // Fetch user document from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('trainees').doc(user.uid).get();

      // Check if user document exists
      if (!userDoc.exists) {
        print('User document does not exist');
        return;
      }

      // Fetch user details with null safety checks
      setState(() {
        trainerName =
            '${userDoc['firstName'] ?? 'لا يوجد'} ${userDoc['lastName'] ?? 'لا يوجد'}';
        trainerEmail = userDoc['email'] ?? 'البريد الإلكتروني';
        trainerImage = userDoc['profileImageUrl'] ??
            'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg';
      });
    } catch (e) {
      // Handle any errors that occur during the Firestore operation
      print('Error fetching trainer details: $e');
      // You might want to show a snackbar, toast, or other UI feedback for the user here
    }
  }

  // Fetch trainer data from Firebase
  Future<void> _fetchTrainerData() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        print('User is not logged in');
        return;
      }

      // Fetch user document from Firestore
      QuerySnapshot<Map<String, dynamic>> subDoc = await _firestore
          .collection('subscriptions')
          .where('isActive', isEqualTo: true)
          .where(
            'userId',
            isEqualTo: user.uid,
          )
          .get();
      // Get the current day of the week
      DateTime now = DateTime.now();
      List<String> weekdays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];

      QuerySnapshot<Map<String, dynamic>> paln = await _firestore
          .collection('plans')
          .where('name', isEqualTo: subDoc.docs.first['plan'])
          .where('coachId', isEqualTo: subDoc.docs.first['coachId'])
          .get();

      Map<String, dynamic> palnDoc = paln.docs.first.data();

      // Safely fetch today's exercises
      var dynamicExercises =
          palnDoc['trainingDays'][weekdays[now.weekday - 1]] ?? [];

      // Check if dynamicExercises is a List before processing it
      if (dynamicExercises is List) {
        setState(() {
          exercises = dynamicExercises.map((exercise) {
            if (exercise is Map) {
              // Safely convert the exercise from dynamic to String
              return exercise.map(
                  (key, value) => MapEntry(key.toString(), value.toString()));
            }
            return <String,
                String>{}; // Return an empty map if the structure doesn't match
          }).toList();
        });
      } else {
        print("Error: Expected a list of exercises but got something else.");
      }
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.message}');
      // Optionally, show a snackbar or an alert to notify the user
      // ShowSnackbar or use other Flutter UI components for user-friendly error messages
    } catch (e) {
      print('Error fetching user data: $e');
      // You can log this error to a logging system or crash reporting service like Firebase Crashlytics
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.black,
      body: Column(
        children: [
          DashboardHeader(
            backgroundImage: Assets.dashboardBackground,
            trainerImage: trainerImage.isEmpty ? Assets.notFound : trainerImage,
            trainerName: trainerName,
            trainerEmail: trainerEmail,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildDashboardImage(context),
                  const SizedBox(height: 12),
                  isBannerAdLoaded
                      ? SizedBox(
                          child: AdWidget(ad: bannerAd),
                          height: bannerAd.size.height.toDouble(),
                          width: bannerAd.size.width.toDouble(),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 12),
                  _buildTodayExercisesButton(),
                  const SizedBox(height: 24),
                  ExerciseCarousel(
                    exercises: exercises,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          Assets.dashboardYellow,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.23,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTodayExercisesButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: Palette.secondaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          LocalizationService.translateFromGeneral('todayExercises'),
          style: AppStyles.textCairo(16, Palette.white, FontWeight.w500),
        ),
      ),
    );
  }
}
