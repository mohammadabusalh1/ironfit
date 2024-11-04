import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/editPlan/screens/edit_plan_screen.dart';

class MyPlansBody extends StatefulWidget {
  const MyPlansBody({super.key});

  @override
  _MyPlansBodyState createState() => _MyPlansBodyState();
}

class _MyPlansBodyState extends State<MyPlansBody> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isDateSortUp = true;
  var plans = <DocumentSnapshot>[];

  bool isLoading = true;

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    getPlans();
  }

  Future<void> deletePlan(BuildContext context, String planId) async {
    try {
      // Show a confirmation dialog before deletion
      bool confirmCancel = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(
              LocalizationService.translateFromGeneral('cancelConfirmation'),
              textAlign: TextAlign.center,
            ),
            content: Text(
              LocalizationService.translateFromGeneral(
                  'deletePlanConfirmation'),
              textAlign: TextAlign.end,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // User canceled
                },
                child: Text(LocalizationService.translateFromGeneral('cancel'),
                    style: AppStyles.textCairo(
                        14, Palette.black, FontWeight.w500)),
              ),
              BuildIconButton(
                text: LocalizationService.translateFromGeneral(
                    'cancelConfirmation'),
                backgroundColor: Palette.redDelete,
                onPressed: () {
                  Navigator.of(context).pop(true); // User confirmed
                },
              ),
            ],
          );
        },
      );

      // If the user cancels, return early
      if (!confirmCancel) {
        return;
      }

      // Check for null planId or current user
      if (planId.isEmpty || _auth.currentUser == null) {
        customSnackbar.showMessage(
            context,
            LocalizationService.translateFromGeneral(
                'userNotLoggedInOrPlanIdMissing'));
        return;
      }

      // Try to delete the plan from Firestore
      await _firestore
          .collection('coaches')
          .doc(_auth.currentUser?.uid)
          .collection('plans')
          .doc(planId)
          .delete()
          .then(
            (value) => getPlans(),
          );

      // Notify the user of success
      customSnackbar.showMessage(context,
          LocalizationService.translateFromGeneral('planDeletedSuccessfully'));
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      print('Firebase error: $e');
      customSnackbar.showMessage(context,
          '${LocalizationService.translateFromGeneral('firebaseErrorDeletingPlan')} ${e.message}');
    } catch (e) {
      // Handle other types of errors
      print('Unexpected error: $e');
      customSnackbar.showMessage(context,
          '${LocalizationService.translateFromGeneral('unexpectedErrorDeletingPlan')}');
    }
  }

  Future<void> getPlans() async {
    try {
      // Ensure user is authenticated before attempting to fetch plans
      final user = _auth.currentUser;
      if (user == null) {
        throw StateError('User not authenticated');
      }
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('coaches')
          .doc(user.uid)
          .collection('plans')
          .orderBy('createdAt', descending: !isDateSortUp)
          .get();
      // Firestore query for sorted plans based on subscriptionDate
      setState(() {
        plans = querySnapshot.docs;
        isLoading = false;
      });
    } catch (e) {
      // Log the error and return an error stream
      print('Error fetching plans: $e');
    }
  }

  void toggleDateSort() {
    setState(() {
      isDateSortUp = !isDateSortUp;
      getPlans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        HeaderImage(),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ReturnBackButton(),
                              const SizedBox(width: 12),
                              Opacity(
                                opacity: 0.8,
                                child: Text(
                                  LocalizationService.translateFromGeneral(
                                      'myPrograms'),
                                  style: AppStyles.textCairo(
                                    20,
                                    Palette.mainAppColorWhite,
                                    FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
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
                          child: BuildIconButton(
                            onPressed: () {
                              Get.toNamed(Routes.createPlan);
                            },
                            iconSize: 20,
                            icon: Icons.add,
                            iconColor: Palette.black,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: BuildIconButton(
                            fontSize: 12,
                            onPressed: () {
                              toggleDateSort();
                            },
                            iconSize: 18,
                            icon: isDateSortUp
                                ? Icons.north_outlined
                                : Icons.south_outlined,
                            text: LocalizationService.translateFromGeneral(
                                'date'),
                            backgroundColor: Palette.mainAppColorWhite,
                            textColor: Palette.mainAppColorNavy,
                            iconColor: Palette.mainAppColorNavy,
                          ),
                        ), // Space between buttons
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(), // Show loader
                        )
                      : Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 0, 24, 0),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: plans.map((DocumentSnapshot document) {
                              // 5. Check that the document data is not null.
                              Map<String, dynamic>? data =
                                  document.data() as Map<String, dynamic>?;

                              if (data == null) {
                                return const Text(
                                    'Error: Invalid plan data'); // Handle null data.
                              }

                              // 6. Fallbacks for null fields.
                              String title = data['name'] ??
                                  LocalizationService.translateFromGeneral(
                                      'noTitle'); // Provide default values if null.
                              String description = data['description'] ??
                                  LocalizationService.translateFromGeneral(
                                      'noDescription'); // Provide default values if null.

                              return CustomCard(
                                onPressedEdit: () {
                                  Get.to(Directionality(
                                      textDirection: TextDirection.rtl,
                                      child:
                                          EditPlanScreen(planId: document.id)));
                                },
                                title: title, // Use non-nullable strings.
                                description:
                                    description, // Use non-nullable strings.
                                icon: Icons.arrow_back,
                                onPressed: () {
                                  deletePlan(context, document.id);
                                },
                              );
                            }).toList(),
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

class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;
  final VoidCallback onPressedEdit;

  const CustomCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
    required this.onPressedEdit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressedEdit,
      child: Card(
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
                                style: AppStyles.textCairo(
                                  14,
                                  Palette.mainAppColor,
                                  FontWeight.bold,
                                ),
                              ),
                              Text(
                                description,
                                style: AppStyles.textCairo(
                                  10,
                                  Palette.gray,
                                  FontWeight.w400,
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
                            color: Palette.redDelete,
                            size: 24,
                          ),
                          onPressed: onPressed,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Palette.mainAppColorWhite,
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
