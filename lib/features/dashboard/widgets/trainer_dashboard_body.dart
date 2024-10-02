import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/dashboard/controllers/trainer_dashboard_controller.dart';
import 'package:ironfit/core/presention/style/palette.dart';

class TrainerDashboardBody extends StatelessWidget {
  final TranierDashboardController dashboardController = Get.find();
  final TranierDashboardController controller =
      Get.put(TranierDashboardController());

  TrainerDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.black,
        body: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    Assets.dashboardBackground,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 12,
                  top: MediaQuery.of(context).size.height * 0.07,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          Assets.myTrainerImage,
                          width: MediaQuery.of(context).size.height * 0.09,
                          height: MediaQuery.of(context).size.height * 0.09,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "محمد ابو صالح",
                            style: TextStyle(
                                color: Palette.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "oG2gU@example.com",
                            style: TextStyle(
                              color: Palette.subTitleGrey,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 40),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 40,
                          height: 40,
                          color: Palette.colseButtonBlack,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: Palette.white,
                              size: 24,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        Assets.dashboardYellow,
                        width: MediaQuery.of(context).size.height * 0.7,
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Palette.mainAppColor, // Background color
                        borderRadius: BorderRadius.circular(
                            16), // Set the border radius here
                      ),
                      child: const Text(
                        'تمارين اليوم',
                        style: TextStyle(fontSize: 14, color: Palette.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
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
                ],
              ),
            ))
          ],
        ));
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
