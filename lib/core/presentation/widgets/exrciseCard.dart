import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExrciseCard extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final bool withIconButton;
  final double padding;
  final double spaceBetweenItems;

  const ExrciseCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    this.withIconButton = true,
    this.padding = 24,
    this.spaceBetweenItems = 24,
  });

  @override
  _ExrciseCardState createState() => _ExrciseCardState();
}

class _ExrciseCardState extends State<ExrciseCard> {
  bool _isClicked = false; // Track if the button is clicked

  @override
  void initState() {
    super.initState();
    _loadClickedState(); // Load saved state
  }

  void _loadClickedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isClicked = prefs.getBool('isClicked_${widget.title}') ?? false;
    });
  }

  void _saveClickedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isClicked_${widget.title}', _isClicked);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildImage(),
          SizedBox(width: widget.spaceBetweenItems),
          buildTextColumn(context),
          widget.withIconButton
              ? SizedBox(width: widget.spaceBetweenItems)
              : Container(),
          widget.withIconButton ? buildIconButton(context) : Container(),
        ],
      ),
    );
  }

  // Reusable Image Widget
  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        widget.image,
        width: MediaQuery.of(Get.context!).size.width * 0.24,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }

  // Reusable Text Column Widget
  Widget buildTextColumn(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title.length > 16
                ? '...${widget.title.substring(0, 16)}'
                : widget.title,
            style: AppStyles.textCairo(
              12,
              Palette.mainAppColorWhite,
              FontWeight.bold,
            ),
          ), // Space between text and icon row
          const SizedBox(height: 4),
          buildIconRow(context),
        ],
      ),
    );
  }

  // Reusable Icon and Text Row Widget
  Widget buildIconRow(BuildContext context) {
    return Column(
      children: [
        buildIconText(context, Icons.access_time_filled, widget.subtitle1),
        const SizedBox(height: 4), // Space between the two icon-text pairs
        buildIconText(context, Icons.electric_bolt_sharp, widget.subtitle2),
      ],
    );
  }

  // Reusable Icon and Text Widget
  Widget buildIconText(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Palette.primaryColor,
          size: 16,
        ),
        const SizedBox(width: 4), // Space between icon and text
        Text(
          text,
          style: AppStyles.textCairo(
            10,
            Palette.mainAppColorWhite,
            FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Reusable Icon Button Widget
  Widget buildIconButton(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: Palette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      icon: Icon(
        Icons.done_all,
        color: _isClicked ? Colors.green : Palette.mainAppColor,
        size: 24,
      ),
      onPressed: () {
        setState(() {
          _isClicked = !_isClicked;
          _saveClickedState(); // Save the state
        });
      },
    );
  }
}
