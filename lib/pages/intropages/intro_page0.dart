import 'package:flutter/material.dart';
import 'package:htu_capstone_project0/pages/intropages/intro_page1.dart';

import 'intro_page2.dart';
import 'intro_page3.dart';
import 'intro_page4.dart';

class IntroPageMain extends StatelessWidget {
  IntroPageMain({super.key});
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        controller: controller,
        children: const [
          IntroPage1(),
          IntroPage2(),
          IntroPage3(),
          IntroPage4(),
        ],
      ),
    );
  }
}
