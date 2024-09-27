import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:ironfit/core/presention/style/assets.dart';

class EnteInfoBody extends StatelessWidget {
  EnteInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  Assets.signOne,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  Assets.ironFitLogo,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, 0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              'أكمل معلوماتك من فضلك',
              style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Text(
                textAlign: TextAlign.start,
                "الاسم",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: TextFormField(
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                hintText: 'محمد ابو صالح',
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0x87FFFFFF),
                ),
                filled: true,
                fillColor: const Color(0xFF454038),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFFFBB02), width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 26, 0),
            child: Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Text(
                textAlign: TextAlign.start,
                "العمر",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
                hintText: '22',
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0x87FFFFFF),
                ),
                filled: true,
                fillColor: const Color(0xFF454038),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFFFBB02), width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 26, 0),
            child: Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Text(
                textAlign: TextAlign.start,
                "الطول",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
                hintText: '178',
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0x87FFFFFF),
                ),
                filled: true,
                fillColor: const Color(0xFF454038),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFFFBB02), width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
