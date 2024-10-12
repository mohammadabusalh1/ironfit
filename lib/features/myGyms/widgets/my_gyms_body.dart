import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';

class MyGymsBody extends StatefulWidget {
  const MyGymsBody({super.key});

  @override
  _MyGymsBodyState createState() => _MyGymsBodyState();
}

class _MyGymsBodyState extends State<MyGymsBody> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _currentPage = 0;

  void showEditInfoDialog(BuildContext context) {
    String? selectedValue;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
            data: Theme.of(context).copyWith(
                // Customize the dialog theme here
                dialogBackgroundColor:
                    Colors.grey[900], // Dialog background color
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
                  bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
                  headlineLarge: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFFFBB02), // Customize button color
                    foregroundColor:
                        const Color(0xFF1C1503), // Customize text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                    filled: true, // Fill the text field background
                    fillColor: Palette
                        .secondaryColor, // Background color of the text field
                    labelStyle: TextStyle(
                        color: Colors.white, fontSize: 14), // Label text style
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .transparent), // Border color when enabled
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        )),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.yellow,
                          width: 2), // Border color when focused
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red), // Border color on error
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red,
                          width: 2), // Border color on error when focused
                    ),
                    hintStyle: TextStyle(
                      color: Palette.subTitleGrey,
                      fontSize: 14, // Label text style
                    )),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // Customize text color
                  ),
                )),
            child: Expanded(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    title: const Text('إضافة صالة رياضية',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    content: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('يرجى ملئ البيانات المطلوبة',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'الاسم',
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'الموقع',
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('حفظ'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('إلغاء'),
                      ),
                    ],
                    actionsAlignment: MainAxisAlignment.start,
                  ),
                ),
              ),
            ));
      },
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
                                    onPressed: () {
                                      Get.back();
                                    },
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
                                      'الصالات الرياضية',
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
                                  showEditInfoDialog(context);
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
                              title: 'صالة 1',
                              description: 'صوريف',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                Get.toNamed(Routes.myGym);
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
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Palette.secondaryColor,
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
      ),
    );
  }
}
