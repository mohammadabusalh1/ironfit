import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ironfit/core/models/notification_item.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/exersiceCarousel.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:lottie/lottie.dart';
import 'package:ironfit/core/services/notification_service.dart';

String trainerName = '';
String trainerEmail = '';
String trainerImage = '';
bool isBannerAdLoaded = false;

class TrainerDashboardBody extends StatefulWidget {
  const TrainerDashboardBody({super.key});

  @override
  _TrainerDashboardBodyState createState() => _TrainerDashboardBodyState();
}

class _TrainerDashboardBodyState extends State<TrainerDashboardBody> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, String>> exercises = [];

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  bool isDataLoaded = false;

  late BannerAd bannerAd;
  late String dir;

  List<NotificationItem> notifications = [
    NotificationItem(
      title: LocalizationService.translateFromGeneral('workoutTime'),
      message: LocalizationService.translateFromGeneral('timeToWorkout'),
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    bannerAd = BannerAd(
        adUnitId: 'ca-app-pub-2914276526243261/1838418242',
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
    _fetchTrainerData();
    if (!isDataLoaded) {
      _showExerciseNotification();
      _fetchTrainerNameAndImage();
      setState(() {
        isDataLoaded = true;
      });
    }
    dir = LocalizationService.getDir();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  Future<void> _fetchTrainerNameAndImage() async {
    try {
      User? user = _auth.currentUser;

      // Check if user is authenticated
      if (user == null) {
        print('User is not logged in');
        return;
      }

      // Fetch user document from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('trainees').doc(user.uid).get();

      // Check if user document exists
      if (!userDoc.exists) {
        print('User document does not exist');
        return;
      }

      // Fetch user details with null safety checks
      setState(() {
        trainerName =
            '${userDoc['firstName'] ?? 'لا يوجد'} ${userDoc['lastName'] ?? 'لا يوجد'}';
        trainerEmail = userDoc['email'] ?? 'البريد الإلكتروني';
        trainerImage = userDoc['profileImageUrl'] ??
            'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg';
      });
    } catch (e) {
      // Handle any errors that occur during the Firestore operation
      print('Error fetching trainer details: $e');
      // You might want to show a snackbar, toast, or other UI feedback for the user here
    }
  }

  // Fetch trainer data from Firebase
  Future<void> _fetchTrainerData() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        print('User is not logged in');
        return;
      }

      // Fetch user document from Firestore
      QuerySnapshot<Map<String, dynamic>> subDoc = await _firestore
          .collection('subscriptions')
          .where('isActive', isEqualTo: true)
          .where(
            'userId',
            isEqualTo: user.uid,
          )
          .get();
      // Get the current day of the week
      DateTime now = DateTime.now();
      List<String> weekdays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];

      QuerySnapshot<Map<String, dynamic>> paln = await _firestore
          .collection('plans')
          .where('name', isEqualTo: subDoc.docs.first['plan'])
          .where('coachId', isEqualTo: subDoc.docs.first['coachId'])
          .get();

      Map<String, dynamic> palnDoc = paln.docs.first.data();

      // Safely fetch today's exercises
      var dynamicExercises =
          palnDoc['trainingDays'][weekdays[now.weekday - 1]] ?? [];

      // Check if dynamicExercises is a List before processing it
      if (dynamicExercises is List) {
        setState(() {
          exercises = dynamicExercises.map((exercise) {
            if (exercise is Map) {
              // Safely convert the exercise from dynamic to String
              return exercise.map(
                  (key, value) => MapEntry(key.toString(), value.toString()));
            }
            return <String,
                String>{}; // Return an empty map if the structure doesn't match
          }).toList();
        });
      } else {
        print("Error: Expected a list of exercises but got something else.");
      }
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.message}');
      // Optionally, show a snackbar or an alert to notify the user
      // ShowSnackbar or use other Flutter UI components for user-friendly error messages
    } catch (e) {
      print('Error fetching user data: $e');
      // You can log this error to a logging system or crash reporting service like Firebase Crashlytics
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 8),
            _buildDashboardHeader(context),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDashboardImage(context),
                    const SizedBox(height: 12),
                    isBannerAdLoaded
                        ? SizedBox(
                            child: AdWidget(ad: bannerAd),
                            height: bannerAd.size.height.toDouble(),
                            width: bannerAd.size.width.toDouble(),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 24),
                    _buildTodayExercisesButton(),
                    const SizedBox(height: 12),
                    ExerciseCarousel(
                      exercises: exercises,
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

  Widget _buildDashboardHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Palette.blackBack,
        boxShadow: [
          BoxShadow(
            color: Palette.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                trainerImage.isEmpty ? Assets.notFound : trainerImage),
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocalizationService.translateFromGeneral('welcomeBack')}',
                style: AppStyles.textCairo(
                  12,
                  Palette.mainAppColorWhite,
                  FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trainerName, // Replace with actual user name
                    style: AppStyles.textCairo(
                      18,
                      Palette.mainAppColor,
                      FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Lottie.asset(
                      'assets/jsonIcons/hi.json',
                      width: 10,
                      height: 10,
                    ),
                  ),
                ],
              ),
            ],
          )),
          InkWell(
            onTap: () => _showNotificationsDialog(context),
            child: Stack(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Lottie.asset(
                    'assets/jsonIcons/chat.json',
                    width: 10,
                    height: 10,
                  ),
                ),
                if (notifications.any((n) => !n.isRead))
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        notifications.where((n) => !n.isRead).length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDashboardImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Palette.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                Assets.dashboardYellow,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Palette.mainAppColorNavy.withOpacity(0.8),
                      Palette.mainAppColorNavy.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      LocalizationService.translateFromGeneral(
                          'yourFitnessJourney'),
                      style: AppStyles.textCairo(
                          20, Palette.mainAppColorWhite, FontWeight.bold),
                    ),
                    Text(
                      LocalizationService.translateFromGeneral(
                          'keepPushingYourLimits'),
                      style: AppStyles.textCairo(
                          12, Palette.mainAppColorWhite, FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodayExercisesButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: Palette.mainAppColorWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          LocalizationService.translateFromGeneral('todayExercises'),
          style: AppStyles.textCairo(
              16, Palette.mainAppColorNavy, FontWeight.bold),
        ),
      ),
    );
  }

  // Show immediate notification
  void _showExerciseNotification() {
    if (isDataLoaded) {
      NotificationService.showNotification(
        title: LocalizationService.translateFromGeneral('exerciseTime'),
        body: LocalizationService.translateFromGeneral('timeToWorkout'),
      );
    }
  }

  // Schedule workout notification
  void _scheduleWorkoutReminder() {
    // Schedule for tomorrow at 9 AM
    final tomorrow = DateTime.now();
    final scheduledTime = DateTime(
      tomorrow.year,
      tomorrow.month,
      tomorrow.day,
      9, // 9 AM
      41,
    );

    NotificationService.scheduleNotification(
      title: LocalizationService.translateFromGeneral('workoutReminder'),
      body: LocalizationService.translateFromGeneral('dontForgetWorkout'),
      scheduledDate: scheduledTime,
    );
  }

  // Example for exercise timer notification
  void _startExerciseTimer() {
    // Schedule notification for when timer ends
    final endTime = DateTime.now().add(const Duration(minutes: 1, seconds: 30));

    NotificationService.scheduleNotification(
      title: LocalizationService.translateFromGeneral('exerciseComplete'),
      body: LocalizationService.translateFromGeneral('greatJob'),
      scheduledDate: endTime,
    );
  }

  void _showNotificationsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Directionality(
              textDirection:
                  dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
              child: Dialog(
                backgroundColor: Palette.blackBack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocalizationService.translateFromGeneral(
                                'notifications'),
                            style: AppStyles.textCairo(
                              18,
                              Palette.mainAppColorWhite,
                              FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.close,
                              color: Palette.mainAppColorWhite,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Palette.gray),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.6,
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: notifications.length,
                          separatorBuilder: (context, index) => const Divider(
                            color: Palette.gray,
                            height: 1,
                          ),
                          itemBuilder: (context, index) {
                            final notification = notifications[index];
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  notification.isRead = true;
                                });
                                Navigator.pop(context);
                                // Handle notification tap
                              },
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: notification.isRead
                                      ? Palette.gray.withOpacity(0.2)
                                      : Palette.mainAppColorOrange
                                          .withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.notifications,
                                  color: notification.isRead
                                      ? Palette.gray
                                      : Palette.mainAppColorOrange,
                                ),
                              ),
                              title: Text(
                                notification.title,
                                style: AppStyles.textCairo(
                                  14,
                                  notification.isRead
                                      ? Palette.gray
                                      : Palette.mainAppColorWhite,
                                  FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification.message,
                                    style: AppStyles.textCairo(
                                      12,
                                      notification.isRead
                                          ? Palette.gray
                                          : Palette.mainAppColorWhite,
                                      FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    _formatNotificationTime(notification.time),
                                    style: AppStyles.textCairo(
                                      10,
                                      Palette.gray,
                                      FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: !notification.isRead
                                  ? Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Palette.mainAppColorOrange,
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                  : null,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  String _formatNotificationTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${LocalizationService.translateFromGeneral('minutesAgo')}';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${LocalizationService.translateFromGeneral('hoursAgo')}';
    } else {
      return '${difference.inDays} ${LocalizationService.translateFromGeneral('daysAgo')}';
    }
  }
}
