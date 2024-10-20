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
  final String username;
  final Function fetchTrainees;
  const TraineeBody(
      {super.key, required this.username, required this.fetchTrainees});

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
    try {
      // Fetch the user's subscription document
      final user = await _firestore
          .collection('coaches')
          .doc(_auth.currentUser?.uid)
          .collection('subscriptions')
          .where('username', isEqualTo: widget.username)
          .get();

      // Check if any document was returned
      if (user.docs.isNotEmpty) {
        // Safely extract the end date and calculate the difference
        var endDateStr = user.docs[0]['endDate'];
        if (endDateStr != null) {
          try {
            // Parse the end date and calculate the difference in days
            setState(() {
              _numberOfDaysUserHave =
                  DateTime.parse(endDateStr).difference(DateTime.now()).inDays;
            });
          } catch (e) {
            // Handle the case where 'endDate' could not be parsed
            print('Error parsing endDate: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تاريخ الانتهاء غير صالح')),
            );
          }
        } else {
          // Handle the case where 'endDate' is null
          print('Error: endDate is null');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تاريخ الانتهاء غير موجود')),
          );
        }
      } else {
        // Handle the case where no documents were returned
        print('No subscriptions found for this user');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لم يتم العثور على الاشتراك')),
        );
      }
    } catch (e) {
      // Catch any errors during the Firestore request or network issues
      print('Error fetching user subscription: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء جلب البيانات')),
      );
    }
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

  Future<void> cancelSubscription(BuildContext context, String username) async {
    // Show a confirmation dialog before canceling
    bool confirmCancel = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(
            'تأكيد الإلغاء',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'هل أنت متأكد أنك تريد إلغاء الاشتراك لهذا المستخدم؟',
            textAlign: TextAlign.end,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled
              },
              child: Text('إلغاء', style: TextStyle(color: Palette.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.redDelete,
              ),
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed
              },
              child: Text('تأكيد', style: TextStyle(color: Palette.white)),
            ),
          ],
        );
      },
    );

    // If the user confirms cancellation
    if (confirmCancel) {
      try {
        // Show a loading indicator while canceling
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('جاري الغاء الاشتراك...'),
          ),
        );

        // Call removePlan function
        await removePlan();

        // Fetch current user ID
        String? coachId = _auth.currentUser?.uid;
        if (coachId == null) {
          throw Exception("لا يوجد مستخدم مسجل الدخول");
        }

        // Retrieve the user's subscription data
        final subscriptionDoc = await _firestore
            .collection('coaches')
            .doc(coachId)
            .collection('subscriptions')
            .where('username', isEqualTo: username)
            .get();

        if (subscriptionDoc.docs.isNotEmpty) {
          // Delete the subscription document
          await _firestore
              .collection('coaches')
              .doc(coachId)
              .collection('subscriptions')
              .doc(subscriptionDoc.docs[0].id)
              .delete();

          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم الغاء الاشتراك بنجاح'),
            ),
          );

          widget.fetchTrainees();

          // Navigate back after success
          Get.back();
        } else {
          // No subscription found for the user
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لا يوجد اشتراك بهذا الاسم'),
            ),
          );
        }
      } catch (e) {
        String errorMessage;

        // Handle Firebase and network-related errors specifically
        if (e is FirebaseException) {
          errorMessage = 'خطأ في الاتصال بقاعدة البيانات: ${e.message}';
        } else if (e is NetworkImageLoadException) {
          errorMessage = 'فشل الاتصال بالشبكة، تحقق من اتصالك بالإنترنت';
        } else {
          errorMessage = 'حدث خطأ غير متوقع: $e';
        }

        // Show detailed error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    } else {
      // User canceled the operation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إلغاء عملية الحذف'),
        ),
      );
    }
  }

  Future<void> fetchUserPlan() async {
    final user = await _firestore
        .collection('trainees')
        .where('username', isEqualTo: widget.username)
        .get();
    if (user.docs.isNotEmpty) {
      // Get the document snapshot
      var userDoc = user.docs[0].data();

      // Check if 'plan' field exists in the document snapshot
      if (userDoc != null && userDoc.containsKey('plan')) {
        var plan = userDoc['plan'];
        planName = plan != null && plan.containsKey('name')
            ? plan['name'] ??
                'Default Plan Name' // Fallback to default if 'name' is missing
            : 'لا يوجد خطة!';
      } else {
        planName = 'لا يوجد خطة!';
      }
    } else {
      planName = 'لا يوجد خطة!';
    }
  }

  Future<void> removePlan() async {
    try {
      // Show confirmation dialog
      bool confirmCancel = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(
              'تأكيد الإلغاء',
              textAlign: TextAlign.center,
            ),
            content: Text(
              'هل أنت متأكد أنك تريد حذف الخطة لهذا المستخدم؟',
              textAlign: TextAlign.end,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // User canceled
                },
                child: Text('إلغاء', style: TextStyle(color: Palette.black)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.redDelete,
                ),
                onPressed: () {
                  Navigator.of(context).pop(true); // User confirmed
                },
                child: Text('تأكيد', style: TextStyle(color: Palette.white)),
              ),
            ],
          );
        },
      );

      if (!confirmCancel) {
        return; // If user cancels, exit the method
      }

      // Fetch the user based on the username
      var querySnapshot = await _firestore
          .collection('trainees')
          .where('username', isEqualTo: widget.username)
          .get();

      // Check if any documents are found
      if (querySnapshot.docs.isEmpty) {
        // If no user is found, notify the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لا يوجد مستخدم بهذا الاسم!')),
        );
        return;
      }

      // Update 'plan' field to null for each found document
      for (var doc in querySnapshot.docs) {
        try {
          await _firestore
              .collection('trainees')
              .doc(doc.id)
              .update({'plan': null});
        } catch (e) {
          // If there is an error while updating the Firestore document, log it
          print('Error removing plan for user ${doc.id}: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل حذف الخطة للمستخدم ${doc.id}')),
          );
        }
      }

      // Fetch updated data
      await fetchUserPlan();
      await fetchPlans();

      // Notify the user of success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم حذف الخطة بنجاح!')),
      );
    } catch (e) {
      // Catch any unexpected errors that occur in the try block
      print('Error in removePlan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء إلغاء الخطة')),
      );
    }
  }

  Future<void> _updatePlan(newValue) async {
    try {
      // Get the query snapshot
      var querySnapshot = await _firestore
          .collection('trainees')
          .where('username', isEqualTo: widget.username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document reference of the first matching document
        var docRef = querySnapshot.docs.first.reference;

        // Fetch the plan document from the 'coaches' collection
        DocumentSnapshot<Map<String, dynamic>> plans = await _firestore
            .collection('coaches')
            .doc(_auth.currentUser?.uid)
            .collection('plans')
            .doc(newValue)
            .get();

        // Check if the plan exists
        if (plans.exists && plans.data() != null) {
          // Update the document with the plan data
          await docRef.update({
            'plan': {
              ...plans.data()!,
              'coachId': _auth.currentUser?.uid,
            },
          });

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إضافة الخطة بنجاح'),
            ),
          );

          // Refresh data
          fetchUserPlan();
          fetchPlans();
          Navigator.of(context).pop();
        } else {
          // Handle case where plan doesn't exist
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لم يتم العثور على الخطة'),
            ),
          );
          Navigator.of(context).pop();
        }
      } else {
        // Handle case where trainee document is not found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لم يتم العثور على المتدرب'),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Catch any errors that occur during Firestore operations
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء تحديث الخطة: $e'),
        ),
      );
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

                          onChanged: _updatePlan,
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
                              cancelSubscription(context, widget.username);
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
