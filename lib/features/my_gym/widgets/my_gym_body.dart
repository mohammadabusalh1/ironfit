import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/features/coachEnteInfo/controllers/coach_ente_info_controller.dart';

class MyGymBody extends StatelessWidget {
  const MyGymBody({super.key});

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
                    title: const Text('تعديل المعلومات',
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
    final MyGymController controller = Get.find();
    return Scaffold(
        backgroundColor: Palette.black,
        body: Column(
          children: [
            Stack(
              children: [
                _buildBackgroundImage(),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height * 0.1, 24, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.secondaryColor,
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height * 0.6, 24, 0),
                  child: _buildProfileContent(context, 'صالة رقم 1', 'صوريف'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildButtonCard(context, 'تعديل المعلومات', Icons.person,
                        () {
                      showEditInfoDialog(context);
                    }),
                  ],
                )),
          ],
        ));
  }

  Widget _buildBackgroundImage() {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(0, -1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              Assets.myGymPageImage,
              width: double.infinity,
              height: MediaQuery.of(Get.context!).size.height * 0.7,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Opacity(
          opacity: 0.45,
          child: Container(
            width: double.infinity, // Width of the rectangle
            height: MediaQuery.of(Get.context!).size.height *
                0.7, // Height of the rectangle
            color: Palette.black, // Color of the rectangle
          ),
        ),
      ],
    );
  }

  Widget _buildProfileContent(
      BuildContext context, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.8,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              shadows: [
                Shadow(
                  color: Color(0xFF2F3336),
                  offset: Offset(4.0, 4.0),
                  blurRadius: 2.0,
                )
              ],
            ),
          ),
        ),
        Opacity(
          opacity: 0.6,
          child: Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Palette.mainAppColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              shadows: [
                Shadow(
                  color: Color(0xFF2F3336),
                  offset: Offset(4.0, 4.0),
                  blurRadius: 2.0,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonCard(
      BuildContext context, String tilte, IconData icon, VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Palette.secondaryColor, // Transparent color
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Palette.mainAppColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    tilte,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Palette.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
