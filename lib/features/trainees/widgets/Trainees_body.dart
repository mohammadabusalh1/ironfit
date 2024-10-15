import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/getCoachId.dart';
import 'package:ironfit/core/routes/routes.dart';

class TraineesBody extends StatefulWidget {
  @override
  _TraineesBodyState createState() => _TraineesBodyState();
}

class _TraineesBodyState extends State<TraineesBody> {
  List<Map<String, dynamic>> trainees = [];

  bool isNameSortUp = true;
  bool isSubscriptionSortUp = true;

  void toggleNameSort() {
    setState(() {
      isNameSortUp = !isNameSortUp;
    });
  }

  void toggleSubscriptionSort() {
    setState(() {
      isSubscriptionSortUp = !isSubscriptionSortUp;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTrainees();
  }

  Future<void> fetchTrainees() async {
    String? coachId = await fetchCoachId(); // Fetch the coach ID
    var coachDoc = await FirebaseFirestore.instance
        .collection('coaches')
        .doc(coachId)
        .collection('subscriptions')
        .get();

    setState(() {
      trainees = coachDoc.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  final PageController _pageController = PageController(initialPage: 0);
  final int _currentPage = 0;

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
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
    final TextEditingController emailController = TextEditingController();
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
              bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
              bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
              headlineLarge: TextStyle(
                  color: Colors.white,
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
              labelStyle: TextStyle(color: Colors.white, fontSize: 14),
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
              style: TextButton.styleFrom(foregroundColor: Colors.white),
            ),
          ),
          child: Expanded(
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: const Text('إضافة متدرب جديد',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  content: Form(
                    key: _formKey, // Use the form key for validation
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('يرجى ملئ البيانات المطلوبة',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'الإيميل',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال الإيميل';
                            }
                            // Email RegEx for validation
                            String pattern =
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
                            RegExp regExp = RegExp(pattern);
                            if (!regExp.hasMatch(value)) {
                              return 'يرجى إدخال إيميل صالح';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: startDateController,
                          decoration: const InputDecoration(
                              labelText: "تاريخ البدء",
                              border: OutlineInputBorder()),
                          readOnly: true,
                          onTap: () {
                            _selectDate(context, startDateController);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال تاريخ البدء';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: endDateController,
                          decoration: const InputDecoration(
                              labelText: "تاريخ الانتهاء",
                              border: OutlineInputBorder()),
                          readOnly: true,
                          onTap: () {
                            _selectDate(context, endDateController);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال تاريخ الانتهاء';
                            }
                            if (startDateController.text.isNotEmpty &&
                                endDateController.text.isNotEmpty) {
                              // Compare the dates
                              DateTime startDate =
                                  DateTime.parse(startDateController.text);
                              DateTime endDate =
                                  DateTime.parse(endDateController.text);

                              if (startDate.isAfter(endDate)) {
                                return 'تاريخ البدء لا يمكن أن يكون أكبر من تاريخ الانتهاء';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: amountPaidController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'المبلغ المدفوع',
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال المبلغ المدفوع';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: debtsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'الديون',
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال الديون';
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
                          String email = emailController.text.trim();
                          String startDate = startDateController.text.trim();
                          String endDate = endDateController.text.trim();
                          String amountPaid = amountPaidController.text.trim();
                          String debts = debtsController.text.trim();
                          String? coachId = await fetchCoachId();

                          var existingUser = await FirebaseFirestore.instance
                              .collection('trainees')
                              .doc(email)
                              .get();

                          if (existingUser.exists) {
                            // Add the new trainee to Firestore
                            await FirebaseFirestore.instance
                                .collection('coaches')
                                .doc(coachId)
                                .collection('subscriptions')
                                .add({
                              'fullName': existingUser.data()?['firstName'] +
                                  ' ' +
                                  existingUser.data()?['lastName'],
                              'age': existingUser.data()?['age'],
                              'email': email,
                              'startDate': startDate,
                              'endDate': endDate,
                              'amountPaid': amountPaid,
                              'debts': debts,
                            });

                            // Refresh the trainee list
                            await fetchTrainees(); // Fetch the updated list of trainees

                            // Show success message or feedback
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('تمت إضافة المتدرب بنجاح')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('المتدرب غير موجود')),
                            );
                          }

                          Navigator.of(context).pop(); // Close the dialog
                        }
                      },
                      child: const Text('حفظ'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('إلغاء'),
                    ),
                  ],
                  actionsAlignment: MainAxisAlignment.start,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildActionButtons(),
          const SizedBox(height: 24),
          _buildSearchField(context),
          const SizedBox(height: 24),
          _buildTraineesList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              Assets.header,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.symmetric(horizontal: 24),
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
    return const Opacity(
      opacity: 0.8,
      child: Text(
        'المتدربين',
        style: TextStyle(
          fontFamily: 'Inter',
          color: Colors.white,
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
              child: _buildSortButton('الإسم',
                  isNameSortUp ? Icons.north_rounded : Icons.south_rounded, () {
            _sortByName();
            toggleNameSort();
          })),
          const SizedBox(width: 12),
          Expanded(
              child: _buildSortButton(
                  'الإشتراك',
                  isSubscriptionSortUp
                      ? Icons.north_outlined
                      : Icons.south_outlined, () {
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
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF1C1503),
        backgroundColor: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }

  void _sortByName() {
    setState(() {
      trainees.sort((a, b) => a['fullName'].compareTo(b['fullName']));
    });
  }

  void _sortBySubscription() {
    setState(() {
      trainees.sort((a, b) => a['subscription'].compareTo(b['subscription']));
    });
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        onChanged:
            _filterTrainees, // Call the filter function on every input change
        decoration: InputDecoration(
          isDense: true,
          hintText: 'البحث',
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
          fillColor: Colors.white,
        ),
        style: const TextStyle(fontFamily: 'Inter'),
        textAlign: TextAlign.start,
        cursorColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void _filterTrainees(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        fetchTrainees(); // Reset list if search is empty
      } else {
        trainees = trainees.where((trainee) {
          final name = trainee['fullName'].toLowerCase();
          return name.contains(searchTerm.toLowerCase());
        }).toList();
      }
    });
  }

  Widget _buildTraineesList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.builder(
          itemCount: trainees.length,
          itemBuilder: (context, index) {
            var trainee = trainees[index];
            return _buildTraineeCard(
              context,
              trainee['fullName'] ?? 'غير معروف',
              DateTime.parse(trainee['endDate']).millisecondsSinceEpoch >
                      DateTime.now().millisecondsSinceEpoch
                  ? 'مشترك'
                  : 'غير مشترك ' ?? '',
              Assets.myGymImage,
              () => Get.toNamed(Routes.trainee),
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
      color: const Color(0x38454038),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(imagePath,
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
              const Icon(Icons.arrow_forward, color: Colors.white, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
