import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/getCoachId.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/coachProfile/controllers/coach_profile_controller.dart';

class UserProfileBody extends StatefulWidget {
  const UserProfileBody({Key? key}) : super(key: key);

  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  final CoachProfileController controller = Get.find();
  String? fullName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    String? coachId = await fetchCoachId();
    if (coachId != null) {
      // Get user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(
              'coaches') // or 'coaches', depending on where you store user data
          .doc(coachId)
          .get();

      if (userDoc.exists) {
        String? firstName = userDoc['firstName'];
        String? lastName = userDoc['lastName'];

        setState(() {
          fullName = '$firstName $lastName';
        });
      } else {
        print("User data not found");
        return null;
      }
    } else {
      print("No user is logged in");
      return null;
    }
  }

  void showEditInfoDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>(); // Form validation key
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController experienceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.grey[900],
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
                backgroundColor: const Color(0xFFFFBB02),
                foregroundColor: const Color(0xFF1C1503),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Palette.secondaryColor,
              labelStyle: TextStyle(color: Colors.white, fontSize: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
            ),
          ),
          child: Expanded(
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: const Text(
                    'تعديل المعلومات',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: firstNameController,
                          decoration:
                              const InputDecoration(hintText: 'الاسم الأول'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال الاسم الأول';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: lastNameController,
                          decoration:
                              const InputDecoration(hintText: 'الاسم الأخير'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال الاسم الأخير';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: ageController,
                          decoration: const InputDecoration(hintText: 'العمر'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال العمر';
                            }
                            if (int.tryParse(value) == null) {
                              return 'يرجى إدخال قيمة صحيحة للعمر';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: experienceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: 'الخبرة'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال الخبرة';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          String? coachId = await fetchCoachId();
                          try {
                            if (coachId != null) {
                              await FirebaseFirestore.instance
                                  .collection('coaches')
                                  .doc(coachId)
                                  .update({
                                'firstName': firstNameController.text,
                                'lastName': lastNameController.text,
                                'age': ageController.text,
                                'experience': experienceController.text,
                              }).then((value) {
                                fetchUserName();
                              });
                              Navigator.of(context).pop();
                            }
                          } catch (e) {
                            // Handle errors (e.g., network issues, Firebase errors)
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('حدث خطأ: $e')));
                          }
                        }
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
          ),
        );
      },
    );
  }

  void showEditPasswordDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    String? oldPassword;
    String? newPassword;
    String? confirmPassword;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.grey[900],
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
                backgroundColor: const Color(0xFFFFBB02),
                foregroundColor: const Color(0xFF1C1503),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.grey, // Adjust color
              labelStyle: TextStyle(color: Colors.white, fontSize: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
            ),
          ),
          child: Expanded(
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: const Text(
                    'تغيير كلمة المرور',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('يرجى ملئ البيانات المطلوبة',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: oldPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'كلمة المرور القديمة'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور القديمة';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: newPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'كلمة المرور الجديدة'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور الجديدة';
                            }
                            if (value.length < 6) {
                              return 'يجب أن تحتوي كلمة المرور الجديدة على 6 أحرف على الأقل';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'تأكيد كلمة المرور الجديدة'),
                          validator: (value) {
                            if (value != newPasswordController.text) {
                              return 'كلمة المرور غير متطابقة';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            User? user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              // Re-authenticate user to change password
                              final AuthCredential credential =
                                  EmailAuthProvider.credential(
                                email: user.email!,
                                password: oldPasswordController.text,
                              );
                              await user
                                  .reauthenticateWithCredential(credential);

                              // Update password
                              await user
                                  .updatePassword(newPasswordController.text);

                              // Inform the user
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('تم تغيير كلمة المرور بنجاح')),
                              );

                              Navigator.of(context).pop(); // Close the dialog
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('حدث خطأ: ${e.toString()}')),
                            );
                          }
                        }
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
          ),
        );
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
                HeaderImage(),
                _buildProfileContent(context),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildButtonCard(
                            context, 'المعلومات الشخصية', Icons.person, () {
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
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }

  Widget _buildProfileContent(BuildContext context) {
    return Align(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(Get.context!).size.height * 0.12),
          Container(
            width: 104, // Add extra width to accommodate the border
            height: 104, // Add extra height to accommodate the border
            decoration: BoxDecoration(
              border: Border.all(
                color: Palette.black, // Replace with your desired border color
                width: 4.0, // Border width
              ),
              borderRadius:
                  BorderRadius.circular(50), // Same as ClipRRect borderRadius
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50), // Match the borderRadius
              child: Image.asset(
                Assets.myTrainerImage,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 10),
          // Use FutureBuilder to display the fetched user name
          Text(
            fullName ?? 'لا يوجد اسم', // If no name, display a default message
            style: const TextStyle(
              color: Palette.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'abusa@gmail.com', // If no name, display a default message
            style: const TextStyle(
              color: Palette.subTitleGrey,
              fontSize: 14,
              fontWeight: FontWeight.w100,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(width: 24), // Space between icon and text
            Text(
              tilte,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Colors.white,
                letterSpacing: 0.0,
              ),
            ),
            Spacer(), // Space between text and trailing icon
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey, // Replace with the theme color if needed
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
