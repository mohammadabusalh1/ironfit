import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:fl_chart/fl_chart.dart';
import 'package:ironfit/features/CoachStatistics/controllers/coach_statistics_controller.dart';
import 'package:ironfit/features/CoachStatistics/models/coach_statistics_model.dart';

class CoachStatisticsBody extends StatefulWidget {
  const CoachStatisticsBody({super.key});

  @override
  _CoachStatisticsBodyState createState() => _CoachStatisticsBodyState();
}

class _CoachStatisticsBodyState extends State<CoachStatisticsBody> {
  final CoachStatisticsController _controller = CoachStatisticsController();
  late Future<CoachStatisticsModel> statistics;
  late Future<Map<String, int>> ageDistributionData;
  String coachId = FirebaseAuth.instance.currentUser!.uid;

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();

  late String dir;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    statistics = _controller.fetchStatistics();
    ageDistributionData = _controller.fetchAgeDistributionData();
    dir = LocalizationService.getDir();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: FutureBuilder<CoachStatisticsModel>(
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

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              HeaderImage(
                                high: MediaQuery.of(context).size.height * 0.25,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ReturnBackButton(dir),
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
                              )
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
                                    '${data.trainees} ${LocalizationService.translateFromGeneral('trainee')}',
                                cardTitle:
                                    LocalizationService.translateFromGeneral(
                                        'trainees'),
                                width:
                                    MediaQuery.of(context).size.width * 0.415,
                                height: 90,
                                icon: Icons.people,
                                backgroundColor: Palette.mainAppColorOrange,
                                textColor: Palette.mainAppColorWhite,
                                cardTextColor: Palette.mainAppColorWhite,
                                iconColor: Palette.mainAppColorWhite,
                              ),
                              const Spacer(),
                              StatisticsCard(
                                cardSubTitle:
                                    '${data.newTrainees} ${LocalizationService.translateFromGeneral('trainee')}',
                                cardTitle:
                                    LocalizationService.translateFromGeneral(
                                        'newTrainees'),
                                width:
                                    MediaQuery.of(context).size.width * 0.415,
                                height: 90,
                                icon: Icons.network_ping,
                                backgroundColor: Palette.mainAppColorWhite,
                                textColor: Palette.mainAppColorNavy,
                                cardTextColor: Palette.mainAppColorNavy,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: StatisticsCard(
                            cardSubTitle: '${data.income} \$',
                            cardTitle: LocalizationService.translateFromGeneral(
                                'incomeThisMonth'),
                            width: MediaQuery.of(context).size.width * 0.86,
                            height: 90,
                            icon: Icons.monetization_on,
                            backgroundColor: Palette.mainAppColoryellow2,
                            textColor: Palette.mainAppColorWhite,
                            cardTextColor: Palette.mainAppColorWhite,
                          ),
                        ),
                        const SizedBox(height: 12),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Text(
                                LocalizationService.translateFromGeneral(
                                    'ageDistribution'),
                                style: AppStyles.textCairo(
                                  14,
                                  Palette.mainAppColorNavy,
                                  FontWeight.bold,
                                ),
                              ),
                            ),
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
                                  return PieChartSample2(
                                    data: data,
                                  );
                                }

                                return Center(
                                    child: Text(LocalizationService
                                        .translateFromGeneral(
                                            'noDataForAgeDistribution')));
                              },
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

class PieChartSample2 extends StatefulWidget {
  final Map<String, int> data;
  const PieChartSample2({
    super.key,
    required this.data,
  });

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(
    BuildContext context,
  ) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Row(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 32,
                  sections: showingSections(widget.data),
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Palette.mainAppColorOrange,
                text: '18-25',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.yellow,
                text: '26-35',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.purple,
                text: '36-45',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.green,
                text: '46+',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(ageData) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Palette.mainAppColorOrange,
            value: double.parse(ageData['18-25'].toString()),
            title: ageData['18-25'].toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Palette.mainAppColorWhite,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: double.parse(ageData['26-35'].toString()),
            title: ageData['26-35'].toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Palette.mainAppColorWhite,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: double.parse(ageData['36-45'].toString()),
            title: ageData['36-45'].toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Palette.mainAppColorWhite,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: double.parse(ageData['46+'].toString()),
            title: ageData['46+'].toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Palette.mainAppColorWhite,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: AppStyles.textCairo(
            14,
            Palette.mainAppColorWhite,
            FontWeight.bold,
          ),
        )
      ],
    );
  }
}
