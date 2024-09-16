import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/controllers/nav_bar_controller.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NavController());
    return MaterialApp(
      title: 'IronFit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Palette.mainAppColor,
        scaffoldBackgroundColor: Palette.black,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Palette.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.mainAppColor,
          titleTextStyle: TextStyle(color: Palette.black, fontSize: 20),
          iconTheme: IconThemeData(color: Palette.black),
        ),
        // colorScheme: ColorScheme.fromSwatch().copyWith(
        //   primary: Palette.mainAppColor,
        //   secondary: Palette.mainAppColor,
        // ),
      ),
      initialRoute: Routes.home,
      onGenerateRoute: generateRoute,
    );
  }
}
