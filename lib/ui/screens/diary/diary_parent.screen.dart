import 'dart:math';
import 'package:diabetty/blocs/team_manager.dart';
import 'package:diabetty/blocs/app_context.dart';
import 'package:diabetty/services/team.service.dart';

import 'package:diabetty/ui/common_widgets/ThemeColor.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/toggle_button.dart';
import 'package:diabetty/ui/screens/diary/diary.screen.dart';
import 'package:diabetty/ui/screens/diary/history/history.screen.dart';
import 'package:diabetty/ui/screens/diary/components/background.dart';
import 'package:diabetty/ui/screens/teams/relations_actions_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/models/teams/relationship.dart';

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
    return Background(
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double firstSectionHeight = 0.25;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, -1),
            ),
          ],
          border: Border(top: BorderSide(color: Colors.transparent, width: 1))),
      child: Column(
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
      ),
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
          values: ['journals', 'history'],
          textColor: lightMode.textColor,
          backgroundColor: lightMode.toggleBackgroundColor,
          buttonColor: lightMode.toggleButtonColor,
          shadows: lightMode.shadow,
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
