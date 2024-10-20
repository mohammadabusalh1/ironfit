import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/widgets/PagesHeader.dart';
import 'package:ironfit/core/presentation/widgets/exersiceCarousel.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

class TrainerDashboardBody extends StatefulWidget {
  TrainerDashboardBody({super.key});

  @override
  _TrainerDashboardBodyState createState() => _TrainerDashboardBodyState();
}

class _TrainerDashboardBodyState extends State<TrainerDashboardBody> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String trainerName = '';
  String trainerEmail = '';
  String trainerImage =
      'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg';
  List<Map<String, String>> exercises = [];

  @override
  void initState() {
    super.initState();
    _fetchTrainerData();
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
      DocumentSnapshot userDoc =
          await _firestore.collection('trainees').doc(user.uid).get();

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

      // Get the current day of the week
      DateTime now = DateTime.now();
      List<String> weekdays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];

      // Safely fetch today's exercises
      var dynamicExercises =
          userDoc['plan']['trainingDays'][weekdays[now.weekday - 1]] ?? [];

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
          print(exercises);
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
          _buildDashboardHeader(),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildDashboardImage(context),
                  const SizedBox(height: 24),
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

  Widget _buildDashboardHeader() {
    return DashboardHeader(
      backgroundImage: Assets.dashboardBackground,
      trainerImage: trainerImage,
      trainerName: 'a',
      trainerEmail: 'b',
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
        child: const Text(
          'تمارين اليوم',
          style: TextStyle(
              fontSize: 16, color: Palette.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
