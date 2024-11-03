import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    plan = {};
    _fetchPlan();
  }

  Future<void> _fetchPlan() async {
    try {
      User? user = _auth.currentUser; // Fetch current user
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('trainees').doc(user.uid).get();

        String planId = userDoc['planId'] ?? '';
        String coachId = userDoc['coachId'] ?? '';

        DocumentSnapshot PalnDoc = await _firestore
            .collection('coaches')
            .doc(coachId)
            .collection('plans')
            .doc(planId)
            .get();

        // Fetch user details and exercises
        setState(() {
          plan = PalnDoc.data() as Map<String, dynamic>? ?? {};
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
            SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  const Align(
                    alignment: AlignmentDirectional(0, -1),
                    child: HeaderImage(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        24,
                        MediaQuery.of(context).size.height * 0.08,
                        24,
                        MediaQuery.of(context).size.height * 0.08),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Opacity(
                          opacity: 0.9,
                          child: Text(
                            LocalizationService.translateFromGeneral('my_plan'),
                            style: AppStyles.textCairo(
                              20,
                              Palette.mainAppColorWhite,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ReturnBackButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomTabBarWidget(plan: plan),
          ],
        ),
      ),
    );
  }
}
