import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/confirmRemove.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/core/services/paymentServices.dart';
import 'package:ironfit/features/editPlan/screens/edit_plan_screen.dart';
import 'package:startapp_sdk/startapp.dart';

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

  late BannerAd bannerAd;
  bool isBannerAdLoaded = false;
  late String dir;
  var startAppSdk = StartAppSdk();
  StartAppInterstitialAd? interstitialAd;

  void loadInterstitialAd() {
    startAppSdk.loadInterstitialAd().then((interstitialAd) {
      setState(() {
        this.interstitialAd = interstitialAd;
      });
    }).onError<StartAppException>((ex, stackTrace) {
      debugPrint("Error loading Interstitial ad: ${ex.message}");
    }).onError((error, stackTrace) {
      debugPrint("Error loading Interstitial ad: $error");
    });
  }

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    bannerAd = BannerAd(
        adUnitId: 'ca-app-pub-2914276526243261/8152545154',
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }));
    bannerAd.load();
    getPlans();
    dir = LocalizationService.getDir();
    loadInterstitialAd();
  }

  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  Future<void> deletePlan(BuildContext context, String planId) async {
    try {
      bool confirm = await confirmCancel(context);
      // If the user cancels, return early
      if (!confirm) {
        return;
      }

      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Check for null planId or current user
      if (planId.isEmpty || _auth.currentUser == null) {
        customSnackbar.showMessage(
            context,
            LocalizationService.translateFromGeneral(
                'userNotLoggedInOrPlanIdMissing'));
        return;
      }

      // Try to delete the plan from Firestore
      await _firestore.collection('plans').doc(planId).delete().then(
            (value) => getPlans(),
          );

      // Notify the user of success
      customSnackbar.showMessage(context,
          LocalizationService.translateFromGeneral('planDeletedSuccessfully'));
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      print('Firebase error: $e');
      customSnackbar.showMessage(context,
          '${LocalizationService.translateFromGeneral('firebaseErrorDeletingPlan')} ${e.message}');
    } catch (e) {
      // Handle other types of errors
      print('Unexpected error: $e');
      customSnackbar.showMessage(
          context,
          LocalizationService.translateFromGeneral(
              'unexpectedErrorDeletingPlan'));
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
          .collection('plans')
          .where('coachId', isEqualTo: user.uid)
          .get();
      // Firestore query for sorted plans based on subscriptionDate
      setState(() {
        plans = querySnapshot.docs;
        plans.sort((a, b) {
          return isDateSortUp
              ? a['createdAt'].compareTo(b['createdAt'])
              : b['createdAt'].compareTo(a['createdAt']);
        });
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Log the error and return an error stream
      print('Error fetching plans: $e');
    }
  }

  void toggleDateSort() {
    setState(() {
      isDateSortUp = !isDateSortUp;
      plans.sort((a, b) {
        return isDateSortUp
            ? a['createdAt'].compareTo(b['createdAt'])
            : b['createdAt'].compareTo(a['createdAt']);
      });
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
                        const HeaderImage(),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ReturnBackButton(dir),
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
                            onPressed: () async {
                              if (!await tokenService.checkSubscription()) {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Palette.mainAppColorNavy,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            LocalizationService
                                                .translateFromGeneral(
                                                    'subscriptionRequired'),
                                            style: AppStyles.textCairo(
                                              14,
                                              Palette.mainAppColorWhite,
                                              FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 24),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              BuildIconButton(
                                                text: LocalizationService
                                                    .translateFromGeneral(
                                                        'watchAd'),
                                                fontSize: 14,
                                                icon: Icons.play_circle_outline,
                                                onPressed: () async {
                                                  Navigator.pop(
                                                      context); // Close bottom sheet
                                                  // Add your ad watching logic here
                                                  if (interstitialAd != null) {
                                                    interstitialAd!.show().then(
                                                        (shown) {
                                                      if (shown) {
                                                        setState(() {
                                                          // NOTE interstitial ad can be shown only once
                                                          this.interstitialAd =
                                                              null;

                                                          // NOTE load again
                                                          loadInterstitialAd();
                                                        });
                                                      }

                                                      Get.toNamed(
                                                          Routes.createPlan);
                                                    }).onError(
                                                        (error, stackTrace) {
                                                      debugPrint(
                                                          "Error showing Interstitial ad: $error");
                                                    });
                                                  } else {
                                                    Get.toNamed(
                                                        Routes.createPlan);
                                                  }
                                                },
                                                width: double.infinity,
                                                backgroundColor:
                                                    Palette.mainAppColorWhite,
                                                textColor:
                                                    Palette.mainAppColorNavy,
                                                iconColor:
                                                    Palette.mainAppColorNavy,
                                              ),
                                              const SizedBox(width: 12),
                                              BuildIconButton(
                                                text: LocalizationService
                                                    .translateFromGeneral(
                                                        'subscribe'),
                                                fontSize: 14,
                                                icon: Icons.star,
                                                onPressed: () =>
                                                    PaymentServices.submitPayment(),
                                                width: double.infinity,
                                                backgroundColor: Colors.amber,
                                                textColor:
                                                    Palette.mainAppColorNavy,
                                                iconColor:
                                                    Palette.mainAppColorNavy,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                return; // Stop the execution of the current function
                              }
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
                  const SizedBox(height: 12),
                  isBannerAdLoaded
                      ? SizedBox(
                          child: AdWidget(ad: bannerAd),
                          height: bannerAd.size.height.toDouble(),
                          width: bannerAd.size.width.toDouble(),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 12),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(), // Show loader
                        )
                      : plans.isEmpty
                          ? Center(
                              child: Text(
                              LocalizationService.translateFromGeneral(
                                  'noPlans'),
                              style: AppStyles.textCairo(14,
                                  Palette.mainAppColorWhite, FontWeight.w500),
                            ))
                          : Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24, 0, 24, 0),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children:
                                    plans.map((DocumentSnapshot document) {
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
                                          child: EditPlanScreen(
                                              planId: document.id)));
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

class CustomCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;
  final VoidCallback onPressedEdit;
  const CustomCard(
      {super.key,
      required this.title,
      required this.description,
      required this.icon,
      required this.onPressed,
      required this.onPressedEdit});

  @override
  State<CustomCard> createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  late String dir;

  @override
  void initState() {
    super.initState();
    setState(() {
      dir = LocalizationService.getDir();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressedEdit,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Palette.mainAppColorWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: dir == 'rtl'
                    ? const EdgeInsets.fromLTRB(4, 6, 16, 6)
                    : const EdgeInsets.fromLTRB(16, 6, 4, 6),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.directions_bike,
                        color: Palette.mainAppColorNavy, size: 30),
                    SizedBox(width: 16),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title.length > 25
                              ? '${widget.title.substring(0, 25)}...'
                              : widget.title,
                          style: AppStyles.textCairo(
                            14,
                            Palette.black,
                            FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.description.length > 25
                              ? '${widget.description.substring(0, 25)}...'
                              : widget.description,
                          style: AppStyles.textCairo(
                            10,
                            Palette.secondaryColor,
                            FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    const Icon(
                      Icons.edit_note,
                      color: Palette.mainAppColorNavy,
                      size: 32,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Palette.redDelete,
                        size: 28,
                      ),
                      onPressed: widget.onPressed,
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
