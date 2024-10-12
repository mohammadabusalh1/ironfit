import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

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
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  Assets.header,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.28,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.14 -
                    24, // Adjust this to control vertical alignment
                left: 0,
                right: 24,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Center horizontally
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1C1503),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCard(
                        backgroundColor: const Color(0xFFFFE49A),
                        icon: Icons.local_fire_department,
                        iconColor: const Color(0xFFFFC700),
                        title: '2500 c',
                        subtitle: 'كاربوهيدرات',
                        onPressed: () {
                          print('IconButton pressed for carbs');
                        },
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      CustomCard(
                        backgroundColor: const Color(0xFF9AD8FF),
                        icon: Icons.water_drop_rounded,
                        iconColor: const Color(0xFF00BEFF),
                        title: '2 L',
                        subtitle: 'ماء',
                        onPressed: () {
                          print('IconButton pressed for water');
                        },
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      CustomCard(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      LongCard(
                        percentage: '80%',
                        label: 'نسبة العضلات',
                        icon: Icons.accessibility,
                        onPressed: () {
                          print('IconButton pressed for muscles percentage');
                        },
                        iconColor: Palette.darkCyan,
                      ),
                      const SizedBox(height: 8), // Spacing between cards
                      LongCard(
                        percentage: '10%',
                        label: 'نسبة الدهون',
                        icon: Icons.local_fire_department,
                        onPressed: () {
                          print('IconButton pressed for fat percentage');
                        },
                        iconColor: Palette.accentRed,
                      ),
                      const SizedBox(height: 8), // Spacing between cards
                      LongCard(
                        percentage: '60 kg',
                        label: 'الوزن المثالي',
                        icon: Icons.scale,
                        onPressed: () {
                          print('IconButton pressed for ideal weight');
                        },
                        iconColor: Palette.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const CustomCard({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
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

// Reusable Card Component
class LongCard extends StatelessWidget {
  final String percentage;
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;

  const LongCard({
    super.key,
    required this.percentage,
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    const textColor = Palette.borderGrey;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Palette.darkBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              percentage,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: textColor,
                letterSpacing: 0.0,
              ),
            ),
            Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Inter Tight',
                    color: textColor,
                    fontSize: 16,
                    letterSpacing: 0.0,
                  ),
                ),
                const SizedBox(width: 12), // Spacing between text and icon
                IconButton(
                  icon: Icon(
                    icon,
                    color: iconColor,
                  ),
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(textColor),
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  ),
                  onPressed: onPressed,
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
