import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/theme.dart';
import 'package:ironfit/core/services/paymentServices.dart';
import 'package:ironfit/features/Trainee/screens/trainee_screen.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
import 'package:lottie/lottie.dart';
import 'package:startapp_sdk/startapp.dart';

class TraineesBody extends StatefulWidget {
  const TraineesBody({super.key});

  @override
  _TraineesBodyState createState() => _TraineesBodyState();
}

class _TraineesBodyState extends State<TraineesBody> {
  List<Map<String, dynamic>> trainees = [];
  List<Map<String, dynamic>> filtteredTrainees = [];
  int _itemCount = 10;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  bool isNameSortUp = true;
  bool isSubscriptionSortUp = true;
  User? coach = FirebaseAuth.instance.currentUser;

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();

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
    _scrollController.addListener(_scrollListener);
    fetchTrainees();
    dir = LocalizationService.getDir();
    loadInterstitialAd();
  }

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildActionButtons(),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: BuildTextField(
                    dir: dir,
                    onChange: _filterTrainees,
                    label: LocalizationService.translateFromGeneral('search'),
                  ),
                ),
                const SizedBox(height: 24),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: (_itemCount < filtteredTrainees.length)
                          ? (_itemCount ~/ 2) + 1
                          : (filtteredTrainees.length ~/ 2) + 1,
                      itemBuilder: (context, index) {
                        int startIndex = index * 2;
                        int endIndex = startIndex + 2;
                        if (startIndex >= filtteredTrainees.length) {
                          return const SizedBox.shrink();
                        }
                        if (endIndex > filtteredTrainees.length) {
                          endIndex = filtteredTrainees.length;
                        }
                        List<Widget> cards = [];
                        for (int i = startIndex; i < endIndex; i++) {
                          var trainee = filtteredTrainees[i];
                          cards.add(
                            _buildTraineeCard(
                              context,
                              trainee['fullName'] ??
                                  trainee['username'] ??
                                  LocalizationService.translateFromGeneral(
                                      'unknown'),
                              trainee['endDate'] != null &&
                                      DateTime.tryParse(trainee['endDate']) !=
                                          null
                                  ? (DateTime.parse(trainee['endDate'])
                                              .millisecondsSinceEpoch >
                                          DateTime.now().millisecondsSinceEpoch
                                      ? LocalizationService
                                          .translateFromGeneral(
                                              'currently_subscribed')
                                      : LocalizationService
                                          .translateFromGeneral(
                                              'not_subscribed'))
                                  : LocalizationService.translateFromGeneral(
                                      'unknown'),
                              trainee['profileImageUrl'] ?? Assets.notFound,
                              () => Get.to(Directionality(
                                textDirection: dir == 'rtl'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: TraineeScreen(
                                  username: trainee['username'] ??
                                      LocalizationService.translateFromGeneral(
                                          'unknown'),
                                  fetchTrainees: fetchTrainees,
                                ),
                              )),
                            ),
                          );
                        }
                        return Column(
                          children: cards,
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            left: 12,
            right: 12,
            child: InkWell(
              onTap: () async {
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
                              LocalizationService.translateFromGeneral(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BuildIconButton(
                                  text:
                                      LocalizationService.translateFromGeneral(
                                          'watchAd'),
                                  fontSize: 14,
                                  icon: Icons.play_circle_outline,
                                  onPressed: () async {
                                    Navigator.pop(
                                        context); // Close bottom sheet
                                    // Add your ad watching logic here
                                    if (interstitialAd != null) {
                                      interstitialAd!.show().then((shown) {
                                        if (shown) {
                                          setState(() {
                                            // NOTE interstitial ad can be shown only once
                                            this.interstitialAd = null;

                                            // NOTE load again
                                            loadInterstitialAd();
                                          });
                                        }

                                        showAddTraineeDialog(context);
                                      }).onError((error, stackTrace) {
                                        debugPrint(
                                            "Error showing Interstitial ad: $error");
                                      });
                                    } else {
                                      showAddTraineeDialog(context);
                                    }
                                  },
                                  width: double.infinity,
                                  backgroundColor: Palette.mainAppColorWhite,
                                  textColor: Palette.mainAppColorNavy,
                                  iconColor: Palette.mainAppColorNavy,
                                ),
                                const SizedBox(width: 12),
                                BuildIconButton(
                                  text:
                                      LocalizationService.translateFromGeneral(
                                          'subscribe'),
                                  fontSize: 14,
                                  icon: Icons.star,
                                  onPressed: () => PaymentServices.submitPayment(),
                                  width: double.infinity,
                                  backgroundColor: Colors.amber,
                                  textColor: Palette.mainAppColorNavy,
                                  iconColor: Palette.mainAppColorNavy,
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
              child: SizedBox(
                width: 70,
                height: 70,
                child: Lottie.asset(
                  'assets/jsonIcons/add.json',
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          const HeaderImage(),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReturnBackButton(dir),
                const SizedBox(width: 12),
                _buildHeaderTitle(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderTitle() {
    return Opacity(
      opacity: 0.8,
      child: Text(
        LocalizationService.translateFromGeneral('trainees'),
        style:
            AppStyles.textCairo(20, Palette.mainAppColorWhite, FontWeight.bold),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          BuildIconButton(
            fontSize: 12,
            text: LocalizationService.translateFromGeneral('name'),
            icon: isNameSortUp ? Icons.north_rounded : Icons.south_rounded,
            onPressed: () {
              _sortByName();
            },
            iconSize: 18,
            width: Get.width * 0.415,
            iconColor: Palette.mainAppColorNavy,
            height: 50,
            backgroundColor: Palette.mainAppColorWhite,
            textColor: Palette.mainAppColorNavy,
          ),
          const SizedBox(width: 12),
          BuildIconButton(
            fontSize: 12,
            text: LocalizationService.translateFromGeneral('subscription'),
            icon: isSubscriptionSortUp ? Icons.add : Icons.minimize,
            onPressed: () {
              _sortBySubscription();
              toggleSubscriptionSort();
            },
            iconSize: 18,
            width: Get.width * 0.415,
            iconColor: Palette.mainAppColorNavy,
            height: 50,
            backgroundColor: Palette.mainAppColorWhite,
            textColor: Palette.mainAppColorNavy,
          ),
        ],
      ),
    );
  }

  Widget _buildTraineeCard(BuildContext context, String name, String status,
      String imagePath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    imagePath.isEmpty ? Assets.notFound : imagePath),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.length > 15 ? '${name.substring(0, 15)}...' : name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status.length > 15
                          ? '${status.substring(0, 15)}...'
                          : status,
                      style: AppStyles.textCairo(
                        12,
                        status ==
                                LocalizationService.translateFromGeneral(
                                    'currently_subscribed')
                            ? Palette.mainAppColorNavy
                            : Colors.grey,
                        FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                status ==
                        LocalizationService.translateFromGeneral(
                            'currently_subscribed')
                    ? Icons.star
                    : Icons.star_border,
                color: status ==
                        LocalizationService.translateFromGeneral(
                            'currently_subscribed')
                    ? Colors.amber
                    : Palette.gray,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sortByName() {
    print(filtteredTrainees);
    setState(() {
      filtteredTrainees.sort((a, b) => isNameSortUp
          ? a.containsKey('fullName') && b.containsKey('fullName')
              ? a['fullName'].compareTo(b['fullName'])
              : a['username'].compareTo(b['username'])
          : b.containsKey('fullName') && a.containsKey('fullName')
              ? b['fullName'].compareTo(a['fullName'])
              : b['username'].compareTo(a['username']));
      isNameSortUp = !isNameSortUp;
    });
  }

  void _sortBySubscription() {
    DateTime now = DateTime.now();
    if (isSubscriptionSortUp) {
      setState(() {
        filtteredTrainees = trainees
            .where((a) =>
                DateTime.parse(a['endDate']).isBefore(now) ||
                DateTime.parse(a['endDate']).isAtSameMomentAs(now))
            .toList();
      });
    } else {
      setState(() {
        filtteredTrainees = trainees;
      });
    }
  }

  Future<void> fetchTrainees() async {
    try {
      setState(() {
        _isLoading = true; // Set loading to true
      });
      if (coach == null) {
        throw Exception("Coach ID is null.");
      }

      // Fetch the coach's subscription data
      var subscriptions = await FirebaseFirestore.instance
          .collection('subscriptions')
          .where('coachId', isEqualTo: coach!.uid)
          .where('isActive', isEqualTo: true)
          .get();

      // Ensure there is data to process
      if (subscriptions.docs.isEmpty) {
        throw Exception("No trainees found for coach.");
      }

      // Fetch user IDs from the subscription documents
      final userIds = subscriptions.docs.map((doc) => doc['userId']).toList();

      final traineeDocs = await FirebaseFirestore.instance
          .collection('trainees')
          .where(FieldPath.documentId, whereIn: userIds)
          .get();

      // Safely update the state
      setState(() {
        trainees = filtteredTrainees = subscriptions.docs.map((doc) {
          try {
            // Find the corresponding trainee data
            final user = traineeDocs.docs.firstWhere(
              (traineeDoc) => traineeDoc.id == doc['userId'],
            );

            return {
              ...doc.data(),
              'fullName': user.data().containsKey('firstName')
                  ? '${user.data()['firstName'] ?? ''} ${user.data()['lastName'] ?? ''}'
                  : user.data()['username'],
              'age': user.data()[
                  'age'], // Assuming 'age' field exists in trainee documents
              'profileImageUrl': user.data()[
                  'profileImageUrl'], // Assuming 'profileImageUrl' field exists
            };
          } catch (e) {
            // Handle specific errors or log them
            print('Error processing document: $e');
            // Return a default value or handle the error case
            return doc.data(); // or null or a default map with error info
          }
        }).toList();
      });
    } catch (e) {
      // Handle errors here (e.g., log to console or display a message)
      print("Error fetching trainees: $e");
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false after operation
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
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

  void showAddTraineeDialog(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
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
            child: AlertDialog(
              title: Text(
                  textDirection:
                      dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                  LocalizationService.translateFromGeneral('addNewTrainee'),
                  style: AppStyles.textCairo(
                      24, Palette.mainAppColorWhite, FontWeight.bold)),
              content: Form(
                key: _formKey, // Use the form key for validation
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: dir == 'rtl'
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  mainAxisAlignment: dir == 'rtl'
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                        textDirection: dir == 'rtl'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        LocalizationService.translateFromGeneral(
                            'pleaseFillRequiredData'),
                        style: AppStyles.textCairo(
                            14, Palette.gray, FontWeight.w500)),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildTextField(
                          dir: dir,
                          icon: Icons.person,
                          onChange: (value) {
                            setState(() {
                              usernameController.text = value;
                            });
                          },
                          controller: usernameController,
                          label: LocalizationService.translateFromGeneral(
                              'usernameLabel'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationService.translateFromGeneral(
                                  'thisFieldRequired');
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp(r'\s')), // Deny spaces
                          ],
                        ),
                        const SizedBox(
                            height: 8), // Add spacing between field and note
                        Text(
                          textDirection: dir == 'rtl'
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          LocalizationService.translateFromGeneral(
                              'addTraineeNote'),
                          style: AppStyles.textCairo(
                              12, Palette.gray, FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    BuildTextField(
                      dir: dir,
                      icon: Icons.date_range,
                      controller: startDateController,
                      label:
                          LocalizationService.translateFromGeneral('startDate'),
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
                      dir: dir,
                      icon: Icons.date_range,
                      onChange: (value) {
                        setState(() {
                          endDateController.text = value;
                        });
                      },
                      controller: endDateController,
                      label:
                          LocalizationService.translateFromGeneral('endDate'),
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
                      dir: dir,
                      icon: Icons.attach_money_outlined,
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
                      dir: dir,
                      icon: Icons.money_off,
                      onChange: (value) {
                        debtsController.text = value;
                      },
                      controller: debtsController,
                      keyboardType: TextInputType.number,
                      label: LocalizationService.translateFromGeneral('debts'),
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
                      // Show loading dialog
                      Get.dialog(
                        const Center(child: CircularProgressIndicator()),
                        barrierDismissible: false,
                      );
                      String username = usernameController.text.trim();
                      String startDate = startDateController.text.trim();
                      String endDate = endDateController.text.trim();
                      String amountPaid = amountPaidController.text.trim();
                      String debts = debtsController.text.trim();

                      final batch = FirebaseFirestore.instance.batch();

                      var userSubscribed = await FirebaseFirestore.instance
                          .collection('subscriptions')
                          .where('username', isEqualTo: username)
                          .where('isActive', isEqualTo: true)
                          .limit(1)
                          .get();

                      var userSubscribedNotActive = await FirebaseFirestore
                          .instance
                          .collection('subscriptions')
                          .where('username', isEqualTo: username)
                          .where('coachId', isEqualTo: coach?.uid)
                          .where('isActive', isEqualTo: false)
                          .limit(1)
                          .get();

                      // Trainee exists: Update existing trainee with new subscription details
                      if (userSubscribed.docs.isNotEmpty) {
                        if (userSubscribed.docs.first.exists) {
                          customSnackbar.showMessageAbove(
                            context,
                            LocalizationService.translateFromGeneral(
                                'traineeExist'),
                          );
                        }
                        Navigator.of(context).pop();
                      } else if (userSubscribedNotActive.docs.isNotEmpty) {
                        if (userSubscribedNotActive.docs.first.exists) {
                          userSubscribedNotActive.docs.first.reference.update({
                            'isActive': true,
                            'startDate': startDate,
                            'endDate': endDate,
                            'amountPaid': amountPaid,
                            'totalAmountPaid': amountPaid,
                            'debts': debts,
                          });

                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          customSnackbar.showMessage(
                              context,
                              LocalizationService.translateFromPage(
                                  'message', 'snackbarSuccess'));
                        }
                      } else {
                        // Define coach and trainee collections
                        final coachDocRef = FirebaseFirestore.instance
                            .collection('subscriptions');

                        var user = await FirebaseFirestore.instance
                            .collection('trainees')
                            .where('username', isEqualTo: username)
                            .get();

                        final subscriptionDocRef = coachDocRef.doc();
                        batch.set(subscriptionDocRef, {
                          'username': username,
                          'startDate': startDate,
                          'endDate': endDate,
                          'amountPaid': amountPaid,
                          'totalAmountPaid': amountPaid,
                          'debts': debts,
                          'userId':
                              user.docs.length > 0 ? user.docs[0].id : username,
                          'coachId': coach?.uid,
                          "isActive": true,
                        });

                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        customSnackbar.showMessage(
                            context,
                            LocalizationService.translateFromPage(
                                'message', 'snackbarSuccess'));
                      }
                      await batch.commit();
                      await fetchTrainees();
                    }
                  },
                  width: Get.width * 0.25,
                  fontSize: 14,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    LocalizationService.translateFromGeneral('cancel'),
                  ),
                ),
              ],
              actionsAlignment: dir == 'rtl'
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
            ),
          ),
        );
      },
    );
  }

  void _filterTrainees(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        fetchTrainees(); // Reset list if search is empty
      } else {
        filtteredTrainees = trainees.where((trainee) {
          final name = trainee.containsKey('fullName')
              ? trainee['fullName'].toLowerCase()
              : trainee['username'].toLowerCase();
          return name.contains(searchTerm.toLowerCase());
        }).toList();
      }
      _itemCount = 10;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        // Increase itemCount only if it's less than the filteredTrainees list
        if (_itemCount < filtteredTrainees.length) {
          _itemCount += 10;
        }
      });
    }
  }

  void toggleSubscriptionSort() {
    setState(() {
      isSubscriptionSortUp = !isSubscriptionSortUp;
    });
  }
}
