import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/StatisticsCard.dart';

class CoachStatisticsBody extends StatefulWidget {
  const CoachStatisticsBody({super.key});

  @override
  _CoachStatisticsBodyState createState() => _CoachStatisticsBodyState();
}

class _CoachStatisticsBodyState extends State<CoachStatisticsBody> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
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
                                      backgroundColor: const Color(0xFF1C1503),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
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
                                  cardSubTitle: '300 متدرب',
                                  cardTitle: 'المتدربين',
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 90),
                              const Spacer(),
                              StatisticsCard(
                                  cardSubTitle: '20 متدرب',
                                  cardTitle: 'المتدربين الجدد',
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 90),
                            ],
                          )),
                      const SizedBox(height: 24),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              StatisticsCard(
                                  cardSubTitle: '3200 شيكل',
                                  cardTitle: ' الدخل هذا الشهر',
                                  width:
                                      MediaQuery.of(context).size.width * 0.86,
                                  height: 90),
                            ],
                          )),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'توزيع الأعمار',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.mainAppColor),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.21,
                              child: AgeDonutChart(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class AgeDonutChart extends StatelessWidget {
  const AgeDonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 30,
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              value: 30,
              title: '18-25',
              radius: 50,
              titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 40,
              title: '26-35',
              radius: 50,
              titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            PieChartSectionData(
              color: Colors.orange,
              value: 20,
              title: '36-45',
              radius: 50,
              titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            PieChartSectionData(
              color: Colors.red,
              value: 10,
              title: '46+',
              radius: 50,
              titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
