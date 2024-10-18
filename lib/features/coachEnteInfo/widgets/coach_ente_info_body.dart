import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/uploadImage.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoachEnterInfoBody extends StatefulWidget {
  final String coachId; // Accept coach ID here

  CoachEnterInfoBody({Key? key, required this.coachId}) : super(key: key);

  @override
  _CoachEnterInfoBodyState createState() => _CoachEnterInfoBodyState();
}

class _CoachEnterInfoBodyState extends State<CoachEnterInfoBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  String? _uploadedImageUrl;
  int stage = 1;

  final List<String> _labels = [
    'الاسم الأول',
    'إسم العائلة',
    'العمر',
    'الخبرة',
  ];

  Future<void> updateCoachInfo(
      String coachId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('coaches')
        .doc(coachId)
        .update(data);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (stage == 1) {
          setState(() {
            stage = 2;
          });
        } else {
          Map<String, dynamic> coachData = {
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'age': int.parse(_ageController.text),
            'experience': _experienceController.text,
            'profileImageUrl': _uploadedImageUrl,
          };

          await updateCoachInfo(widget.coachId, coachData);
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم إنشاء الحساب بنجاح')),
          );

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('coachId', widget.coachId);

          Get.toNamed(Routes.coachDashboard);
        }
        // Navigate to the next page or perform any other action
      } catch (e) {
        // Handle any errors that occur during the update
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e')),
        );
      }
    } else {
      // Form is not valid, show a message or error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('المعلومات غير صالحة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageStack(),
            stage == 2 ? SizedBox(height: 24) : Container(),
            stage == 2
                ? ImagePickerComponent(
                    userId: widget.coachId,
                    onImageUploaded: (imageUrl) {
                      setState(() {
                        _uploadedImageUrl = imageUrl;
                      });
                    })
                : Container(),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  'أكمل معلوماتك من فضلك',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            stage == 1
                ? _buildLabelWithTextField('الاسم الأول', _firstNameController)
                : Container(),
            stage == 1
                ? _buildLabelWithTextField('إسم العائلة', _lastNameController)
                : Container(),
            stage == 1
                ? _buildLabelWithTextField('العمر', _ageController,
                    keyboardType: TextInputType.number)
                : Container(),
            stage == 1
                ? _buildLabelWithTextField('الخبرة', _experienceController,
                    keyboardType: TextInputType.number)
                : Container(),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 24),
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  label: const Text(
                    'التالي',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Palette.white, // Text color
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  icon: const Icon(
                    Icons.west,
                    size: 22,
                    color: Palette.white, // Icon color
                  ),
                  iconAlignment: IconAlignment.end,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF1C1503),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    backgroundColor: const Color(0xFFFFBB02),
                    textStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageStack() {
    return Stack(
      children: [
        _buildImage('assets/images/signOne.jpeg'),
        _buildImage('assets/images/IronFit.png'),
      ],
    );
  }

  Widget _buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLabelWithTextField(
      String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      children: [
        _buildTextField(
            label: label, controller: controller, keyboardType: keyboardType),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              const TextStyle(color: Palette.subTitleGrey, fontSize: 14),
          filled: true,
          fillColor: const Color(0xFF454038),
          enabledBorder: _buildInputBorder(const Color(0xFFFFBB02)),
          focusedBorder: _buildInputBorder(Colors.white),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 14),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'من فضلك أدخل $label';
          }
          return null;
        },
      ),
    );
  }

  OutlineInputBorder _buildInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
