import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerComponent extends StatefulWidget {
  final String userId;
  final void Function(String imageUrl)? onImageUploaded;

  const ImagePickerComponent({
    Key? key,
    required this.userId,
    this.onImageUploaded,
  }) : super(key: key);

  @override
  _ImagePickerComponentState createState() => _ImagePickerComponentState();
}

class _ImagePickerComponentState extends State<ImagePickerComponent> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _uploadedImageUrl;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _uploadImage();
      });
    }
  }

  void _removeImage() async {
    if (_uploadedImageUrl != null) {
      try {
        // Create a reference to the file to delete
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/${widget.userId}.jpg');

        // Delete the file
        await storageRef.delete();

        setState(() {
          _uploadedImageUrl = null; // Clear the uploaded image URL
          _selectedImage = null; // Clear the selected image if necessary
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تمت إزالة الصورة بنجاح'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء إزالة الصورة')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا توجد صورة لإزالتها'),
        ),
      );
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage != null) {
      try {
        Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/${widget.userId}.jpg');
        await storageRef.putFile(_selectedImage!).then(
          (snapshot) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم تحميل الصورة بنجاح')),
            );
          },
        );
        final imageUrl = await storageRef.getDownloadURL();

        setState(() {
          _uploadedImageUrl = imageUrl;
        });

        // Call the callback if provided
        if (widget.onImageUploaded != null) {
          widget.onImageUploaded!(imageUrl);
        }

        Get.back();
      } catch (e) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ ما')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'أضف صورتك الشخصية!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF454038),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'أضف صورة إلى ملفك الشخصي! ما عليك سوى النقر على هذا الزر واختيار صورتك المفضلة!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.file(
                        _selectedImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFFFFBB02),
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(
                  Icons.upload,
                  color: Colors.white,
                ),
                label: const Text(
                  'اختر صورة',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  backgroundColor: const Color(0xFF454038),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              if (_selectedImage != null) ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _removeImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'إزالة الصورة',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
