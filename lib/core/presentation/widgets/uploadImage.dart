import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

class ImagePickerComponent extends StatefulWidget {
  final void Function(File selectedImage)? onImageUploaded;

  const ImagePickerComponent({
    Key? key,
    this.onImageUploaded,
  }) : super(key: key);

  @override
  _ImagePickerComponentState createState() => _ImagePickerComponentState();
}

class _ImagePickerComponentState extends State<ImagePickerComponent> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  CustomSnackbar customSnackbar = CustomSnackbar();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      if (widget.onImageUploaded != null) {
        widget.onImageUploaded!(_selectedImage!);
      }
    }
  }

  void _removeImage() async {
    try {
      setState(() {
        _selectedImage = null; // Clear the uploaded image URL
      });
    } catch (e) {
      customSnackbar.showMessage(context,
          LocalizationService.translateFromGeneral('imageRemoveError'));
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
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocalizationService.translateFromGeneral('addProfilePicture'),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF454038),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                LocalizationService.translateFromGeneral(
                    'addProfilePicturePrompt'),
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
                      backgroundColor: Palette.mainAppColor,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Palette.black,
                      ),
                    ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(
                  Icons.upload,
                  color: Palette.mainAppColorWhite,
                ),
                label: Text(
                  LocalizationService.translateFromGeneral('chooseImage'),
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
                  child: Text(
                    LocalizationService.translateFromGeneral('removeImage'),
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
