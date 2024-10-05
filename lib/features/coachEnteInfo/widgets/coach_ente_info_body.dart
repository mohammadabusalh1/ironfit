import 'package:flutter/material.dart';

class CoachEnterInfoBody extends StatelessWidget {
  CoachEnterInfoBody({Key? key}) : super(key: key);

  List<String> _labels = [
    'الاسم الأول',
    'إسم العائلة',
    'العمر',
    'الخبرة',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageStack(),
          const SizedBox(height: 24),
          _buildTitle('أكمل معلوماتك من فضلك'),
          const SizedBox(height: 16),
          for (var i = 0; i < _labels.length; i++)
            Column(
              children: [
                _buildLabel(_labels[i]),
                _buildTextField(
                  label: _labels[i],
                  hint: _labels[i],
                ),
                const SizedBox(height: 12),
              ],
            ),
        ],
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

  Widget _buildTitle(String text) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLabel(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          labelText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required String hint,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
          filled: true,
          fillColor: const Color(0xFF454038),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFFFBB02), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
