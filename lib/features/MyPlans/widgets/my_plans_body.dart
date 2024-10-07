import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/dialogs/main_pop_up.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';

class MyPlansBody extends StatefulWidget {
  const MyPlansBody({super.key});

  @override
  _MyPlansBodyState createState() => _MyPlansBodyState();
}

class _MyPlansBodyState extends State<MyPlansBody> {
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
                                      'البرامج الخاصة بي',
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.createPlan);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFBB02),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
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
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                icon: const Icon(
                                  Icons.north_outlined,
                                  size: 15,
                                  color: Color(0xFF1C1503),
                                ),
                                label: const Text(
                                  'التاريخ',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF1C1503),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 15, 0, 15), // Remove padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ), // Space between buttons
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            CustomCard(
                              title: 'برنامج المبتدئين',
                              description: 'وصف الخطة',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                print('Button for برنامج المبتدئين pressed');
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomCard(
                              title: 'برنامج الشهر الأول',
                              description: 'وصف الخطة',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                print('Button for برنامج الشهر الأول pressed');
                              },
                            ),
                            CustomCard(
                              title: 'برنامج المبتدئين',
                              description: 'وصف الخطة',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                print('Button for برنامج المبتدئين pressed');
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomCard(
                              title: 'برنامج الشهر الأول',
                              description: 'وصف الخطة',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                print('Button for برنامج الشهر الأول pressed');
                              },
                            ),
                            CustomCard(
                              title: 'برنامج المبتدئين',
                              description: 'وصف الخطة',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                print('Button for برنامج المبتدئين pressed');
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomCard(
                              title: 'برنامج الشهر الأول',
                              description: 'وصف الخطة',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                print('Button for برنامج الشهر الأول pressed');
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomCard(
                              title: 'برنامج المتوسط',
                              description: 'وصف الخطة',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                print('Button for برنامج المتوسط pressed');
                              },
                            ),
                            const SizedBox(height: 8),
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
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                )),
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
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                          size: 24,
                        ),
                        onPressed: onPressed,
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
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
