import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/features/coachProfile/models/coach_profile_model.dart';

class CoachProfileController extends GetxController {
  final Rx<CoachProfileModel> profileData = CoachProfileModel(
    coachId: FirebaseAuth.instance.currentUser!.uid,
    imageUrl: Assets.notFound,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
  }

  Future<void> changeUserImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (pickedFile == null) return;

      profileData.update((val) {
        val?.imageUrl = pickedFile.path;
        val?.isLoading = true;
      });

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${profileData.value.coachId}.jpg');

      final uploadTask = storageRef.putFile(
        File(pickedFile.path),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final downloadUrl = await (await uploadTask).ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('coaches')
          .doc(profileData.value.coachId)
          .update({
        'profileImageUrl': downloadUrl,
      });

      profileData.update((val) {
        val?.imageUrl = downloadUrl;
        val?.isLoading = false;
      });

      return;
    } catch (e) {
      profileData.update((val) {
        val?.isLoading = false;
      });
      rethrow;
    }
  }

  Future<void> fetchUserName() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('coaches')
          .doc(profileData.value.coachId)
          .get();

      if (userDoc.exists) {
        String? firstName = userDoc['firstName'];
        String? lastName = userDoc['lastName'];

        profileData.update((val) {
          val?.fullName = '$firstName $lastName';
          val?.email = userDoc['email'] ?? '';
          val?.imageUrl = userDoc['profileImageUrl'] ?? '';
          val?.isDataLoaded = true;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
      rethrow;
    }
  }

  Future<void> updateUserInfo(Map<String, dynamic> updateData) async {
    try {
      await FirebaseFirestore.instance
          .collection('coaches')
          .doc(profileData.value.coachId)
          .update(updateData);
      await fetchUserName();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
      }
    } catch (e) {
      rethrow;
    }
  }
}
