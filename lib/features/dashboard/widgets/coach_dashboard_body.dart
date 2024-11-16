import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/PagesHeader.dart';
import 'package:ironfit/core/presentation/widgets/StatisticsCard.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/features/dashboard/widgets/card_widget.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:startapp_sdk/startapp.dart';

String imageUrl = Assets.notFound;

class CoachDashboardBody extends StatefulWidget {
  const CoachDashboardBody({Key? key}) : super(key: key);

  @override
  CoachDashboardState createState() => CoachDashboardState();
}

class CoachDashboardState extends State<CoachDashboardBody> {
  late BannerAd bannerAd;
  bool isBannerAdLoaded = false;
  TokenService tokenService = TokenService();
  late String fullName = LocalizationService.translateFromGeneral('noData');
  late String email = LocalizationService.translateFromGeneral('noData');
  late Map<String, dynamic> data = {
    'trainees': '0',
    'subscriptions': '0',
  };

  // InterstitialAd? _interstitialAd;

  // void loadAd() {
  //   InterstitialAd.load(
  //       adUnitId: 'ca-app-pub-2914276526243261/1514461526',
  //       request: const AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         // Called when an ad is successfully received.
  //         onAdLoaded: (ad) {
  //           ad.fullScreenContentCallback = FullScreenContentCallback(
  //               // Called when the ad showed the full screen content.
  //               onAdShowedFullScreenContent: (ad) {},
  //               // Called when an impression occurs on the ad.
  //               onAdImpression: (ad) {},
  //               // Called when the ad failed to show full screen content.
  //               onAdFailedToShowFullScreenContent: (ad, err) {
  //                 // Dispose the ad here to free resources.
  //                 ad.dispose();
  //               },
  //               // Called when the ad dismissed full screen content.
  //               onAdDismissedFullScreenContent: (ad) {
  //                 // Dispose the ad here to free resources.
  //                 ad.dispose();
  //               },
  //               // Called when a click is recorded for an ad.
  //               onAdClicked: (ad) {});

  //           debugPrint('$ad loaded.');
  //           // Keep a reference to the ad so you can show it later.
  //           _interstitialAd = ad;
  //         },
  //         // Called when an ad request failed.
  //         onAdFailedToLoad: (LoadAdError error) {
  //           debugPrint('InterstitialAd failed to load: $error');
  //         },
  //       ));
  // }

  // var startAppSdk = StartAppSdk();
  // StartAppInterstitialAd? interstitialAd;

  @override
  void initState() {
    super.initState();
    // startAppSdk.setTestAdsEnabled(true);
    fetchInitialData();
    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-2914276526243261/9874590860',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    bannerAd.load();
    tokenService.checkTokenAndNavigateSingIn();
    // loadAd();
    
    // loadInterstitialAd();
  }

