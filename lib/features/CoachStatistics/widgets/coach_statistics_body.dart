import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/StatisticsCard.dart';
import 'package:ironfit/core/presentation/widgets/getCoachId.dart';

class CoachStatisticsBody extends StatefulWidget {
  const CoachStatisticsBody({super.key});

  @override
  _CoachStatisticsBodyState createState() => _CoachStatisticsBodyState();
}

class _CoachStatisticsBodyState extends State<CoachStatisticsBody> {
  late Future<Map<String, dynamic>> statistics;
  late Future<Map<String, double>> ageDistributionData;

  @override
  void initState() {
    super.initState();
    statistics = fetchStatistics();
    ageDistributionData =
        fetchAgeDistributionData(); // Initialize statistics fetch
  }

  // Method to fetch statistics data from Firestore
  Future<Map<String, dynamic>> fetchStatistics() async {
    String? coachId = await fetchCoachId();
    try {
      // Fetch data from Firestore
      DocumentSnapshot coachStats = await FirebaseFirestore.instance
          .collection('coaches')
          .doc(coachId) // Get current user ID
          .get();

      if (coachStats.exists) {
        var data = coachStats.data() as Map<String, dynamic>;
        return {
          'trainees': data['trainees'] ?? 0,
          'new_trainees': data['new_trainees'] ?? 0,
          'income': data['income'] ?? 0.0,
        };
      } else {
        throw Exception('No data found for this coach');
      }
    } catch (e) {
      print("Error fetching statistics: $e");
      return {
        'trainees': 0,
        'new_trainees': 0,
        'income': 0.0,
      };
    }
  }

  Future<Map<String, double>> fetchAgeDistributionData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('coaches')
          .doc(await fetchCoachId())
          .get();

      if (doc.exists) {
        // Example data from Firestore document, make sure these fields exist in your Firestore document.
        double age18to25 = doc['trainees']?.toDouble() ?? 1;
        double age26to35 = doc['26-35']?.toDouble() ?? 1;
        double age36to45 = doc['36-45']?.toDouble() ?? 1;
        double age46Plus = doc['46+']?.toDouble() ?? 1;

        return {
          '18-25': age18to25,
          '26-35': age26to35,
          '36-45': age36to45,
          '46+': age46Plus,
        };
      } else {
        throw Exception('Document not found');
      }
    } catch (e) {
      print('Error fetching age distribution: $e');
      return {
        '18-25': 0.0,
        '26-35': 0.0,
        '36-45': 0.0,
        '46+': 0.0,
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    Assets.header,
                                    width: double.infinity,
                                    height: 132,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
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
                                  cardSubTitle: '${data['trainees']} متدرب',
                                  cardTitle: 'المتدربين',
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 90,
                                ),
                                const Spacer(),
                                StatisticsCard(
                                  cardSubTitle:
                                      '${data['new_trainees']} متدرب جديد',
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
                            child: Row(
                              children: [
                                StatisticsCard(
                                  cardSubTitle: '${data['income']} شيكل',
                                  cardTitle: 'الدخل هذا الشهر',
                                  width:
                                      MediaQuery.of(context).size.width * 0.86,
                                  height: 90,
                                ),
                              ],
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
                              FutureBuilder<Map<String, double>>(
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
                                    Map<String, double> data = snapshot.data!;
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
  final Map<String, double> ageData;

  const AgeDonutChart({super.key, required this.ageData});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.3,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              // value: ageData['18-25'] ?? 1,
              value: 20,
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
              value: 36,
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
              value: 15,
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
              value: ageData['46+'] ?? 1,
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
