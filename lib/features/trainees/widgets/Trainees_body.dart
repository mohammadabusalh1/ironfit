import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/Trainee/screens/trainee_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TraineesBody extends StatefulWidget {
  @override
  _TraineesBodyState createState() => _TraineesBodyState();
}

class _TraineesBodyState extends State<TraineesBody> {
  List<Map<String, dynamic>> trainees = [];
  List<Map<String, dynamic>> filtteredTrainees = [];
  int _itemCount = 10;
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  bool isNameSortUp = true;
  bool isSubscriptionSortUp = true;
  User? coach = FirebaseAuth.instance.currentUser;

  PreferencesService preferencesService = PreferencesService();

  @override
  void initState() {
    super.initState();
    _checkToken();
    _scrollController.addListener(_scrollListener);
    fetchTrainees();
  }

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 12),
        _buildActionButtons(),
        const SizedBox(height: 12),
        _buildSearchField(context),
        if (_isLoading)
          const SizedBox(height: 24), // Changed to conditional statement
        if (_isLoading)
          Center(child: CircularProgressIndicator())
        else
          _buildTraineesList(),
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
                _buildBackButton(),
                const SizedBox(width: 12),
                _buildHeaderTitle(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return ElevatedButton(
      onPressed: () => Get.back(),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1C1503),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(8),
        elevation: 0,
      ),
      child: const Icon(Icons.arrow_left, color: Color(0xFFFFBB02), size: 24),
    );
  }

  Widget _buildHeaderTitle() {
    return Opacity(
      opacity: 0.8,
      child: Text(
        LocalizationService.translateFromGeneral('trainees'),
        style: TextStyle(
          fontFamily: 'Inter',
          color: Palette.white,
          fontSize: 20,
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
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(child: _buildAddButton()),
          const SizedBox(width: 12),
          Expanded(
              child: _buildSortButton(
                  LocalizationService.translateFromGeneral('name'),
                  isNameSortUp ? Icons.north_rounded : Icons.south_rounded, () {
            _sortByName();
          })),
          const SizedBox(width: 12),
          Expanded(
              child: _buildSortButton(
                  LocalizationService.translateFromGeneral('subscription'),
                  isSubscriptionSortUp ? Icons.add : Icons.minimize, () {
            _sortBySubscription();
            toggleSubscriptionSort();
          })),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton.icon(
      onPressed: () => showAddTraineeDialog(context),
      icon: const Icon(Icons.add, size: 22),
      label: const Text(''),
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF1C1503),
        backgroundColor: const Color(0xFFFFBB02),
        padding: const EdgeInsetsDirectional.only(start: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }

  Widget _buildSortButton(String label, IconData icon, Function onPressed) {
    return ElevatedButton.icon(
      onPressed: () => onPressed(), // Invoke the passed sorting function
      icon: Icon(icon, size: 15),
      label: Text(label.length > 8 ? '${label.substring(0, 8)}...' : label),
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF1C1503),
        backgroundColor: Palette.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        onChanged:
            _filterTrainees, // Call the filter function on every input change
        decoration: InputDecoration(
          isDense: true,
          hintText: LocalizationService.translateFromGeneral('search'),
          hintStyle: const TextStyle(fontFamily: 'Inter', fontSize: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(14),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(14),
          ),
          filled: true,
          fillColor: Palette.white,
        ),
        style: const TextStyle(fontFamily: 'Inter'),
        textAlign: TextAlign.start,
        cursorColor: Theme.of(context).primaryColor,
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
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Palette.white,
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
                        textDirection: TextDirection.rtl,
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
                    child: Image.network(imagePath,
                        width: 40, height: 40, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFFFFBB02),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        status,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0x93FFFFFF),
                          fontSize: 10,
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
          ? a['fullName'].compareTo(b['fullName'])
          : b['fullName'].compareTo(a['fullName']));
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
    setState(() {
      _isLoading = true; // Set loading to true
    });
    try {
      if (coach == null) {
        throw Exception("Coach ID is null.");
      }

      // Fetch the coach's subscription data
      var subscriptions = await FirebaseFirestore.instance
          .collection('coaches')
          .doc(coach?.uid)
          .collection('subscriptions')
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

  Future<void> _checkToken() async {
    SharedPreferences prefs = await preferencesService.getPreferences();
    String? token = prefs.getString('token');

    if (token == null) {
      Get.toNamed(Routes.singIn); // Navigate to coach dashboard
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
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.grey[900],
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
                backgroundColor: const Color(0xFFFFBB02),
                foregroundColor: const Color(0xFF1C1503),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Palette.secondaryColor,
              labelStyle: TextStyle(color: Palette.white, fontSize: 14),
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
              style: TextButton.styleFrom(foregroundColor: Palette.white),
            ),
          ),
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: Text(
                    LocalizationService.translateFromGeneral('addNewTrainee'),
                    style: TextStyle(
                        color: Palette.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
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
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              labelText:
                                  LocalizationService.translateFromGeneral(
                                      'usernameLabel'),
                              border: OutlineInputBorder(),
                              labelStyle:
                                  TextStyle(color: Palette.gray, fontSize: 14),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(
                                    10.0), // Adjust padding if needed
                                child: Icon(
                                  Icons.person_2_outlined,
                                  color: Palette.gray,
                                  size: 20,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LocalizationService.translateFromGeneral(
                                        'create_account') +
                                    ' ' +
                                    LocalizationService.translateFromGeneral(
                                        'usernameLabel');
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
                            LocalizationService.translateFromGeneral(
                                'addTraineeNote'),
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: startDateController,
                        decoration: InputDecoration(
                          labelText: LocalizationService.translateFromGeneral(
                              'startDate'),
                          labelStyle:
                              TextStyle(color: Palette.gray, fontSize: 14),
                          border: OutlineInputBorder(),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(
                                10.0), // Adjust padding if needed
                            child: Icon(
                              Icons.date_range_outlined,
                              color: Palette.gray,
                              size: 20,
                            ),
                          ),
                        ),
                        readOnly: true,
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
                      TextFormField(
                        controller: endDateController,
                        decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(
                                  10.0), // Adjust padding if needed
                              child: Icon(
                                Icons.date_range_outlined,
                                color: Palette.gray,
                                size: 20,
                              ),
                            ),
                            labelStyle:
                                TextStyle(color: Palette.gray, fontSize: 14),
                            labelText: LocalizationService.translateFromGeneral(
                                'endDate'),
                            border: OutlineInputBorder()),
                        readOnly: true,
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
                      TextFormField(
                        controller: amountPaidController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(
                                10.0), // Adjust padding if needed
                            child: Icon(
                              Icons.money_off_csred_outlined,
                              color: Palette.gray,
                              size: 20,
                            ),
                          ),
                          labelText: LocalizationService.translateFromGeneral(
                              'amountPaid'),
                          labelStyle:
                              TextStyle(color: Palette.gray, fontSize: 14),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationService.translateFromGeneral(
                                'validation_amount_paid');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: debtsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(
                                  10.0), // Adjust padding if needed
                              child: Icon(
                                Icons.money_off_csred_outlined,
                                color: Palette.gray,
                                size: 20,
                              ),
                            ),
                            labelStyle:
                                TextStyle(color: Palette.gray, fontSize: 14),
                            labelText: LocalizationService.translateFromGeneral(
                                'debts'),
                            border: OutlineInputBorder()),
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
                  ElevatedButton(
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

                        // Fetch the trainee from Firestore
                        var traineeDoc = await FirebaseFirestore.instance
                            .collection('trainees')
                            .where('username', isEqualTo: username)
                            .limit(1)
                            .get();

                        final traineeExists = traineeDoc.docs.isNotEmpty;

                        final batch = FirebaseFirestore.instance.batch();

                        // Define coach and trainee collections
                        final coachDocRef = FirebaseFirestore.instance
                            .collection('coaches')
                            .doc(coach?.uid)
                            .collection('subscriptions');

                        // Trainee exists: Update existing trainee with new subscription details
                        if (traineeExists) {
                          Get.snackbar(
                            LocalizationService.translateFromGeneral('error'),
                            LocalizationService.translateFromPage(
                                'title', 'snackbar_create_account'),
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: Palette.white,
                            margin: EdgeInsets.all(10),
                            titleText: Text(
                              textDirection: TextDirection.rtl,
                              LocalizationService.translateFromPage(
                                  'title', 'snackbar_create_account'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            messageText: Text(
                              LocalizationService.translateFromPage(
                                  'message', 'snackbar_create_account'),
                              style: const TextStyle(color: Colors.white),
                              textDirection: TextDirection.rtl,
                            ),
                          );
                        } else {
                          // Trainee does not exist: Create new trainee and subscription
                          final newTraineeRef = FirebaseFirestore.instance
                              .collection('trainees')
                              .doc();
                          batch.set(newTraineeRef, {
                            'username': username,
                            'age': '0',
                          });

                          final subscriptionDocRef = coachDocRef.doc();
                          batch.set(subscriptionDocRef, {
                            'username': username,
                            'startDate': startDate,
                            'endDate': endDate,
                            'amountPaid': amountPaid,
                            'debts': debts,
                            'userId': newTraineeRef.id,
                          });
                          batch.update(newTraineeRef, {
                            'coachId': coach?.uid,
                            'subscriptionId': subscriptionDocRef.id,
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    LocalizationService.translateFromPage(
                                        'snackbar_success',
                                        'snackbar_create_account'))),
                          );
                          Navigator.of(context).pop();
                        }

                        // Commit batch write
                        await batch.commit();
                        await fetchTrainees();
                        Navigator.of(context).pop();

                        // Close loading dialog
                      }
                    },
                    child: Text(
                      LocalizationService.translateFromGeneral('save'),
                    ),
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
                actionsAlignment: MainAxisAlignment.start,
              ),
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
          final name = trainee['fullName'].toLowerCase();
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
