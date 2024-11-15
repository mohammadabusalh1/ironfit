import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/DaysTabBar.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

class UserMyPlanBody extends StatefulWidget {
  const UserMyPlanBody({super.key});

  @override
  _UserMyPlanBodyState createState() => _UserMyPlanBodyState();
}

class _UserMyPlanBodyState extends State<UserMyPlanBody> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Map<String, dynamic> plan;

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();

  late BannerAd bannerAd;
  bool isBannerAdLoaded = false;
  String dir = LocalizationService.getDir();

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    bannerAd = BannerAd(
        adUnitId: 'ca-app-pub-2914276526243261/3712377319',
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
    plan = {};
    _fetchPlan();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  Future<void> _fetchPlan() async {
    try {
      User? user = _auth.currentUser; // Fetch current user
      if (user != null) {
        QuerySnapshot<Map<String, dynamic>> subscription = await _firestore
            .collection('subscriptions')
            .where('userId', isEqualTo: user.uid)
            .where('isActive', isEqualTo: true)
            .limit(1)
            .get();

        if (subscription.docs.isEmpty) {
          return; // Exit the method if no matching documents are found
        }

        String planName = subscription.docs.first.data()['plan'] ?? '';

        QuerySnapshot<Map<String, dynamic>> planDoc = await _firestore
            .collection('plans')
            .where('coachId',
                isEqualTo: subscription.docs.first.data()['coachId'])
            .where('name', isEqualTo: planName)
            .limit(1)
            .get();

        // Fetch user details and exercises
        setState(() {
          plan = planDoc.docs.first.data() as Map<String, dynamic>? ?? {};
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),
            isBannerAdLoaded
                ? SizedBox(
                    child: AdWidget(ad: bannerAd),
                    height: bannerAd.size.height.toDouble(),
                    width: bannerAd.size.width.toDouble(),
                  )
                : const SizedBox(),
            const SizedBox(height: 12),
            CustomTabBarWidget(plan: plan),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(context) {
  String dir = LocalizationService.getDir();
  return Directionality(
    textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
    child: SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          const HeaderImage(),
          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReturnBackButton(dir),
                const SizedBox(width: 12),
                Opacity(
                  opacity: 0.8,
                  child: Text(
                    LocalizationService.translateFromGeneral('my_plan'),
                    style: AppStyles.textCairo(
                        20, Palette.mainAppColorWhite, FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
