import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _formKey = GlobalKey<FormState>();

  late List _plans;
  late int _numberOfDaysUserHave;
  late String planName;
  late String debts;
  late String amountPaid;
  late String userName;
  late String imageURL;
  late String subscriptionId;

  PreferencesService preferencesService = PreferencesService();
  Future<void> _checkToken() async {
    SharedPreferences prefs = await preferencesService.getPreferences();
    String? token = prefs.getString('token');

    if (token == null) {
      Get.toNamed(Routes.singIn); // Navigate to coach dashboard
    }
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
    _plans = [];
    planName = '';
    _numberOfDaysUserHave = 0;
    debts = '';
    amountPaid = '';
    userName = '';
    imageURL = Assets.notFound;
    subscriptionId = '';
    fetchPlans();
    fetchNumberOfDays();
    fetchUserPlan();
  }

  Future<void> fetchNumberOfDays() async {
    try {
      // Fetch the user's subscription document
      final subscriptions = await _firestore
          .collection('coaches')
          .doc(_auth.currentUser?.uid)
          .collection('subscriptions')
          .where('username', isEqualTo: widget.username)
          .get();

      final user = await _firestore
          .collection('trainees')
          .doc(subscriptions.docs[0]['userId'])
          .get();

      // Check if any document was returned
      if (subscriptions.docs.isNotEmpty) {
        // Safely extract the end date and calculate the difference
        var endDateStr = subscriptions.docs[0]['endDate'];
        if (endDateStr != null) {
          try {
            // Parse the end date and calculate the difference in days
            setState(() {
              userName = user.get('firstName') + ' ' + user.get('lastName');
              imageURL = user.get('profileImageUrl');
              debts = subscriptions.docs[0]['debts'].toString();
              amountPaid = subscriptions.docs[0]['amountPaid'];
              subscriptionId = subscriptions.docs.first.id;
              _numberOfDaysUserHave =
                  DateTime.parse(endDateStr).difference(DateTime.now()).inDays;
            });
          } catch (e) {
            // Handle the case where 'endDate' could not be parsed
            print('Error parsing endDate: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تاريخ الانتهاء غير صالح')),
            );
          }
        } else {
          // Handle the case where 'endDate' is null
          print('Error: endDate is null');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تاريخ الانتهاء غير موجود')),
          );
        }
      } else {
        // Handle the case where no documents were returned
        print('No subscriptions found for this user');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لم يتم العثور على الاشتراك')),
        );
      }
    } catch (e) {
      // Catch any errors during the Firestore request or network issues
      print('Error fetching user subscription: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء جلب البيانات')),
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
          title: const Text(
            'تأكيد الإلغاء',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'هل أنت متأكد أنك تريد إلغاء الاشتراك لهذا المستخدم؟',
            textAlign: TextAlign.end,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled
              },
              child:
                  const Text('إلغاء', style: TextStyle(color: Palette.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.redDelete,
              ),
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed
              },
              child:
                  const Text('تأكيد', style: TextStyle(color: Palette.white)),
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
        await cleanSubscription();

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
              .delete()
              .then((value) {
            Get.back();
          });

          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم الغاء الاشتراك بنجاح'),
            ),
          );

          widget.fetchTrainees();
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
    try {
      final user = await _firestore
          .collection('trainees')
          .where('username', isEqualTo: widget.username)
          .get();

      if (user.docs.isNotEmpty) {
        // Get the document snapshot
        var userDoc = user.docs[0].data();

        if (userDoc['coachId'] == null) {
          setState(() {
            planName = 'لا يوجد خطة!';
          });
          return;
        }

        if (userDoc['planId'] == null) {
          setState(() {
            planName = 'لا يوجد خطة!';
          });
          return;
        }

        final paln = await _firestore
            .collection('coaches')
            .doc(userDoc['coachId'])
            .collection('plans')
            .doc(userDoc['planId'])
            .get();

        if (paln.exists) {
          setState(() {
            planName = paln.data()!['name'];
          });
        }
      } else {
        planName = 'لا يوجد خطة!';
      }
    } catch (e) {
      print("Error fetching user plan: $e");
      setState(() {
        planName = 'لا يوجد خطة!';
      });
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
            title: const Text(
              'تأكيد الإلغاء',
              textAlign: TextAlign.center,
            ),
            content: const Text(
              'هل أنت متأكد أنك تريد حذف الخطة لهذا المستخدم؟',
              textAlign: TextAlign.end,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // User canceled
                },
                child:
                    const Text('إلغاء', style: TextStyle(color: Palette.black)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.redDelete,
                ),
                onPressed: () {
                  Navigator.of(context).pop(true); // User confirmed
                },
                child:
                    const Text('تأكيد', style: TextStyle(color: Palette.white)),
              ),
            ],
          );
        },
      );

      if (!confirmCancel) {
        return; // If user cancels, exit the method
      }

      await cleanSubscription();

      // Fetch updated data
      await fetchUserPlan();
      await fetchPlans();

      // Notify the user of success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حذف الخطة بنجاح!')),
      );
    } catch (e) {
      // Catch any unexpected errors that occur in the try block
      print('Error in removePlan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء إلغاء الخطة')),
      );
    }
  }

  Future<void> cleanSubscription() async {
    // Fetch the user based on the username
    var querySnapshot = await _firestore
        .collection('trainees')
        .where('username', isEqualTo: widget.username)
        .get();

    // Check if any documents are found
    if (querySnapshot.docs.isEmpty) {
      // If no user is found, notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يوجد مستخدم بهذا الاسم!')),
      );
      return;
    }

    try {
      await _firestore
          .collection('trainees')
          .doc(querySnapshot.docs.first.id)
          .update({'planId': null, 'coachId': null});
    } catch (e) {
      // If there is an error while updating the Firestore document, log it
      print('Error removing plan for user ${querySnapshot.docs.first.id}: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('فشل حذف الخطة للمستخدم ${querySnapshot.docs.first.id}')),
      );
    }
  }

  Future<void> _updatePlan(newValue) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
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
            'planId': newValue,
            'coachId': _auth.currentUser?.uid,
          });

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إضافة الخطة بنجاح'),
            ),
          );

          // Refresh data
          fetchUserPlan();
          fetchPlans().then((v) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
        } else {
          // Handle case where plan doesn't exist
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لم يتم العثور على الخطة'),
            ),
          );
          Navigator.of(context).pop();
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

  Future<void> _updateDebt(newValue, id) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      // Fetch the plan document from the 'coaches' collection
      DocumentReference<Map<String, dynamic>> subscription = await _firestore
          .collection('coaches')
          .doc(_auth.currentUser?.uid)
          .collection('subscriptions')
          .doc(id);

      // Check if the plan exists
      // Update the document with the plan data
      await subscription.update({
        'debts': '${int.parse(debts) + int.parse(newValue)}',
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم أضافة الدين بنجاح'),
        ),
      );

      fetchNumberOfDays().then((v) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
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
                  bodyLarge: TextStyle(color: Palette.white, fontSize: 16),
                  bodyMedium: TextStyle(color: Palette.white, fontSize: 14),
                  headlineLarge: TextStyle(
                      color: Palette.white,
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
                      color: Palette.white, fontSize: 14), // Label text style
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
                    foregroundColor: Palette.white, // Customize text color
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
                                  style: const TextStyle(color: Palette.white),
                                ),
                              ),
                            );
                          }).toList(),

                          onChanged: _updatePlan,
                        ),
                      ],
                    ),
                    actions: [
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

  void showEditDebt(BuildContext context) {
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
                  bodyLarge: TextStyle(color: Palette.white, fontSize: 16),
                  bodyMedium: TextStyle(color: Palette.white, fontSize: 14),
                  headlineLarge: TextStyle(
                      color: Palette.white,
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
                      color: Palette.white, fontSize: 14), // Label text style
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
                    foregroundColor: Palette.white, // Customize text color
                  ),
                )),
            child: Expanded(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    title: const Text('تعديل الديون',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('أضف مقدار الزيادة او الخضم بالسالب',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 16),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (updateValue) {
                            selectedValue = updateValue;
                          },
                          decoration: const InputDecoration(
                            labelText: "المقدار",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          if (selectedValue != null) {
                            _updateDebt(selectedValue, subscriptionId);
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
            ));
      },
    );
  }

  Future<void> _updateSubscription(stratDate, endDate, id) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      // Fetch the plan document from the 'coaches' collection
      DocumentReference<Map<String, dynamic>> subscription = await _firestore
          .collection('coaches')
          .doc(_auth.currentUser?.uid)
          .collection('subscriptions')
          .doc(id);

      // Check if the plan exists
      // Update the document with the plan data
      await subscription.update({'startDate': stratDate, 'endDate': endDate});

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم أضافة تجديد الإشتراك بنجاح'),
        ),
      );

      fetchNumberOfDays().then((v) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
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

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.toLocal()}".split(' ')[0]; // Format as yyyy-mm-dd
      });
    }
  }

  void showEditSubscriptionDialog(BuildContext context) {
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();

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
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Palette.secondaryColor,
              labelStyle: TextStyle(color: Colors.white, fontSize: 14),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow, width: 2)),
              errorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2)),
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
                  title: const Text('إضافة متدرب جديد',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  content: Form(
                    key: _formKey, // Use the form key for validation
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('يرجى ملئ البيانات المطلوبة',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: startDateController,
                          decoration: const InputDecoration(
                              labelText: "تاريخ البدء",
                              border: OutlineInputBorder()),
                          readOnly: true,
                          onTap: () {
                            _selectDate(context, startDateController);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال تاريخ البدء';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: endDateController,
                          decoration: const InputDecoration(
                              labelText: "تاريخ الانتهاء",
                              border: OutlineInputBorder()),
                          readOnly: true,
                          onTap: () {
                            _selectDate(context, endDateController);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال تاريخ الانتهاء';
                            }
                            if (startDateController.text.isNotEmpty &&
                                endDateController.text.isNotEmpty) {
                              // Compare the dates
                              DateTime startDate =
                                  DateTime.parse(startDateController.text);
                              DateTime endDate =
                                  DateTime.parse(endDateController.text);

                              if (startDate.isAfter(endDate)) {
                                return 'تاريخ البدء لا يمكن أن يكون أكبر من تاريخ الانتهاء';
                              }
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
                          _updateSubscription(startDateController.text,
                              endDateController.text, subscriptionId);
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    top: MediaQuery.of(context).size.height *
                                        0.1),
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
                                        child: Image.network(
                                          imageURL,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Opacity(
                                      opacity: 0.8,
                                      child: Text(
                                        userName.isEmpty
                                            ? 'لا يوجد مستخدم'
                                            : userName,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          color: Palette.white,
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
                                      alignment:
                                          const AlignmentDirectional(0, 0),
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
                                cancelSubscription(context, widget.username);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Palette.redDelete, // Button color
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                fixedSize: const Size(double.infinity, 45),
                              ),
                              child: const Text(
                                'إلغاء إشتراكه',
                                style: TextStyle(
                                  fontFamily: 'Inter Tight',
                                  color: Palette.white,
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
                                fixedSize: const Size(double.infinity, 45),
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
                    const SizedBox(height: 8),
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
                                showEditSubscriptionDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Palette.mainAppColorNavy, // Button color
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                fixedSize: const Size(double.infinity, 45),
                              ),
                              child: const Text(
                                'تجديد الإشتراك',
                                style: TextStyle(
                                  fontFamily: 'Inter Tight',
                                  color: Palette.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text('الخطة المضافة',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Palette.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _buildCard(context, planName, () {
                        removePlan();
                        fetchUserPlan();
                      }, Icons.delete, Palette.error, '', () {}),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Divider(
                          color: Palette.gray,
                        )),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text('المعاملات المالية',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Palette.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _buildCard(context, amountPaid, () {}, Icons.money,
                          Palette.greenActive, 'المبلغ المدفوع', () {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _buildCard(context, debts, () {}, Icons.add_card,
                          Palette.mainAppColor, 'الديون', () {
                        showEditDebt(context);
                      }),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildCard(BuildContext context, String planName, Function onTap,
    IconData icon, Color iconColor, String iconText, Function ocCardTap) {
  return InkWell(
    onTap: () => ocCardTap(),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Palette.secondaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Text(
                planName,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: Palette.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                iconText,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: iconColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          planName == 'لا يوجد خطة!'
              ? const SizedBox()
              : InkWell(
                  onTap: () => onTap(),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
                ),
        ]),
      ),
    ),
  );
}
