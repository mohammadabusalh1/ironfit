import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/confirmRemove.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/theme.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';

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
  late String planName;
  late String userName;
  late String imageURL;
  late int _numberOfDaysUserHave;
  late String debts;
  late String amountPaid;

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();
  String dir = LocalizationService.getDir();

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    _plans = [];
    planName = LocalizationService.translateFromGeneral('noData');
    _numberOfDaysUserHave = 0;
    debts = LocalizationService.translateFromGeneral('noData');
    amountPaid = LocalizationService.translateFromGeneral('noData');
    userName = LocalizationService.translateFromGeneral('noData');
    imageURL = Assets.notFound;
    fetchPlans();
    fetchNumberOfDays();
    fetchUserPlan();
  }

  Future<void> fetchNumberOfDays() async {
    try {
      // Fetch the user's subscription document
      final subscriptions = await _firestore
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
        if (endDateStr.toString().isNotEmpty) {
          try {
            // Parse the end date and calculate the difference in days
            setState(() {
              userName = user.data()?.containsKey('firstName') ?? false
                  ? user.get('firstName') + ' ' + user.get('lastName')
                  : widget.username;
              imageURL = user.data()?.containsKey('profileImageUrl') ?? false
                  ? user.get('profileImageUrl')
                  : Assets.notFound;
              debts = subscriptions.docs[0]['debts'].toString();
              amountPaid = subscriptions.docs[0]['amountPaid'].toString();
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
        }
      } else {
        // Handle the case where no documents were returned
        print('No subscriptions found for this user');
      }
    } catch (e) {
      // Catch any errors during the Firestore request or network issues
      print('Error fetching user subscription: $e');
    }
  }

  Future<void> fetchPlans() async {
    try {
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
    } catch (e) {
      // Handle any errors that occur during the fetch operation
      print('Error fetching plans: $e');
    }
  }

  Future<void> cancelSubscription(BuildContext context, String username) async {
    // Show a confirmation dialog before canceling
    bool cancel = await confirmCancel(context);
    // If the user confirms cancellation
    if (cancel) {
      try {
        customSnackbar.showMessage(
            context,
            LocalizationService.translateFromGeneral(
                'cancelSubscriptionIsStarted'));

        // Fetch current user ID
        String? coachId = _auth.currentUser?.uid;
        if (coachId == null) {
          throw Exception(LocalizationService.translateFromGeneral('noUser'));
        }

        // Retrieve the user's subscription data
        final subscriptionDoc = await _firestore
            .collection('subscriptions')
            .where('username', isEqualTo: username)
            .get();

        if (subscriptionDoc.docs.isNotEmpty) {
          // Delete the subscription document
          await _firestore
              .collection('subscriptions')
              .where('username', isEqualTo: username)
              .get()
              .then((v) {
            v.docs.first.reference.update({'isActive': false, 'plan': null});
            widget.fetchTrainees();
            Navigator.pushNamed(context, Routes.trainees);
          });

          // Show a success message
          customSnackbar.showMessage(
              context,
              LocalizationService.translateFromGeneral(
                  'subscriptionCancelled'));
          widget.fetchTrainees();
        } else {
          // No subscription found for the user
          customSnackbar.showMessage(
              context,
              LocalizationService.translateFromGeneral(
                  'noSubscriptionWithName'));
        }
      } catch (e) {
        String errorMessage;

        // Handle Firebase and network-related errors specifically
        if (e is FirebaseException) {
          errorMessage = LocalizationService.translateFromGeneral(
              'networkConnectionFailed');
        } else if (e is NetworkImageLoadException) {
          errorMessage = LocalizationService.translateFromGeneral(
              'networkConnectionFailed');
        } else {
          errorMessage =
              LocalizationService.translateFromGeneral('unexpectedError');
        }

        customSnackbar.showMessage(context, errorMessage);
      }
    } else {
      customSnackbar.showMessage(context,
          LocalizationService.translateFromGeneral('cancellationCompleted'));
    }
  }

  Future<void> fetchUserPlan() async {
    try {
      final subscription = await _firestore
          .collection('subscriptions')
          .where('username', isEqualTo: widget.username)
          .get();

      if (subscription.docs.isNotEmpty) {
        // Get the document snapshot
        var userDoc = subscription.docs[0].data();

        if (userDoc['plan'] == null) {
          setState(() {
            planName = 'لا يوجد خطة!';
          });
        } else {
          setState(() {
            planName = userDoc['plan'];
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
      bool cancel = await confirmCancel(context);

      if (!cancel) {
        return; // If user cancels, exit the method
      }

      var querySnapshot = await _firestore
          .collection('subscriptions')
          .where('username', isEqualTo: widget.username)
          .where('isActive', isEqualTo: true)
          .get();

      if (querySnapshot.docs.isEmpty) {
        customSnackbar.showMessage(context,
            LocalizationService.translateFromGeneral('noSubscriptionWithName'));
        return; // Exit the method if no matching documents are found
      }

      var docRef = querySnapshot.docs.first.reference;
      await docRef.update({
        'plan': null,
      });

      // Fetch updated data
      await fetchUserPlan();
      await fetchPlans();

      // Notify the user of success
      customSnackbar.showMessage(context,
          LocalizationService.translateFromGeneral('planDeletedSuccessfully'));
    } catch (e) {
      // Catch any unexpected errors that occur in the try block
      print('Error in removePlan: $e');
      customSnackbar.showMessage(
          context,
          LocalizationService.translateFromGeneral(
              'unexpectedErrorDeletingPlan'));
    }
  }

  Future<void> _updatePlan(newValue) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      // Get the query snapshot
      var querySnapshot = await _firestore
          .collection('subscriptions')
          .where('username', isEqualTo: widget.username)
          .where('isActive', isEqualTo: true)
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
            'plan': plans.data()!['name'],
          });

          // Show success message
          customSnackbar.showMessage(
            context,
            LocalizationService.translateFromPage('message', 'snackbarSuccess'),
          );

          // Refresh data
          fetchUserPlan();
          fetchPlans().then((v) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
        } else {
          // Handle case where plan doesn't exist
          customSnackbar.showMessage(
            context,
            LocalizationService.translateFromGeneral('planNotFound'),
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      } else {
        customSnackbar.showMessage(
          context,
          LocalizationService.translateFromGeneral('traineeNotFound'),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Catch any errors that occur during Firestore operations
      print('Error: $e');
      customSnackbar.showMessage(
          context, LocalizationService.translateFromGeneral('unexpectedError'));
    }
  }

  Future<void> _updateDebt(newValue) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      // Fetch the plan document from the 'coaches' collection
      QuerySnapshot<Map<String, dynamic>> subscription = await _firestore
          .collection('subscriptions')
          .where('username', isEqualTo: widget.username)
          .get();

      // Check if the plan exists
      // Update the document with the plan data
      await subscription.docs.first.reference.update({
        'debts': '${int.parse(debts) + int.parse(newValue)}',
      });

      // Show success message
      customSnackbar.showMessage(
        context,
        LocalizationService.translateFromPage('message', 'snackbarSuccess'),
      );

      fetchNumberOfDays().then((v) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    } catch (e) {
      // Catch any errors that occur during Firestore operations
      print('Error: $e');
      customSnackbar.showMessage(
        context,
        LocalizationService.translateFromGeneral('unexpectedError'),
      );
    }
  }

  void showAddPlanDialog(BuildContext context) {
    String? selectedValue;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
            data: customThemeData,
            child: SingleChildScrollView(
              child: Directionality(
                textDirection:
                    dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                child: AlertDialog(
                  title: Row(
                    children: [
                      Text(LocalizationService.translateFromGeneral('addPlan'),
                          style: AppStyles.textCairo(
                              18, Palette.mainAppColorWhite, FontWeight.bold)),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.myPlans);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Palette.mainAppColorNavy,
                        ),
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
                      Text(
                          LocalizationService.translateFromGeneral(
                              'pleaseFillRequiredData'),
                          style: AppStyles.textCairo(
                              16, Palette.mainAppColorWhite, FontWeight.w500)),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        dropdownColor: Palette.secondaryColor,
                        decoration: InputDecoration(
                          labelText: LocalizationService.translateFromGeneral(
                              'yourPlans'), // Label for the dropdown
                          border: const OutlineInputBorder(),
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
                                style: AppStyles.textCairo(12,
                                    Palette.mainAppColorWhite, FontWeight.w500),
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
                      child: Text(
                        LocalizationService.translateFromGeneral('cancel'),
                      ),
                    ),
                  ],
                  actionsAlignment: MainAxisAlignment.start,
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
            data: customThemeData,
            child: Directionality(
              textDirection:
                  dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
              child: SingleChildScrollView(
                child: AlertDialog(
                  title: Text(
                      LocalizationService.translateFromGeneral('modifyDebts'),
                      style: AppStyles.textCairo(
                          22, Palette.mainAppColorWhite, FontWeight.bold)),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          LocalizationService.translateFromGeneral(
                              'addIncrementOrDecrementNegative'),
                          style: AppStyles.textCairo(
                              14, Palette.mainAppColorWhite, FontWeight.w500)),
                      const SizedBox(height: 16),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (updateValue) {
                          selectedValue = updateValue;
                        },
                        decoration: InputDecoration(
                          labelText: LocalizationService.translateFromGeneral(
                              'amount'),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    BuildIconButton(
                      onPressed: () {
                        if (selectedValue != null) {
                          _updateDebt(selectedValue);
                        }
                      },
                      text: LocalizationService.translateFromGeneral('save'),
                      width: 90,
                      fontSize: 14,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text(
                          LocalizationService.translateFromGeneral('cancel')),
                    ),
                  ],
                  actionsAlignment: MainAxisAlignment.start,
                ),
              ),
            ));
      },
    );
  }

  Future<void> _updateSubscription(
      startDate, endDate, amountPaid, debts) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      // Fetch the plan document from the 'coaches' collection
      QuerySnapshot<Map<String, dynamic>> subscription = await _firestore
          .collection('subscriptions')
          .where('username', isEqualTo: widget.username)
          .where('isActive', isEqualTo: true)
          .get();

      if (subscription.docs.isEmpty) {
        throw Exception("No subscription found for coach.");
      }

      // Check if the plan exists
      // Update the document with the plan data
      await subscription.docs.first.reference.update({
        'startDate': startDate,
        'endDate': endDate,
        'amountPaid': int.parse(amountPaid.toString()),
        'totalAmountPaid':
            int.parse(subscription.docs.first.data()['amountPaid'].toString()) +
                int.parse(amountPaid.toString()),
        'debts': int.parse(subscription.docs.first.data()['debts'].toString()) +
            int.parse(debts.toString()),
      });

      // Show success message
      customSnackbar.showMessage(
        context,
        LocalizationService.translateFromPage('message', 'snackbarSuccess'),
      );

      fetchNumberOfDays().then((v) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    } catch (e) {
      // Catch any errors that occur during Firestore operations
      print('Error: $e');
      customSnackbar.showMessage(
          context, LocalizationService.translateFromGeneral('unexpectedError'));
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
    final TextEditingController amountPaidController = TextEditingController();
    final TextEditingController debtsController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
            data: customThemeData,
            child: SingleChildScrollView(
              child: Directionality(
                textDirection:
                    dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                child: AlertDialog(
                  title: Text(
                      LocalizationService.translateFromGeneral('addNewTrainee'),
                      style: AppStyles.textCairo(
                          24, Palette.mainAppColorWhite, FontWeight.bold)),
                  content: Form(
                    key: _formKey, // Use the form key for validation
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            LocalizationService.translateFromGeneral(
                                'pleaseFillRequiredData'),
                            style: AppStyles.textCairo(14,
                                Palette.mainAppColorWhite, FontWeight.w500)),
                        const SizedBox(height: 16),
                        BuildTextField(
                          controller: startDateController,
                          label: LocalizationService.translateFromGeneral(
                              'startDate'),
                          onTap: () {
                            _selectDate(context, startDateController);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationService.translateFromGeneral(
                                  'enterStartDate');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        BuildTextField(
                          controller: endDateController,
                          label: LocalizationService.translateFromGeneral(
                              'endDate'),
                          onTap: () {
                            _selectDate(context, endDateController);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationService.translateFromGeneral(
                                  'enterEndDate');
                            }
                            if (startDateController.text.isNotEmpty &&
                                endDateController.text.isNotEmpty) {
                              // Compare the dates
                              DateTime startDate =
                                  DateTime.parse(startDateController.text);
                              DateTime endDate =
                                  DateTime.parse(endDateController.text);

                              if (startDate.isAfter(endDate)) {
                                return LocalizationService.translateFromGeneral(
                                    'startDateCannotBeAfterEndDate');
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        BuildTextField(
                          onChange: (value) {
                            amountPaidController.text = value;
                          },
                          controller: amountPaidController,
                          keyboardType: TextInputType.number,
                          label: LocalizationService.translateFromGeneral(
                              'amountPaid'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationService.translateFromGeneral(
                                  'validation_amount_paid');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        BuildTextField(
                          onChange: (value) {
                            debtsController.text = value;
                          },
                          controller: debtsController,
                          keyboardType: TextInputType.number,
                          label:
                              LocalizationService.translateFromGeneral('debts'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationService.translateFromGeneral(
                                  'validation_debt');
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    BuildIconButton(
                      text: LocalizationService.translateFromGeneral('save'),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          _updateSubscription(
                              startDateController.text,
                              endDateController.text,
                              amountPaidController.text,
                              debtsController.text);
                        }
                      },
                      width: 90,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text(
                          LocalizationService.translateFromGeneral('cancel')),
                    ),
                  ],
                  actionsAlignment: MainAxisAlignment.start,
                ),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                imageURL.isEmpty ? Assets.notFound : imageURL,
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
                                  ? LocalizationService.translateFromGeneral(
                                      'noUser')
                                  : userName,
                              style: AppStyles.textCairo(18,
                                  Palette.mainAppColorWhite, FontWeight.bold),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Text(
                              '${LocalizationService.translateFromGeneral('daysRemaining')} $_numberOfDaysUserHave ${LocalizationService.translateFromGeneral('days')}',
                              style: AppStyles.textCairo(
                                  12, Palette.gray, FontWeight.w500),
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
                  child: BuildIconButton(
                    text: LocalizationService.translateFromGeneral(
                        'cancelSubscription'),
                    onPressed: () {
                      cancelSubscription(context, widget.username);
                    },
                    backgroundColor: Palette.redDelete,
                    textColor: Palette.white,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12), // Spacing between buttons
                Expanded(
                  flex: 1,
                  child: BuildIconButton(
                    onPressed: () {
                      showAddPlanDialog(context);
                    },
                    text:
                        LocalizationService.translateFromGeneral('add_program'),
                    backgroundColor: Palette.mainAppColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: BuildIconButton(
                    fontSize: 12,
                    onPressed: () {
                      showEditSubscriptionDialog(context);
                    },
                    text: LocalizationService.translateFromGeneral(
                        'renewSubscription'),
                    backgroundColor: Palette.mainAppColorNavy,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(LocalizationService.translateFromGeneral('addedPlan'),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: AppStyles.textCairo(
                    14, Palette.mainAppColorWhite, FontWeight.bold)),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
                LocalizationService.translateFromGeneral(
                    'financialTransactions'),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: AppStyles.textCairo(
                    14, Palette.mainAppColorWhite, FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _buildCard(
                context,
                amountPaid,
                () {},
                Icons.money,
                Palette.greenActive,
                LocalizationService.translateFromGeneral('amountPaid'),
                () {}),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _buildCard(
              context,
              debts,
              () {},
              Icons.keyboard_arrow_left,
              Palette.mainAppColor,
              LocalizationService.translateFromGeneral('debts'),
              () {
                showEditDebt(context);
              },
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
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
                style: AppStyles.textCairo(
                    16, Palette.mainAppColorWhite, FontWeight.w500),
              ),
              const SizedBox(width: 8),
              Text(
                iconText,
                style: AppStyles.textCairo(12, iconColor, FontWeight.w500),
              ),
            ],
          ),
          planName == LocalizationService.translateFromGeneral('noPlan')
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
