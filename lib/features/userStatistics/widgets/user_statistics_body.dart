import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:ironfit/core/presention/style/palette.dart';

class UserStatisticsBody extends StatefulWidget {
  const UserStatisticsBody({super.key});

  @override
  _UserStatisticsBodyState createState() => _UserStatisticsBodyState();
}

class _UserStatisticsBodyState extends State<UserStatisticsBody> {
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
                          padding: const EdgeInsets.fromLTRB(24, 50, 24, 50),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Opacity(
                                opacity: 0.8,
                                child: Text(
                                  'إحصائيات',
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
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1C1503),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  elevation: 0,
                                ),
                                child: const Icon(
                                  Icons.arrow_right,
                                  color: Color(0xFFFFBB02),
                                  size: 24,
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
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCard(
                          height: 90,
                          backgroundColor: const Color(0xFFFFE49A),
                          icon: Icons.local_fire_department,
                          iconColor: const Color(0xFFFFC700),
                          title: '2500 c',
                          subtitle: 'كاربوهيدرات',
                          onPressed: () {
                            print('IconButton pressed for carbs');
                          },
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        CustomCard(
                          height: 90,
                          backgroundColor: const Color(0xFF9AD8FF),
                          icon: Icons.water_drop_rounded,
                          iconColor: const Color(0xFF00BEFF),
                          title: '2 L',
                          subtitle: 'ماء',
                          onPressed: () {
                            print('IconButton pressed for water');
                          },
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        CustomCard(
                          height: 90,
                          backgroundColor: const Color(0xFF9AFFC5),
                          icon: Icons.power,
                          iconColor: const Color(0xFF00FF6C),
                          title: '120 gm',
                          subtitle: 'بروتين',
                          onPressed: () {
                            print('IconButton pressed for protein');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const CustomCard({
    Key? key,
    required this.height,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Stack(
              alignment: const AlignmentDirectional(0, 0),
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, -1.9),
                  child: IconButton(
                    icon: Icon(
                      icon,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: onPressed,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(iconColor),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Palette.subTitleBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}