import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/routes/routes.dart';

class TraineeBody extends StatefulWidget {
  final String email;
  const TraineeBody({super.key, required this.email});

  @override
  _TraineeBodyState createState() => _TraineeBodyState();
}

class _TraineeBodyState extends State<TraineeBody> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late List _plans;
  late int _numberOfDaysUserHave;
  late String planName;

  @override
  void initState() {
    super.initState();
    _plans = [];
    planName = '';
    _numberOfDaysUserHave = 0;
    fetchPlans();
    fetchNumberOfDays();
    fetchUserPlan();
  }

  Future<void> fetchNumberOfDays() async {
    final user = await _firestore
        .collection('coaches')
        .doc(_auth.currentUser?.uid)
        .collection('subscriptions')
        .where(
          'email',
          isEqualTo: widget.email,
        )
        .get();

    setState(() {
      _numberOfDaysUserHave = DateTime.parse(user.docs[0]['endDate'])
          .difference(DateTime.now())
          .inDays;
    });
  }

  Future<void> fetchPlans() async {
    final plans = await _firestore
        .collection('coaches')
        .doc(_auth.currentUser?.uid)
        .collection('plans')
        .get();

    setState(() {
      _plans = plans.docs.map((doc) {
        return {
          'id': doc.id, // The document ID
          ...doc.data(), // The document data
        };
      }).toList();
    });
  }

  Future<void> cancelSubscription(BuildContext context, String email) async {
    try {
      // Retrieve the user's subscription data
      final subscriptionDoc = await _firestore
          .collection('coaches')
          .doc(_auth.currentUser?.uid)
          .collection('subscriptions')
          .where('email', isEqualTo: email)
          .get();

      if (subscriptionDoc.docs.isNotEmpty) {
        // Delete the subscription document
        await _firestore
            .collection('coaches')
            .doc(_auth.currentUser?.uid)
            .collection('subscriptions')
            .doc(subscriptionDoc.docs[0].id)
            .delete();

        // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم الغاء الاشتراك بنجاح'),
          ),
        );

        Get.back();
      } else {
        // No subscription found for the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لا يوجد اشتراك لهذا المستخدم'),
          ),
        );
      }
    } catch (e) {
      // Show error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطأ"),
        ),
      );
    }
  }

  Future<void> fetchUserPlan() async {
    final user = await _firestore
        .collection('trainees')
        .where('email', isEqualTo: widget.email)
        .get();
    if (user.docs.isNotEmpty && user.docs[0]['plan'] != null) {
      planName = user.docs[0]['plan']['name'] ??
          'Default Plan Name'; // Fallback to default if 'name' is missing
    } else {
      planName = 'لا يوجد خطة!';
    }
  }

  Future<void> removePlan() async {
    try {
      await _firestore
          .collection('trainees')
          .where('email', isEqualTo: widget.email)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          _firestore.collection('trainees').doc(doc.id).update({'plan': null});
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void showAddPlanDialog(BuildContext context) {
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
                          color:
                              Colors.transparent), // Border color when enabled
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.yellow,
                        width: 2), // Border color when focused
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.red), // Border color on error
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red,
                        width: 2), // Border color on error when focused
                  ),
                ),
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
                    title: Row(
                      children: [
                        const Text('اضافة خطة',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.myPlans);
                          },
                          icon: const Icon(Icons.add),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Palette.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('يرجى ملئ البيانات المطلوبة',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          dropdownColor: Palette.secondaryColor,
                          decoration: const InputDecoration(
                            labelText:
                                "الخطط الخاصة بك", // Label for the dropdown
                            border: OutlineInputBorder(),
                          ),
                          value: selectedValue, // Selected value from dropdown
                          items: _plans
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value['id']
                                  as String, // Casting dynamic to String
                              child: Align(
                                alignment: AlignmentDirectional
                                    .centerEnd, // Align to the right
                                child: Text(
                                  value['name'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }).toList(),

                          onChanged: (newValue) async {
                            await _firestore
                                .collection('trainees')
                                .where('email', isEqualTo: widget.email)
                                .get()
                                .then((querySnapshot) async {
                              // Check if any document matches the query
                              if (querySnapshot.docs.isNotEmpty) {
                                // Get the document reference of the first matching document
                                var docRef = querySnapshot.docs.first.reference;

                                DocumentSnapshot<Map<String, dynamic>> plans =
                                    await _firestore
                                        .collection('coaches')
                                        .doc(_auth.currentUser?.uid)
                                        .collection('plans')
                                        .doc(newValue)
                                        .get();

                                // Update the document
                                await docRef.update({
                                  'plan': {
                                    ...(plans.data() ??
                                        {}), // If plans.data() is null, an empty map is used
                                    'coachId': _auth.currentUser?.uid,
                                  },
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('تم إضافة الخطة بنجاح'),
                                  ),
                                );

                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('لم يتم العثور على الخطة'),
                                  ),
                                );
                                Navigator.of(context).pop();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          if (selectedValue != null) {}
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
              child: Column(
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0, 1),
                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          const HeaderImage(),
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.1),
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
                                  const SizedBox(height: 8),
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
                                  Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Text(
                                      'تبقى له ${_numberOfDaysUserHave} يوم من الإشتراك',
                                      style: const TextStyle(
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
                  const SizedBox(height: 20),
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
                              cancelSubscription(context, widget.email);
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
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12), // Spacing between buttons
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              showAddPlanDialog(context);
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('الخطة المضافة',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: _buildCard(context, planName, () {
                      removePlan();
                      fetchUserPlan();
                    }),
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

Widget _buildCard(BuildContext context, String planName, Function onTap) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: Palette.secondaryColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          planName,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        planName == 'لا يوجد خطة!'
            ? const SizedBox()
            : InkWell(
                onTap: () => onTap(),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 24,
                ),
              ),
      ]),
    ),
  );
}
