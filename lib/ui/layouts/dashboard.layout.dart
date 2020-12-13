import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/diary/diary_parent.screen.dart';
import 'package:diabetty/ui/screens/teams/team.screen.dart';
import 'package:diabetty/ui/screens/today/dayplan.simple.screen.dart' as Simple;
import 'package:diabetty/ui/screens/therapy/therapy.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/blocs/diary.bloc.dart';

import 'package:diabetty/blocs/app_context.dart';

class DashBoard extends StatefulWidget {
  @override
  DashBoard({Key key, this.initIndex = 0, this.appContext}) : super(key: key);
  //! TODO default index should be 1, only changed for testings
  final int initIndex;
  final AppContext appContext;

  @override
  _DashBoardState createState() => _DashBoardState(this.initIndex);
}

class _DashBoardState extends State<DashBoard> {
  _DashBoardState(this.pageIndex);

  PageController pageController;
  int pageIndex = 0;
  int currentIndex = 0;
  Color color = Colors.deepOrangeAccent[400];

  var _pages = [
    DiaryParentScreenBuilder(),
    Simple.DayPlanScreenBuilder(),
    TeamScreenBuilder(),
    TherapyScreenBuilder(),
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: pageIndex, keepPage: true);
    if (widget.appContext != null)
      _pages = [
        DiaryParentScreenBuilder(),
        Simple.DayPlanScreenBuilder(),
        TherapyScreenBuilder(),
      ];
    super.initState();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
      this.currentIndex = currentIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(pageIndex);

    currentIndex = pageIndex;
  }

  Scaffold _buildDashboard() {
    var __navigationItems = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          d_5,
          height: 30,
          width: 30,
          color: color,
          fit: BoxFit.fitHeight,
        ),
        title: Text("diary"),
      ),
      BottomNavigationBarItem(
          icon: Container(
              padding: EdgeInsets.only(left: 0.5),
              child: SvgPicture.asset(
                'assets/icons/navigation/checkbox/clock.svg',
                height: 33,
                width: 33,
                color: color,
                fit: BoxFit.fitHeight,
              )),
          title: Text("today")),
      if  (widget.appContext == null)
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              sos_icon,
              height: 32,
              width: 32,
              color: color,
              fit: BoxFit.fitHeight,
            ),
            title: Text("team")),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          t_2,
          height: 30,
          width: 30,
          color: color,
          fit: BoxFit.fitHeight,
        ),
        title: Text("therapy"),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: _pages,
          controller: pageController,
          onPageChanged: onPageChanged),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange[900],
        backgroundColor: Colors.white,
        currentIndex: pageIndex,
        onTap: onTap,
        elevation: 8.0,
        type: BottomNavigationBarType.fixed,
        items: __navigationItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.appContext != null) {
      TherapyManager therapyManager =
          TherapyManager(appContext: widget.appContext)..init();

      DiaryBloc diaryBloc = DiaryBloc(appContext: widget.appContext)..init();
      DayPlanManager dayPlanManager =
          DayPlanManager(appContext: widget.appContext)..init();

      return MultiProvider(
          providers: [
            // ignore: todo
            //*TODO place AppleSignIn and emailSecure in AuthService

            ChangeNotifierProvider<TherapyManager>(
              create: (_) => therapyManager,
            ),
            ChangeNotifierProvider<DayPlanManager>(
              create: (_) => dayPlanManager,
            ),
            ChangeNotifierProvider<DiaryBloc>(
              create: (_) => diaryBloc,
            ),
          ],
          child: Container(
            color: app_background,
            child: _buildDashboard(),
          ));
    } else {
      final dayManager = Provider.of<DayPlanManager>(context, listen: false);
      final therapyManager =
          Provider.of<TherapyManager>(context, listen: false);
      dayManager.therapyManager = therapyManager;
      return Container(
        color: app_background,
        child: _buildDashboard(),
      );
    }
  }
}
