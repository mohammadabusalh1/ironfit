import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGymBody extends StatelessWidget {
  const MyGymBody({super.key});

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchGymData(String coachId) async {
    CollectionReference gyms = FirebaseFirestore.instance
        .collection('coaches')
        .doc(coachId)
        .collection('gyms');

    QuerySnapshot<Map<String, dynamic>> snapshot = await gyms.limit(1).withConverter<Map<String, dynamic>>(
      fromFirestore: (snapshot, _) => snapshot.data() as Map<String, dynamic>,
      toFirestore: (data, _) => data,
    ).get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first; // Return the document snapshot
    } else {
      throw Exception('No gyms found for the specified coach.');
    }
  }

  Future<String?> _fetchCoachId() async {
    // This function should fetch the current user's coach ID.
    // Implement the logic to retrieve the coach ID here.
    return 'sample_coach_id'; // Replace with actual fetching logic
  }

  void _showEditInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تعديل المعلومات'),
          content: const Text('قم بتنفيذ نموذج التعديل هنا.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();

    // FutureBuilder<String?>(
    //   future: _fetchCoachId(), // Fetch the coach ID
    //   builder: (context, coachSnapshot) {
    //     if (coachSnapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     } else if (coachSnapshot.hasError || coachSnapshot.data == null) {
    //       return Center(child: Text('المستخدم ليس مسجلاً')); // Display a message if coachId is null
    //     }

    //     String coachId = coachSnapshot.data!;
    //     return Scaffold(
    //       backgroundColor: Colors.black, // Adjust according to your palette
    //       body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    //         future: _fetchGymData(coachId),
    //         builder: (context, gymSnapshot) {
    //           if (gymSnapshot.connectionState == ConnectionState.waiting) {
    //             return Center(child: CircularProgressIndicator());
    //           } else if (gymSnapshot.hasError) {
    //             return Center(child: Text('خطأ في تحميل البيانات'));
    //           } else if (!gymSnapshot.hasData || gymSnapshot.data!.data() == null) {
    //             return Center(child: Text('لا توجد صالات رياضية متاحة'));
    //           }

    //           final gymData = gymSnapshot.data!.data()!;
    //           String gymName = gymData['name'] ?? 'اسم الصالة';
    //           String gymLocation = gymData['location'] ?? 'الموقع';

    //           return Column(
    //             children: [
    //               Stack(
    //                 children: [
    //                   _buildBackgroundImage(),
    //                   Padding(
    //                     padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.1, 24, 0),
    //                     child: ElevatedButton(
    //                       onPressed: () {
    //                         Get.back();
    //                       },
    //                       style: ElevatedButton.styleFrom(
    //                         backgroundColor: Colors.blue, // Adjust according to your palette
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(12),
    //                         ),
    //                         padding: const EdgeInsets.symmetric(horizontal: 8),
    //                         elevation: 0,
    //                       ),
    //                       child: const Icon(
    //                         Icons.arrow_left,
    //                         color: Colors.yellow, // Adjust according to your palette
    //                         size: 24,
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.6, 24, 0),
    //                     child: _buildProfileContent(context, gymName, gymLocation),
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(height: 24),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 12),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     _buildButtonCard(context, 'تعديل المعلومات', Icons.person, () {
    //                       _showEditInfoDialog(context);
    //                     }),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           );
    //         },
    //       ),
    //     );
    //   },
    // )
  }

  Widget _buildBackgroundImage() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/your_background_image.jpg'), // Replace with your image
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildButtonCard(BuildContext context, String title, IconData icon, Function() onPressed) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onPressed,
      ),
    );
  }
}
