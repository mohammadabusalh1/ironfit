import 'package:flutter/material.dart';
import 'package:ironfit/features/SelectLanguage/widgets/select_lang_body.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SelectLanguageBody(),
    );
  }
}
