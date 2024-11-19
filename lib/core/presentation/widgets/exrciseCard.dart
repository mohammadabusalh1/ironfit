import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
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
  final Function() onTap;

  const ExrciseCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    this.withIconButton = true,
    this.padding = 24,
    this.spaceBetweenItems = 24,
    this.onTap = _defaultOnTap,
  });

  static void _defaultOnTap() {}

  @override
  _ExrciseCardState createState() => _ExrciseCardState();
}

class _ExrciseCardState extends State<ExrciseCard> {
  bool _isClicked = false;
  Timer? _timer;
  int _timeLeft = 90; // 90 seconds = 1:30 minutes
  bool _isTimerActive = false;

  @override
  void initState() {
    super.initState();
    _loadClickedState(); // Load saved state
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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

  void showImage(String image, context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: CachedNetworkImage(
          imageUrl: image,
        ),
      ),
    );
  }

  void _startTimer() {
    setState(() {
      _timeLeft = 90;
      _isTimerActive = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _isTimerActive = false;
          _timer?.cancel();
        }
      });
    });
  }

  String _formatTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.padding),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                showImage(widget.image, context);
              },
              child: buildImage(),
            ),
            SizedBox(width: widget.spaceBetweenItems),
            buildTextColumn(context),
            widget.withIconButton
                ? SizedBox(width: widget.spaceBetweenItems)
                : Container(),
            widget.withIconButton ? buildIconButton(context) : Container(),
          ],
        ),
      ),
    );
  }

  // Reusable Image Widget
  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: widget.image,
        width: MediaQuery.of(Get.context!).size.width * 0.18,
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
                ? '${widget.title.substring(0, 16)}...'
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
          color: Palette.mainAppColor,
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
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor:
                _isTimerActive ? Palette.white.withOpacity(0.8) : Palette.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: _isTimerActive
              ? Text(
                  _formatTime(_timeLeft),
                  style: TextStyle(
                    color: Palette.mainAppColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )
              : Icon(
                  Icons.done_all,
                  color: _isClicked ? Colors.green : Palette.mainAppColor,
                  size: 24,
                ),
          onPressed: _isTimerActive
              ? null
              : () {
                  setState(() {
                    _isClicked = !_isClicked;
                    if (_isClicked) {
                      _startTimer();
                    }
                    _saveClickedState();
                  });
                },
        ),
        if (_isTimerActive)
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              value: _timeLeft / 90,
              strokeWidth: 2,
              color: Palette.mainAppColor,
              backgroundColor: Colors.grey.withOpacity(0.3),
            ),
          ),
      ],
    );
  }
}
