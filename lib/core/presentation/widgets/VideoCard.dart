import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final String videoUrl;
  final String? title;
  final String? roundText;
  final String? repetitionText;
  final double? height;

  const VideoCard({
    super.key,
    required this.videoUrl,
    this.title,
    this.roundText,
    this.repetitionText,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? MediaQuery.of(context).size.height * 0.4,
      decoration: _buildBoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildVideoPlaceholder(context), // Video player placeholder
            const SizedBox(height: 8),
            if (title != null) _buildTitleAndActions(), // Title and action buttons
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    // Builds the box decoration for the video card
    return BoxDecoration(
      color: const Color(0xFF262520),
      boxShadow: const [
        BoxShadow(
          blurRadius: 4,
          color: Color(0x48FFFFFF),
          offset: Offset(1, 2),
        ),
      ],
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: const Color(0xff98ffbb02),
      ),
    );
  }

  Widget _buildVideoPlaceholder(BuildContext context) {
    // Placeholder for the video player
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.black,
      child: const Center(
        child: Text(
          "Video Player Here",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTitleAndActions() {
    // Builds the title and action buttons section
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildTitle(),
          const SizedBox(height: 8),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    // Builds the title text widget
    return Text(
      title ?? '',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }

  Widget _buildActionButtons() {
    // Builds the row of action buttons
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (roundText != null) _buildActionButton(
          text: roundText ?? '',
          color: const Color(0xFFFFBB02),
          onPressed: () {
            print('Rounds button pressed');
          },
        ),
        const SizedBox(width: 8),
        if (repetitionText != null) _buildActionButton(
          text: repetitionText ?? '',
          color: Colors.green,
          onPressed: () {
            print('Reps button pressed');
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    // Builds an individual action button
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
