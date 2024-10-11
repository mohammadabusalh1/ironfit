import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/coachProfile/controllers/coach_profile_controller.dart';

class CoachProfileBody extends StatelessWidget {
  const CoachProfileBody({super.key});

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
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
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
                            hintText: 'الاسم الأول',
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'الاسم الأخير',
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'العمر',
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                            decoration: InputDecoration(
                          hintText: 'الخبرة',
                        ))
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

  void showEditPasswordDialog(BuildContext context) {
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
                    title: const Text('تغيير كلمة المرور',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
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
                            hintText: 'كلمة المرور القديمة',
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'كلمة المرور الجديدة',
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'تأكيد كلمة المرور الجديدة',
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
    final CoachProfileController controller = Get.find();
    return Scaffold(
        backgroundColor: Palette.black,
        body: Column(
          children: [
            Stack(
              children: [
                _buildBackgroundImage(),
                _buildProfileContent(context),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildButtonCard(context, 'المعلومات الشخصية', Icons.person,
                        () {
                      showEditInfoDialog(context);
                    }),
                    const SizedBox(height: 4),
                    _buildButtonCard(
                        context, 'تغيير كلمة المرور', Icons.vpn_key, () {
                      showEditPasswordDialog(context);
                    }),
                    const SizedBox(height: 4),
                    _buildButtonCard(
                        context, 'الصالات الرياضية', Icons.location_on, () {
                      Get.toNamed(Routes.myGyms);
                    }),
                    const SizedBox(height: 4),
                    _buildButtonCard(
                        context, 'الإعدادات', Icons.settings, () {}),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // Add your onPressed logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.redDelete,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              16), // More rounded edges for a modern feel
                        ),
                        maximumSize:
                            Size(MediaQuery.of(context).size.width, 55),
                        elevation:
                            5, // Adding some elevation for a shadow effect
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold, // Bold text for emphasis
                                letterSpacing:
                                    0.5, // Slightly increased letter spacing for readability
                              ),
                            ),
                            const Spacer(),
                            AnimatedScale(
                              scale:
                                  1.1, // Button will slightly scale up on press
                              duration: const Duration(
                                  milliseconds:
                                      150), // Smooth animation duration
                              child: Transform(
                                transform: Matrix4.rotationY(3.14),
                                child: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 26, // Slightly larger icon
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }

  Widget _buildBackgroundImage() {
    return Align(
      alignment: const AlignmentDirectional(0, -1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          Assets.header,
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height * 0.35,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Align(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(Get.context!).size.height * 0.1),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              Assets.myTrainerImage,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          const Opacity(
            opacity: 0.8,
            child: Text(
              'محمد أبو صالح',
              style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.white,
                fontSize: 16,
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
        ],
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
