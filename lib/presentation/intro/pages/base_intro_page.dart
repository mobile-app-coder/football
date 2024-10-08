import 'package:flutter/material.dart';
import 'package:football/presentation/intro/pages/create_team_page.dart';
import 'package:football/presentation/intro/pages/intro_page.dart';
import 'package:football/presentation/intro/pages/select_team_name_page.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'capitan_selection_page.dart';

class BaseIntroPage extends StatefulWidget {
  const BaseIntroPage({super.key});

  @override
  State<BaseIntroPage> createState() => _BaseIntroPageState();
}

class _BaseIntroPageState extends State<BaseIntroPage> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                IntroPag(
                  key: PageStorageKey('IntroPage1'),
                  introData: intro[0],
                ),
                IntroPag(
                  key: PageStorageKey('IntroPage2'),
                  introData: intro[1],
                ),
                IntroPag(
                  key: PageStorageKey('IntroPage3'),
                  introData: intro[2],
                ),
                CreateTeamPage(
                  pageController: pageController,
                  key: PageStorageKey('IntroPage4'),
                ),
                CapitanSelectionPage(
                    pageController: pageController,
                    key: PageStorageKey('IntroPage5')),
                const SelectTeamNamePage(key: PageStorageKey('IntroPage6'))
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 6,
            effect: const JumpingDotEffect(
                activeDotColor: Color(0xFF10A3A3), dotColor: Color(0xFFB2EBF2)),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
