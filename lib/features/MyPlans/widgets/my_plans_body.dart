import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/editPlan/screens/edit_plan_screen.dart';

class MyPlansBody extends StatefulWidget {
  const MyPlansBody({super.key});

  @override
  _MyPlansBodyState createState() => _MyPlansBodyState();
}

class _MyPlansBodyState extends State<MyPlansBody> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isDateSortUp = true;

  Future<void> deletePlan(String planId) async {
    try {
      await _firestore
          .collection('coaches')
          .doc(_auth.currentUser?.uid)
          .collection('plans')
          .doc(planId)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editPlan(String planId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('coaches')
          .doc(_auth.currentUser?.uid)
          .collection('plans')
          .doc(planId)
          .update(data);
    } catch (e) {
      print(e.toString());
    }
  }

  void _sortBySubscription() {
    // Firestore query to fetch the data sorted by subscription date
    final order = isDateSortUp ? 'asc' : 'desc';

    setState(() {
      // Update the StreamBuilder to use the sorted query
      // This will trigger a rebuild of the widget with the new sorting order.
      getPlans();
    });
  }

  Stream<QuerySnapshot> getPlans() {
    // Firestore query for sorted plans based on subscriptionDate
    return _firestore
        .collection('coaches')
        .doc(_auth.currentUser?.uid)
        .collection('plans')
        .orderBy('createdAt',
            descending: !isDateSortUp) // Sort based on the 'subscriptionDate'
        .snapshots();
  }

  void toggleDateSort() {
    setState(() {
      isDateSortUp = !isDateSortUp;
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
            child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            HeaderImage(),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              padding: EdgeInsets.symmetric(horizontal: 24),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
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
                                      'البرامج الخاصة بي',
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
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.createPlan);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(double.infinity, 50),
                                  backgroundColor: const Color(0xFFFFBB02),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Center(
                                  // Centering the icon
                                  child: Icon(
                                    Icons.add,
                                    size: 22,
                                    color: Color(0xFF1C1503),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _sortBySubscription();
                                  toggleDateSort();
                                },
                                icon: Icon(
                                  isDateSortUp
                                      ? Icons.north_outlined
                                      : Icons.south_outlined,
                                  size: 15,
                                  color: Color(0xFF1C1503),
                                ),
                                label: const Text(
                                  'التاريخ',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF1C1503),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(double.infinity, 50),
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 15, 0, 15), // Remove padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ), // Space between buttons
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream:
                              getPlans(), // Assuming getPlans() returns a valid stream.
                          builder: (context, snapshot) {
                            // 1. Error Handling: Check for errors first.
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            // 2. Loading State: Show a loading indicator while waiting for data.
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            // 3. Null Safety: Check if the snapshot contains data.
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Text('لا يوجد برامج متاحة',
                                  style: TextStyle(
                                      color: Palette
                                          .white)); // Handle empty data case.
                            }

                            // 4. Build ListView with a non-nullable data check.
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                // 5. Check that the document data is not null.
                                Map<String, dynamic>? data =
                                    document.data() as Map<String, dynamic>?;

                                if (data == null) {
                                  return const Text(
                                      'Error: Invalid plan data'); // Handle null data.
                                }

                                // 6. Fallbacks for null fields.
                                String title = data['name'] ??
                                    'لا يوجد عنوان'; // Provide default values if null.
                                String description = data['description'] ??
                                    'لا يوجد وصف'; // Provide default values if null.

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
                                    deletePlan(document
                                        .id); // Assuming deletePlan is implemented correctly.
                                  },
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

// Reusable Card Component
class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;
  final VoidCallback onPressedEdit;

  const CustomCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
    required this.onPressedEdit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressedEdit,
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
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFFFFBB02),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                description,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0x93FFFFFF),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                            size: 24,
                          ),
                          onPressed: onPressed,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24,
                        ),
                      ],
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
