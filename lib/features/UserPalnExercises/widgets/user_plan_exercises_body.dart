import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:ironfit/core/presention/style/palette.dart';

class UserPalnExercisesBody extends StatefulWidget {
  const UserPalnExercisesBody({super.key});

  @override
  _UserPalnExercisesBodyState createState() => _UserPalnExercisesBodyState();
}

class _UserPalnExercisesBodyState extends State<UserPalnExercisesBody> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            Assets.header,
                            width: double.infinity,
                            height: 132,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 50, 24, 50),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Opacity(
                                opacity: 0.8,
                                child: Text(
                                  'الأحد',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    shadows: [
                                      Shadow(
                                        color: Color(0xFF2F3336),
                                        offset: Offset(4.0, 4.0),
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1C1503),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  elevation: 0,
                                ),
                                child: const Icon(
                                  Icons.arrow_right,
                                  color: Color(0xFFFFBB02),
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: const [
                          VideoCard(
                            videoUrl: 'https://your_video_url.mp4',
                            title: 'Dumbbell Row Unilateral',
                            roundText: '3 جولات',
                            repetitionText: '12 عدة',
                          ),
                          SizedBox(height: 24),
                          VideoCard(
                            videoUrl: 'https://your_video_url.mp4',
                            title: 'Dumbbell Row Unilateral',
                            roundText: '3 جولات',
                            repetitionText: '12 عدة',
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String videoUrl;
  final String title;
  final String roundText;
  final String repetitionText;

  const VideoCard({
    Key? key,
    required this.videoUrl,
    required this.title,
    required this.roundText,
    required this.repetitionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
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
          color: const Color(0xFF98FFBB02),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // You can replace this with any video player package you are using
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              color: Colors.black, // Placeholder for video player
              child: const Center(
                  child: Text(
                "Video Player Here",
                style: TextStyle(color: Colors.white),
              )),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildActionButton(
                        text: roundText,
                        color: const Color(0xFFFFBB02),
                        onPressed: () {
                          print('Rounds button pressed');
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildActionButton(
                        text: repetitionText,
                        color: Colors.green,
                        onPressed: () {
                          print('Reps button pressed');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
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
