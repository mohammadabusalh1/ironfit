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
import 'package:ironfit/features/Trainee/screens/trainee_screen.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';

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

  String dir = LocalizationService.getDir();

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    _scrollController.addListener(_scrollListener);
    fetchTrainees();
  }

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildActionButtons(),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BuildTextField(
                onChange: _filterTrainees,
                label: LocalizationService.translateFromGeneral('search'),
              ),
            ),
            if (_isLoading)
              const SizedBox(height: 24), // Changed to conditional statement
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              _buildTraineesList(),
            const SizedBox(height: 24),
          ],
        ),
        Positioned(
          bottom: 24,
          right: 12,
          child: BuildIconButton(
              onPressed: () => showAddTraineeDialog(context),
              icon: Icons.add,
              iconSize: 20,
              backgroundColor: Palette.mainAppColor,
              textColor: Palette.black,
              width: 50,
              height: 50,
              iconColor: Palette.black),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return SizedBox(
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
                ReturnBackButton(),
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

  Widget _buildTraineesList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: filtteredTrainees.isEmpty
            ? Center(
                child: Text(
                  LocalizationService.translateFromGeneral('noData'),
                  style: AppStyles.textCairo(
                    16,
                    Palette.mainAppColorWhite,
                    FontWeight.w500,
                  ),
                ),
              )
            : ListView.builder(
                controller: _scrollController,
                itemCount: _itemCount < filtteredTrainees.length
                    ? _itemCount
                    : filtteredTrainees.length,
                itemBuilder: (context, index) {
                  var trainee = filtteredTrainees[index];
                  if (index >= filtteredTrainees.length) {
                    return const SizedBox.shrink();
                  }
                  return _buildTraineeCard(
                    context,
                    trainee['fullName'] ??
                        trainee['username'] ??
                        LocalizationService.translateFromGeneral(
                            'unknown'), // Default name if fullName is null
                    trainee['endDate'] != null &&
                            DateTime.tryParse(trainee['endDate']) != null
                        ? (DateTime.parse(trainee['endDate'])
                                    .millisecondsSinceEpoch >
                                DateTime.now().millisecondsSinceEpoch
                            ? LocalizationService.translateFromGeneral(
                                'currently_subscribed')
                            : LocalizationService.translateFromGeneral(
                                'not_subscribed'))
                        : LocalizationService.translateFromGeneral(
                            'unknown'), // Default status if endDate is null or cannot be parsed
                    trainee['profileImageUrl'] ??
                        'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg', // Default image if profileImageUrl is null
                    () => Get.to(Directionality(
                        textDirection: dir == 'rtl'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: TraineeScreen(
                          username: trainee['username'] ??
                              LocalizationService.translateFromGeneral(
                                  'unknown'), // Default username if null
                          fetchTrainees: fetchTrainees,
                        ))),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildTraineeCard(BuildContext context, String name, String status,
      String imagePath, VoidCallback onTap) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Palette.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                        imagePath.isEmpty ? Assets.notFound : imagePath,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppStyles.textCairo(
                          14,
                          Palette.mainAppColor,
                          FontWeight.bold,
                        ),
                      ),
                      Text(
                        status,
                        style: AppStyles.textCairo(
                          10,
                          Palette.gray,
                          FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward, color: Palette.white, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _sortByName() {
    setState(() {
      filtteredTrainees.sort((a, b) => isNameSortUp
          ? a.containsKey('fullName')
              ? a['fullName'].compareTo(b['fullName'])
              : a['username'].compareTo(b['username'])
          : b.containsKey('fullName')
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

      // Safely update the state
      setState(() {
        filtteredTrainees =
            trainees = subscriptions.docs.map((doc) => doc.data()).toList();
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
                          .where('coachId', isEqualTo: coach?.uid)
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

                        final subscriptionDocRef = coachDocRef.doc();
                        batch.set(subscriptionDocRef, {
                          'username': username,
                          'startDate': startDate,
                          'endDate': endDate,
                          'amountPaid': amountPaid,
                          'totalAmountPaid': amountPaid,
                          'debts': debts,
                          'userId': username,
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

                      // Commit batch write
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
