import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/StatisticsCard.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

class CoachStatisticsBody extends StatefulWidget {
  const CoachStatisticsBody({super.key});

  @override
  _CoachStatisticsBodyState createState() => _CoachStatisticsBodyState();
}

class _CoachStatisticsBodyState extends State<CoachStatisticsBody> {
  late Future<Map<String, dynamic>> statistics;
  late Future<Map<String, int>> ageDistributionData;
  String coachId = FirebaseAuth.instance.currentUser!.uid;

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    statistics = fetchStatistics();
    ageDistributionData =
        fetchAgeDistributionData(); // Initialize statistics fetch
  }

  // Method to fetch statistics data from Firestore
  Future<Map<String, dynamic>> fetchStatistics() async {
    try {
      // Fetch data from Firestore
      QuerySnapshot<Map<String, dynamic>> subscriptionsSnapshot =
          await FirebaseFirestore.instance
              .collection('subscriptions')
              .where('coachId', isEqualTo: coachId)
              .where('isActive', isEqualTo: true)
              .get();

      // Handle empty snapshots
      if (subscriptionsSnapshot.docs.isEmpty) {
        print("No subscriptions found for coach ID: $coachId");
        return {
          'trainees': 0,
          'new_trainees': 0,
          'income': 0.0,
        };
      }

      List<Map<String, dynamic>> subscriptionsList =
          subscriptionsSnapshot.docs.map((doc) => doc.data()).toList();

      List<Map<String, dynamic>> newTrainees =
          subscriptionsList.where((subscription) {
        try {
          return DateTime.parse(subscription['startDate'])
              .isAfter(DateTime.now().subtract(const Duration(days: 30)));
        } catch (e) {
          print(
              "Error parsing date for subscription: ${subscription['startDate']} - $e");
          return false; // Fallback if date parsing fails
        }
      }).toList();

      int income = subscriptionsList
          .where((subscription) =>
              DateTime.parse(subscription['startDate']).month >=
              DateTime.now().month)
          .map((subscription) =>
              int.parse(subscription['amountPaid'].toString()) ?? 0)
          .reduce((a, b) => int.parse(a.toString()) + int.parse(b.toString()));
      return {
        'trainees': subscriptionsList.length,
        'new_trainees': newTrainees.length,
        'income': income.toDouble(), // Ensure income is returned as a double
      };
    } catch (e, stackTrace) {
      // Log the error and stack trace for better debugging
      print("Error fetching statistics: $e");
      print("Stack trace: $stackTrace");

      // Return default values in case of an error
      return {
        'trainees': 0,
        'new_trainees': 0,
        'income': 0.0,
      };
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
      customSnackbar.showFailureMessage(context);

      // Return default values when an error occurs
      return _defaultAgeDistribution();
    }
  }

// Helper method to return default age distribution
  Map<String, int> _defaultAgeDistribution() {
    return {
      '18-25': 0,
      '26-35': 0,
      '36-45': 0,
      '46+': 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: FutureBuilder<Map<String, dynamic>>(
        future: statistics,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            var data = snapshot.data!; // Access the fetched data

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              const HeaderImage(),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 50, 24, 50),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ReturnBackButton(),
                                    const SizedBox(width: 12),
                                    Opacity(
                                      opacity: 0.8,
                                      child: Text(
                                        LocalizationService
                                            .translateFromGeneral('statistics'),
                                        style: AppStyles.textCairo(
                                            20,
                                            Palette.mainAppColorWhite,
                                            FontWeight.w800),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              StatisticsCard(
                                cardSubTitle:
                                    '${data['trainees']} ${LocalizationService.translateFromGeneral('trainee')}',
                                cardTitle:
                                    LocalizationService.translateFromGeneral(
                                        'trainees'),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 90,
                                icon: Icons.people,
                              ),
                              const Spacer(),
                              StatisticsCard(
                                cardSubTitle:
                                    '${data['trainees']} ${LocalizationService.translateFromGeneral('Trainee')}',
                                cardTitle:
                                    LocalizationService.translateFromGeneral(
                                        'newTrainees'),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 90,
                                icon: Icons.network_ping,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: StatisticsCard(
                            cardSubTitle: '${data['income']} \$',
                            cardTitle: LocalizationService.translateFromGeneral(
                                'incomeThisMonth'),
                            width: MediaQuery.of(context).size.width * 0.86,
                            height: 90,
                            icon: Icons.monetization_on,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              decoration: const BoxDecoration(
                                color: Palette.mainAppColorWhite,
                              ),
                              child: Text(
                                LocalizationService.translateFromGeneral(
                                    'ageDistribution'),
                                style: AppStyles.textCairo(
                                  14,
                                  Palette.black.withOpacity(0.7),
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            FutureBuilder<Map<String, int>>(
                              future: ageDistributionData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }

                                if (snapshot.hasData) {
                                  Map<String, int> data = snapshot.data!;
                                  return AgeDonutChart(ageData: data);
                                }

                                return Center(
                                    child: Text(LocalizationService
                                        .translateFromGeneral(
                                            'noDataForAgeDistribution')));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child:
                    Text(LocalizationService.translateFromGeneral('noData')));
          }
        },
      ),
    );
  }
}

// Pie Chart for Age Distribution
class AgeDonutChart extends StatelessWidget {
  final Map<String, int> ageData;

  const AgeDonutChart({super.key, required this.ageData});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.7,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 30,
          sections: [
            PieChartSectionData(
              color: Palette.blue,
              // value: ageData['18-25'] ?? 1,
              value: double.parse(ageData['18-25'].toString()),
              title: '18-25',
              radius: 50,
              titleStyle: AppStyles.textCairo(
                12,
                Palette.mainAppColorWhite,
                FontWeight.bold,
              ),
            ),
            PieChartSectionData(
              color: Colors.green,
              // value: ageData['26-35'] ?? 1,
              value: double.parse(ageData['26-35'].toString()),
              title: '26-35',
              radius: 50,
              titleStyle: AppStyles.textCairo(
                12,
                Palette.mainAppColorWhite,
                FontWeight.bold,
              ),
            ),
            PieChartSectionData(
              color: Palette.mainAppColorOrange,
              // value: ageData['36-45'] ?? 1,
              value: double.parse(ageData['36-45'].toString()),
              title: '36-45',
              radius: 50,
              titleStyle: AppStyles.textCairo(
                12,
                Palette.mainAppColorWhite,
                FontWeight.bold,
              ),
            ),
            PieChartSectionData(
              color: Palette.accentRed,
              value: double.parse(ageData['46+'].toString()),
              title: '46+',
              radius: 50,
              titleStyle: AppStyles.textCairo(
                12,
                Palette.mainAppColorWhite,
                FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
