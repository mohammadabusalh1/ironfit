import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
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

  // Controllers for the form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

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
      // Collect form data from controllers
      Map<String, dynamic> coachData = {
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'age': int.parse(_ageController.text),
        'experience': _experienceController.text,
      };

      try {
        // Call the update function with the collected form data
        await updateCoachInfo(widget.coachId, coachData);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم إنشاء الحساب بنجاح')),
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('coachId', widget.coachId);

        Get.toNamed(Routes.coachDashboard);

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
            SizedBox(height: 16),
            _buildLabelWithTextField('الاسم الأول', _firstNameController),
            _buildLabelWithTextField('إسم العائلة', _lastNameController),
            _buildLabelWithTextField('العمر', _ageController,
                keyboardType: TextInputType.number),
            _buildLabelWithTextField('الخبرة', _experienceController),
            SizedBox(height: 16),
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
                      color: Palette.black, // Text color
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: const Icon(
                    Icons.west,
                    size: 22,
                    color: Palette.black, // Icon color
                  ),
                  iconAlignment: IconAlignment.end,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF1C1503),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
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
            label: label,
            hint: label,
            controller: controller,
            keyboardType: keyboardType),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
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
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
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
