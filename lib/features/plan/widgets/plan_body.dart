import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/style/assets.dart';

class PlanBody extends StatefulWidget {
  const PlanBody({super.key});

  @override
  _PlanBodyState createState() => _PlanBodyState();
}

class _PlanBodyState extends State<PlanBody> {
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
                                  'برنامج المبتدئين',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFBB02),
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Center(
                        // Centering the icon
                        child: Icon(
                          Icons.add,
                          size: 22,
                          color: Color(0xFF1C1503),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            CustomCard(
                              title: 'صدر وباي',
                              description: 'يوم الأحد',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                print('Button for برنامج المبتدئين pressed');
                              },
                            ),
                            SizedBox(height: 8),
                            CustomCard(
                              title: 'برنامج الشهر الأول',
                              description: 'وصف الخطة',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                print('Button for برنامج الشهر الأول pressed');
                              },
                            ),
                            SizedBox(height: 8),
                            CustomCard(
                              title: 'برنامج المتوسط',
                              description: 'وصف الخطة',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                print('Button for برنامج المتوسط pressed');
                              },
                            ),
                            SizedBox(height: 8),
                            CustomCard(
                              title: 'برنامج المتقدم',
                              description: 'وصف الخطة',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                print('Button for برنامج المتقدم pressed');
                              },
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Card Component
class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color(0x38454038),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                        size: 24,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                          size: 24,
                        ),
                        onPressed: onPressed,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFFFFBB02),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              description,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0x93FFFFFF),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
