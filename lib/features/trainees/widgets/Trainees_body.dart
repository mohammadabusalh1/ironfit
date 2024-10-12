import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/routes/routes.dart';

class TraineesBody extends StatefulWidget {
  const TraineesBody({super.key});

  @override
  _TraineesBodyState createState() => _TraineesBodyState();
}

class _TraineesBodyState extends State<TraineesBody> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _currentPage = 0;

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
              fillColor: Colors.grey,
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
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('يرجى ملئ البيانات المطلوبة',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 16),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            labelText: 'الإيميل', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: startDateController,
                        decoration: const InputDecoration(
                            labelText: "تاريخ البدء",
                            border: OutlineInputBorder()),
                        readOnly: true,
                        onTap: () {
                          _selectDate(context, startDateController);
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: endDateController,
                        decoration: const InputDecoration(
                            labelText: "تاريخ الانتهاء",
                            border: OutlineInputBorder()),
                        readOnly: true,
                        onTap: () {
                          _selectDate(context, endDateController);
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: amountPaidController,
                        decoration: const InputDecoration(
                            labelText: 'المبلغ المدفوع',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: debtsController,
                        decoration: const InputDecoration(
                            labelText: 'الديون', border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        String email = emailController.text.trim();
                        String startDate = startDateController.text.trim();
                        String endDate = endDateController.text.trim();
                        String amountPaid = amountPaidController.text.trim();
                        String debts = debtsController.text.trim();

                        await FirebaseFirestore.instance
                            .collection('trainees')
                            .add({
                          'email': email,
                          'start_date': startDate,
                          'end_date': endDate,
                          'amount_paid': amountPaid,
                          'debts': debts,
                        });

                        Navigator.of(context).pop(); // Close the dialog
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
    return SafeArea(
      top: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            Assets.header,
                            width: double.infinity,
                            height: 132,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 50, 24, 50),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1C1503),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  elevation: 0,
                                ),
                                child: const Icon(
                                  Icons.arrow_left,
                                  color: Color(0xFFFFBB02),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Opacity(
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
                              ),
                            ],
                          ),
                        ),
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
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showAddTraineeDialog(context);
                            },
                            label: const Text(''),
                            icon: const Icon(
                              Icons.add,
                              size: 22,
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF1C1503),
                              backgroundColor: const Color(0xFFFFBB02),
                              padding:
                                  const EdgeInsetsDirectional.only(start: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.0,
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            label: const Text('الإسم'),
                            icon: const Icon(
                              Icons.north_rounded,
                              size: 15,
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF1C1503),
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            label: const Text('الإشتراك'),
                            icon: const Icon(
                              Icons.north_outlined,
                              size: 15,
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF1C1503),
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle: const TextStyle(
                            fontFamily: 'Inter',
                          ),
                          hintText: 'البحث',
                          hintStyle: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors
                                  .red, // Assuming the error color from the theme
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors
                                  .red, // Assuming the error color from the theme
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          filled: true,
                          fillColor: Colors.white, // Assuming background color
                        ),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                        ),
                        textAlign: TextAlign.start,
                        cursorColor: Theme.of(context)
                            .primaryColor, // Assuming the primary text color
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        buildCard(context, 'محمد أبو صالح', 'مشترك الأن',
                            Assets.myGymImage, () {
                          Get.toNamed(Routes.trainee);
                        }),
                      ],
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

Widget buildCard(
    BuildContext context, String name, String status, String imagePath, onTap) {
  return InkWell(
    onTap: onTap,
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
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          Assets.myGymImage,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'محمد أبو صالح',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFFFFBB02),
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' مشترك الأن',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0x93FFFFFF),
                              fontSize: 10,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ), // Replaces the divide function
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 24,
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
