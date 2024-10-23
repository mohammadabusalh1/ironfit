import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/StatisticsCard.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';

class CoachStatisticsBody extends StatefulWidget {
  const CoachStatisticsBody({super.key});

  @override
  _CoachStatisticsBodyState createState() => _CoachStatisticsBodyState();
}

class _CoachStatisticsBodyState extends State<CoachStatisticsBody> {
  late Future<Map<String, dynamic>> statistics;
  late Future<Map<String, int>> ageDistributionData;
  String coachId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    statistics = fetchStatistics();
    ageDistributionData =
        fetchAgeDistributionData(); // Initialize statistics fetch
  }

  // Method to fetch statistics data from Firestore
  Future<Map<String, dynamic>> fetchStatistics() async {
    if (coachId == null) {
      print("No coach ID found.");
      return {
        'trainees': 0,
        'new_trainees': 0,
        'income': 0.0,
      };
    }

    try {
      // Fetch data from Firestore
      QuerySnapshot<Map<String, dynamic>> subscriptionsSnapshot =
          await FirebaseFirestore.instance
              .collection('coaches')
              .doc(coachId)
              .collection('subscriptions')
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
              .isAfter(DateTime.now().subtract(Duration(days: 30)));
        } catch (e) {
          print(
              "Error parsing date for subscription: ${subscription['startDate']} - $e");
          return false; // Fallback if date parsing fails
        }
      }).toList();

      // Safely handle potential parsing errors
      int income = 0;
      try {
        income = subscriptionsList
            .map((subscription) => int.parse(subscription['amountPaid'] ?? '0'))
            .reduce((a, b) => a + b);
      } catch (e) {
        print("Error calculating income: $e");
        income = 0; // Default to 0 if parsing fails
      }

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
        return {
          '18-25': 0,
          '26-35': 0,
          '36-45': 0,
          '46+': 0,
        };
      }

      // Get the subscriptions collection for the coach
      CollectionReference<Map<String, dynamic>> subscriptions =
          FirebaseFirestore.instance
              .collection('coaches')
              .doc(userId)
              .collection('subscriptions');

      // Fetch data from Firestore
      QuerySnapshot<Map<String, dynamic>> snapshot = await subscriptions.get();

      // If no data, log and return default values
      if (snapshot.docs.isEmpty) {
        print("No subscriptions found for coach with ID: $userId");
        return {
          '18-25': 0,
          '26-35': 0,
          '36-45': 0,
          '46+': 0,
        };
      }

      List<Map<String, dynamic>> subscriptionsList =
          snapshot.docs.map((doc) => doc.data()).toList();

      // Calculate age distribution
      int age18to25 = 0;
      int age26to35 = 0;
      int age36to45 = 0;
      int age46Plus = 0;

      for (var subscription in subscriptionsList) {
        String? ageString = subscription['age'].toString();
        if (ageString.isEmpty) {
          print("Age field is missing in subscription: $subscription");
          continue; // Skip invalid subscriptions
        }

        int? age = int.tryParse(ageString);
        if (age == null) {
          print(
              "Invalid age value: $ageString for subscription: $subscription");
          continue; // Skip invalid age values
        }

        // Count based on age ranges
        if (age >= 18 && age <= 25) {
          age18to25++;
        } else if (age >= 26 && age <= 35) {
          age26to35++;
        } else if (age >= 36 && age <= 45) {
          age36to45++;
        } else if (age >= 46) {
          age46Plus++;
        }
      }

      print("Age distribution: $age18to25, $age26to35, $age36to45, $age46Plus");

      return {
        '18-25': age18to25,
        '26-35': age26to35,
        '36-45': age36to45,
        '46+': age46Plus,
      };
    } catch (e, stackTrace) {
      // Log detailed error and stack trace for debugging
      print("Error fetching age distribution: $e");
      print("Stack trace: $stackTrace");

      // Return default values when an error occurs
      return {
        '18-25': 0,
        '26-35': 0,
        '36-45': 0,
        '46+': 0,
      };
    }
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
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Stack(
                              children: [
                                HeaderImage(),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 50, 24, 50),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF1C1503),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          elevation: 0,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_left,
                                          color: Color(0xFFFFBB02),
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Opacity(
                                        opacity: 0.8,
                                        child: Text(
                                          'الإحصائيات',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            shadows: [
                                              Shadow(
                                                color: Color(0xFF2F3336),
                                                offset: Offset(4.0, 4.0),
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
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
                                  cardSubTitle: '${data['trainees']}',
                                  cardTitle: 'المتدربين',
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 90,
                                ),
                                const Spacer(),
                                StatisticsCard(
                                  cardSubTitle: '${data['new_trainees']}',
                                  cardTitle: 'المتدربين الجدد',
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 90,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: StatisticsCard(
                              cardSubTitle: '${data['income']} شيكل',
                              cardTitle: 'الدخل هذا الشهر',
                              width: MediaQuery.of(context).size.width * 0.86,
                              height: 90,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'توزيع الأعمار',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.mainAppColor,
                                ),
                              ),
                              const SizedBox(height: 24),
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
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  }

                                  if (snapshot.hasData) {
                                    Map<String, int> data = snapshot.data!;
                                    return AgeDonutChart(ageData: data);
                                  }

                                  return const Center(
                                      child: Text(
                                          'لا توجد بيانات لتوزيع الأعمار'));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('لا توجد بيانات'));
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
              color: Colors.blue,
              // value: ageData['18-25'] ?? 1,
              value: double.parse(ageData['18-25'].toString()),
              title: '18-25',
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              color: Colors.green,
              // value: ageData['26-35'] ?? 1,
              value: double.parse(ageData['26-35'].toString()),
              title: '26-35',
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              color: Colors.orange,
              // value: ageData['36-45'] ?? 1,
              value: double.parse(ageData['36-45'].toString()),
              title: '36-45',
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              color: Colors.red,
              value: double.parse(ageData['46+'].toString()),
              title: '46+',
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
