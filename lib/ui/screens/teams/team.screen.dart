import 'dart:math';

import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/blocs/team_manager.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/ThemeColor.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/toggle_button.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/diary/components/background.dart';
import 'package:diabetty/ui/screens/diary/components/journal_card2.dart';
import 'package:diabetty/ui/screens/today/components/my_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/routes.dart';

class TeamScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TeamScreen();
  }
}

class TeamScreen extends StatefulWidget {
  final TeamManager manager;
  const TeamScreen({Key key, this.manager}) : super(key: key);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  TeamManager manager;

  @override
  void initState() {
    manager = widget.manager;
    super.initState();
  }

  @override
  void dispose() {
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
                    children: [
                      Container(color: Colors.transparent),
                      Container(color: Colors.blue)
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
    textColor: const Color(0xFF000000),
    toggleButtonColor: const Color(0xFFFFFFFF),
    toggleBackgroundColor: const Color(0xFFe7e7e8),
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
          values: ['Light', 'Dark'],
          textColor: lightMode.textColor,
          backgroundColor: lightMode.toggleBackgroundColor,
          buttonColor: lightMode.toggleButtonColor,
          shadows: lightMode.shadow,
          onToggleCallback: (index) {
            setState(() {});
          },
        ));
  }
}

// Navigator.pushNamed(context, appsettings);
