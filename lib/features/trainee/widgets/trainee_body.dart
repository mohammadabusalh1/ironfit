import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/dialogs/main_pop_up.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TraineeBody extends StatefulWidget {
  const TraineeBody({super.key});

  @override
  _TraineeBodyState createState() => _TraineeBodyState();
}

class _TraineeBodyState extends State<TraineeBody> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _currentPage = 0;
  void showCreatePlanDialog(BuildContext context) {
    Get.dialog(
      MainPopUp(
        title: 'Create Plan',
        content: 'Please fill in the details to create a new plan:',
        textFieldHints: const ['Plan Name', 'Duration (in days)', 'Description'],
        confirmText: 'Create Plan',
        cancelText: 'Cancel',
        onConfirm: () {
          Get.back();
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }

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
                  Align(
                    alignment: const AlignmentDirectional(0, 1),
                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        alignment: const AlignmentDirectional(0, 1),
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0, -1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                Assets.header,
                                width: double.infinity,
                                height: 231,
                                fit: BoxFit.fitWidth,
                                alignment: const Alignment(0, 0),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        Assets.myTrainerImage,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Opacity(
                                    opacity: 0.8,
                                    child: Text(
                                      'محمد أبو صالح',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.white,
                                        fontSize: 18,
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
                                  const Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      ' تبقى له 21 يوم من الإشتراك',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xA0FFFFFF),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: LinearPercentIndicator(
                                percent: 0.5,
                                lineHeight: 24,
                                animation: true,
                                animateFromLastPercent: true,
                                progressColor: const Color(0xFFFFBB02),
                                backgroundColor: const Color(
                                    0xFFBBDEFB), // Example color for background
                                center: const Text(
                                  '50%',
                                  style: TextStyle(
                                    fontFamily: 'Inter Tight',
                                    color: Color(0xFF1C1503),
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                                barRadius: const Radius.circular(12),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              print('Cancel subscription button pressed ...');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFFE303C), // Button color
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              fixedSize: const Size(double.infinity, 40),
                            ),
                            child: const Text(
                              'إلغاء إشتراكه',
                              style: TextStyle(
                                fontFamily: 'Inter Tight',
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12), // Spacing between buttons
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              showCreatePlanDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFFFBB02), // Button color
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              fixedSize: const Size(double.infinity, 40),
                            ),
                            child: const Text(
                              'أضف برنامج',
                              style: TextStyle(
                                fontFamily: 'Inter Tight',
                                color: Color(0xFF1C1503),
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.4, // Adjust height as needed
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildCard(context, 'الأحد'),
                          const SizedBox(height: 8),
                          _buildCard(context, 'الإثنين'),
                          const SizedBox(height: 8),
                          _buildCard(context, 'الثلاثاء'),
                          const SizedBox(height: 8),
                          _buildCard(context, 'الأربعاء'),
                          const SizedBox(height: 8),
                          _buildCard(context, 'الخميس'),
                          const SizedBox(height: 8),
                          _buildCard(context, 'الجمعة'),
                          const SizedBox(height: 8),
                          _buildCard(context, 'السبت'),
                        ],
                      ),
                    ),
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

Widget _buildCard(BuildContext context, String day) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: const Color(0x38454038),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFFFFBB02),
                      fontSize: 14,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'ظهر + باي',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0x93FFFFFF),
                      fontSize: 10,
                      letterSpacing: 0.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.date_range,
                color: Colors.white,
                size: 40,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
