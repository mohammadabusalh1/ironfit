import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/features/createPlan/widgets/ex.dart';

List<OutExercise> menuItems = exerciseManager.getExercises();

class DropdownMenuSearch extends StatefulWidget {
  final Function(OutExercise?) onSelected; // Add callback to pass selected item
  const DropdownMenuSearch({super.key, required this.onSelected});

  @override
  State<DropdownMenuSearch> createState() => _DropdownMenuSampleState();
}

class _DropdownMenuSampleState extends State<DropdownMenuSearch> {
  OutExercise? selectedMenu; // Track the selected value
  late TextEditingController menuController; // Declare the controller
  late List<DropdownMenuEntry<OutExercise>> dropdownEntries; // Cache entries

  @override
  void initState() {
    super.initState();
    menuController = TextEditingController(); // Initialize controller

    // Cache the dropdown entries for better performance
    dropdownEntries = menuItems.map<DropdownMenuEntry<OutExercise>>((menu) {
      return DropdownMenuEntry<OutExercise>(
        value: menu,
        label: menu.exerciseName,
      );
    }).toList();
  }

  @override
  void dispose() {
    // Dispose of the controller to avoid memory leaks
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<OutExercise>(
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            width: 1,
            color: Palette.mainAppColor,
          ),
        ),
      ),
      controller: menuController,
      width: MediaQuery.of(context).size.width * 0.75,
      requestFocusOnTap: true,
      enableFilter: true,
      menuStyle: MenuStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.lightBlue.shade50),
      ),
      label: const Text('التمرين', style: TextStyle(color: Colors.white)),

      // Set initial value if you want to show a pre-selected exercise
      initialSelection: selectedMenu,

      // Handle value changes here
      onSelected: (OutExercise? menu) {
        if (menu != selectedMenu) {
          // Avoid unnecessary rebuilds
          setState(() {
            selectedMenu = menu; // Update the selected value
            widget.onSelected(menu);
          });
        }
      },
      dropdownMenuEntries: dropdownEntries,
      enableSearch: true,
       // Use cached entries
    );
  }
}
