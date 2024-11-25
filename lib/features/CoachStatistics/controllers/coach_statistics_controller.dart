import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/coach_statistics_model.dart';

class CoachStatisticsController {
  final String coachId = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<CoachStatisticsModel> fetchStatistics() async {
    try {
      final subscriptionsSnapshot = await _firestore
          .collection('subscriptions')
          .where('coachId', isEqualTo: coachId)
          .where('isActive', isEqualTo: true)
          .get();

      if (subscriptionsSnapshot.docs.isEmpty) {
        return CoachStatisticsModel();
      }

      List<Map<String, dynamic>> subscriptionsList =
          subscriptionsSnapshot.docs.map((doc) => doc.data()).toList();

      List<Map<String, dynamic>> newTrainees =
          subscriptionsList.where((subscription) {
        try {
          return DateTime.parse(subscription['startDate'])
              .isAfter(DateTime.now().subtract(const Duration(days: 30)));
        } catch (e) {
          return false;
        }
      }).toList();

      int income = subscriptionsList
          .where((subscription) =>
              DateTime.parse(subscription['startDate']).month >=
              DateTime.now().month)
          .map((subscription) =>
              int.parse(subscription['amountPaid'].toString()))
          .reduce((a, b) => a + b);

      final ageDistribution = await fetchAgeDistributionData();

      return CoachStatisticsModel(
        trainees: subscriptionsList.length,
        newTrainees: newTrainees.length,
        income: income.toDouble(),
        ageDistribution: ageDistribution,
      );
    } catch (e) {
      return CoachStatisticsModel();
    }
  }

  Future<Map<String, int>> fetchAgeDistributionData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      // Get the current user's UID
      String? userId = auth.currentUser?.uid;
      if (userId == null) {
        print("User is not logged in.");
        return _defaultAgeDistribution();
      }

      // Get the subscriptions collection for the coach
      QuerySnapshot<Map<String, dynamic>> subscriptions =
          await FirebaseFirestore.instance
              .collection('subscriptions')
              .where('coachId', isEqualTo: userId)
              .where('isActive', isEqualTo: true)
              .get();

      // If no data, log and return default values
      if (subscriptions.docs.isEmpty) {
        print("No subscriptions found for coach with ID: $userId");
        return _defaultAgeDistribution();
      }

      // Get userIds directly from the snapshot docs
      final userIds = subscriptions.docs.map((doc) => doc['userId']).toList();

      // Batch fetch trainee documents
      final traineeDocs = await FirebaseFirestore.instance
          .collection('trainees')
          .where(FieldPath.documentId, whereIn: userIds)
          .get();

      // Initialize age distribution counters
      Map<String, int> ageDistribution = {
        '18-25': 0,
        '26-35': 0,
        '36-45': 0,
        '46+': 0,
      };

      // Calculate age distribution
      for (var trainee in traineeDocs.docs) {
        if (!trainee.data().containsKey('age')) {
          continue;
        }

        final ageString = trainee['age']?.toString();

        if (ageString == null || ageString.isEmpty) {
          print("Age field is missing in subscription: ${trainee.id}");
          continue; // Skip invalid subscriptions
        }

        final age = int.tryParse(ageString);
        if (age == null) {
          print(
              "Invalid age value: $ageString for subscription: ${trainee.id}");
          continue; // Skip invalid age values
        }

        // Count based on age ranges
        if (age >= 18 && age <= 25) {
          ageDistribution['18-25'] = ageDistribution['18-25']! + 1;
        } else if (age >= 26 && age <= 35) {
          ageDistribution['26-35'] = ageDistribution['26-35']! + 1;
        } else if (age >= 36 && age <= 45) {
          ageDistribution['36-45'] = ageDistribution['36-45']! + 1;
        } else if (age >= 46) {
          ageDistribution['46+'] = ageDistribution['46+']! + 1;
        }
      }

      print(
          "Age distribution: ${ageDistribution['18-25']}, ${ageDistribution['26-35']}, ${ageDistribution['36-45']}, ${ageDistribution['46+']}");

      return ageDistribution;
    } catch (e, stackTrace) {
      // Log detailed error and stack trace for debugging
      print("Error fetching age distribution: $e");
      print("Stack trace: $stackTrace");

      // Return default values when an error occurs
      return _defaultAgeDistribution();
    }
  }

  Map<String, int> _defaultAgeDistribution() {
    return {
      '18-25': 0,
      '26-35': 0,
      '36-45': 0,
      '46+': 0,
    };
  }
}
