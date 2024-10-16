import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/widgets/DaysTabBar.dart';

class UserMyPlanBody extends StatefulWidget {
  const UserMyPlanBody({super.key});

  @override
  _UserMyPlanBodyState createState() => _UserMyPlanBodyState();
}

class _UserMyPlanBodyState extends State<UserMyPlanBody> {
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
                        Align(
                          alignment: const AlignmentDirectional(0, -1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              children: [
                                Image.asset(
                                  Assets.header,
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  color: Colors.black.withOpacity(
                                      0.5), // Black filter with 50% opacity
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              24,
                              MediaQuery.of(context).size.height * 0.08,
                              24,
                              MediaQuery.of(context).size.height * 0.08),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Opacity(
                                opacity: 0.9,
                                child: Text(
                                  'خطتي',
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
                  CustomTabBarWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
