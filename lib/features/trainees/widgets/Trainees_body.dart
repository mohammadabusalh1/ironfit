import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/dialogs/main_pop_up.dart';
import 'package:ironfit/core/presention/style/assets.dart';

class TraineesBody extends StatefulWidget {
  const TraineesBody({super.key});

  @override
  _TraineesBodyState createState() => _TraineesBodyState();
}

class _TraineesBodyState extends State<TraineesBody> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _currentPage = 0;

  void showAddTraineeDialog(BuildContext context) {
    Get.dialog(
      MainPopUp(
        title: 'Add New Trainee',
        content: 'Please fill in the details to add a new trainee:',
        textFieldHints: ['Trainee Name', 'Age', 'Email', 'Phone Number'],
        confirmText: 'Add Trainee',
        cancelText: 'Cancel',
        onConfirm: () {
          Get.back(); // You can replace this with the actual logic to add the trainee
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
                                  'المتدربين',
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            label: const Text('الإسم'),
                            icon: const Icon(
                              Icons.north_rounded,
                              size: 15,
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF1C1503),
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                              ),
                              minimumSize: const Size(double.infinity, 50),
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
                            label: const Text('الإشتراك'),
                            icon: const Icon(
                              Icons.north_outlined,
                              size: 15,
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF1C1503),
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showAddTraineeDialog(context);
                            },
                            label: const Text(''),
                            icon: const Icon(
                              Icons.add,
                              size: 22,
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF1C1503),
                              backgroundColor: const Color(0xFFFFBB02),
                              padding:
                                  const EdgeInsetsDirectional.only(start: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.0,
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Container(
                      child: TextFormField(
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle: const TextStyle(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                          hintText: 'البحث',
                          hintStyle: const TextStyle(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFFFBB02),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              // Assuming the error color from the theme
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              // Assuming the error color from the theme
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          filled: true,
                          fillColor: Colors.white, // Assuming background color
                        ),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                        textAlign: TextAlign.end,
                        cursorColor: Theme.of(context)
                            .primaryColor, // Assuming the primary text color
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        buildCard(context, 'محمد أبو صالح', 'مشترك الأن',
                            Assets.myGymImage),
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

Widget buildCard(
    BuildContext context, String name, String status, String imagePath) {
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
                const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
                Row(
                  children: [
                    const Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'محمد أبو صالح',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFFFFBB02),
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' مشترك الأن',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0x93FFFFFF),
                              fontSize: 10,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        Assets.myGymImage,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ), // Replaces the divide function
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