  // void loadInterstitialAd() {
  //   startAppSdk.loadInterstitialAd().then((interstitialAd) {
  //     setState(() {
  //       this.interstitialAd = interstitialAd;
  //     });
  //   }).onError<StartAppException>((ex, stackTrace) {
  //     debugPrint("Error loading Interstitial ad: ${ex.message}");
  //   }).onError((error, stackTrace) {
  //     debugPrint("Error loading Interstitial ad: $error");
  //   });
  // }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  Future<void> fetchInitialData() async {
    try {
      await fetchStatisticsData();
      // Fetch user profile data
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('coaches')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userDoc.exists) {
        String? firstName = userDoc['firstName'];

        setState(() {
          fullName = '$firstName';
          email = userDoc['email'];
          imageUrl = userDoc['profileImageUrl'];
        });
      } else {
        print(
            "User data not found for coach ID: ${FirebaseAuth.instance.currentUser!.uid}");
      }
    } catch (e) {
      print("Error fetching initial data: $e");
    }
  }

  Future<void> fetchStatisticsData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> subscriptions =
          await FirebaseFirestore.instance
              .collection('subscriptions')
              .where('coachId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where('isActive', isEqualTo: true)
              .get();

      DateTime thisMonthDate =
          DateTime.now().subtract(Duration(days: DateTime.now().day - 1));
      DateTime previousMonthDate =
          thisMonthDate.subtract(const Duration(days: 30));

      List<QueryDocumentSnapshot<Map<String, dynamic>>> currentMonthFillter =
          subscriptions.docs.where((element) {
        DateTime startDate = DateTime.parse(element.data()['startDate']);
        return startDate.month == thisMonthDate.month;
      }).toList();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> previousMonthFillter =
          subscriptions.docs.where((element) {
        DateTime startDate = DateTime.parse(element.data()['startDate']);
        return startDate.month == previousMonthDate.month;
      }).toList();

      int currentMonthTrainees = currentMonthFillter.length;
      int previousMonthTrainees = previousMonthFillter.length;

      if (previousMonthTrainees == 0 && currentMonthTrainees > 0) {
        setState(() {
          data = {
            'trainees': subscriptions.size,
            'subscriptions': 100,
          };
        });
      }

      double percentageDifference = previousMonthTrainees != 0
          ? ((currentMonthTrainees - previousMonthTrainees) /
                  previousMonthTrainees) *
              100
          : currentMonthTrainees != 0
              ? 100
              : 0;

      setState(() {
        data = {
          'trainees': subscriptions.size,
          'subscriptions': percentageDifference,
        };
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 48),
            DashboardHeader(
              trainerImage: imageUrl.isEmpty ? Assets.notFound : imageUrl,
            ),
            SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    '${LocalizationService.translateFromGeneral('hi')} ${fullName}',
                    style: AppStyles.textCairo(
                      26,
                      Palette.mainAppColorWhite.withOpacity(0.8),
                      FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Lottie.asset(
                      'assets/jsonIcons/hi.json',
                      width: 10,
                      height: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                textAlign: TextAlign.start,
                '${LocalizationService.translateFromPage('title', 'selectEnter')}',
                style: AppStyles.textCairo(
                  14,
                  Palette.mainAppColorWhite.withOpacity(0.6),
                  FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                _buildStatisticsRow(context, data),
                // ElevatedButton(
                //   onPressed: () {
                //     if (interstitialAd != null) {
                //       interstitialAd!.show().then((shown) {
                //         if (shown) {
                //           setState(() {
                //             // NOTE interstitial ad can be shown only once
                //             this.interstitialAd = null;

                //             // NOTE load again
                //             loadInterstitialAd();
                //           });
                //         }

                //         return null;
                //       }).onError((error, stackTrace) {
                //         debugPrint("Error showing Interstitial ad: $error");
                //       });
                //     }
                //   },
                //   child: Text('Show Interstitial'),
                // ),
                const SizedBox(height: 12),
                isBannerAdLoaded
                    ? SizedBox(
                        child: AdWidget(ad: bannerAd),
                        height: bannerAd.size.height.toDouble(),
                        width: bannerAd.size.width.toDouble(),
                      )
                    : const SizedBox(),
                const SizedBox(height: 12),
                CardWidget(
                  onTap: () => Get.toNamed(Routes.myGyms),
                  subtitle: LocalizationService.translateFromGeneral('myGyms'),
                  imagePath: Assets.myGymImage,
                  description:
                      LocalizationService.translateFromGeneral('addGymInfo'),
                ),
                const SizedBox(height: 24),
                CardWidget(
                  onTap: () => Get.toNamed(Routes.trainees),
                  subtitle:
                      LocalizationService.translateFromGeneral('trainees'),
                  imagePath: Assets.myTrainerImage,
                  description: LocalizationService.translateFromGeneral(
                      'addTraineeInfo'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsRow(BuildContext context, Map<String, dynamic> data) {
    return Row(
      children: [
        StatisticsCard(
          cardSubTitle:
              "${data['trainees']} ${LocalizationService.translateFromGeneral('trainee')}",
          cardTitle: LocalizationService.translateFromGeneral('trainees'),
          width: MediaQuery.of(context).size.width * 0.415,
          height: 90,
          icon: Icons.person,
          backgroundColor: Palette.mainAppColorOrange,
          textColor: Palette.mainAppColorWhite,
          cardTextColor: Palette.mainAppColorWhite,
          iconColor: Palette.mainAppColorWhite,
        ),
        const Spacer(),
        StatisticsCard(
          cardSubTitle: "${data['subscriptions']}+%",
          cardTitle: LocalizationService.translateFromGeneral('subscription'),
          width: MediaQuery.of(context).size.width * 0.415,
          height: 90,
          icon: Icons.percent_outlined,
          backgroundColor: Palette.mainAppColorWhite,
          textColor: Palette.mainAppColorNavy,
          cardTextColor: Palette.mainAppColorNavy,
        ),
      ],
    );
  }
}
