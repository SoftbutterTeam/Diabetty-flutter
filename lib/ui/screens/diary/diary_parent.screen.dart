import 'dart:math';

import 'package:diabetty/ui/common_widgets/ThemeColor.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/toggle_button.dart';
import 'package:diabetty/ui/screens/diary/components/header.dart';
import 'package:diabetty/ui/screens/diary/diary.screen.dart';
import 'package:diabetty/ui/screens/diary/history/history.screen.dart';
import 'package:diabetty/ui/screens/diary/components/background.dart';
import 'package:diabetty/ui/screens/today/components/common_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DiaryParentScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DiaryParentScreen();
  }
}

class DiaryParentScreen extends StatefulWidget {
  @override
  _DiaryParentScreenState createState() => _DiaryParentScreenState();
}

class _DiaryParentScreenState extends State<DiaryParentScreen> {
  PageController pageController;
  bool toggleValue;
  @override
  void initState() {
    toggleValue = true;
    pageController = PageController(initialPage: toggleValue ? 0 : 1);
    pageController.addListener(() {
      bool original = toggleValue;
      toggleValue = pageController.page.round() == 0 ? true : false;
      if (original != toggleValue) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      header: DiaryHeader(),
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Container(child: _buildPageIndicator(context)),
        Expanded(
            child: Container(
                padding: EdgeInsets.only(top: 4),
                child: PageView(
                  controller: pageController,
                  physics: ClampingScrollPhysics(),
                  children: [
                    DiaryScreenBuilder(),
                    HistoryScreenBuilder(),
                  ],
                ))),
      ],
    );
  }

  ThemeColor lightMode = ThemeColor(
    gradient: [
      const Color(0xDDFF0080),
      const Color(0xDDFF8C00),
    ],
    backgroundColor: const Color(0xFFFFFFFF),
    textColor: const Color(0xFFFFFFFF),
    toggleButtonColor: Colors.deepOrange[500],
    toggleBackgroundColor: Colors.grey[100],
    shadow: const [
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(0, 0),
      ),
    ],
  );

  Widget _buildPageIndicator(context) {
    return Container(
        height: 60,
        alignment: Alignment.center,
        child: AnimatedToggle(
          values: [
            'journals',
            'history',
          ],
          textColor: lightMode.textColor,
          buttonColor: lightMode.toggleButtonColor,
          initialValue: toggleValue,
          onToggleCallback: (index) {
            toggleValue = index == 0 ? true : false;
            pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.linear);
            // setState(() {});
          },
        ));
  }
}
