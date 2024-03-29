import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/diary/diary_parent.screen.dart';
import 'package:diabetty/ui/screens/others/settings_screens/settings.screen.dart';
import 'package:diabetty/ui/screens/today/dayplan.simple.screen.dart' as Simple;
import 'package:diabetty/ui/screens/therapy/therapy.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/blocs/diary.bloc.dart';

class DashBoard extends StatefulWidget {
  @override
  DashBoard({
    Key key,
    this.initIndex = 1,
  }) : super(key: key);
  //! TODO default index should be 1, only changed for testings
  final int initIndex;

  @override
  _DashBoardState createState() => _DashBoardState(this.initIndex);
}

class _DashBoardState extends State<DashBoard> {
  _DashBoardState(this.pageIndex);

  PageController pageController;
  int pageIndex = 0;
  int currentIndex = 0;
  Color color = Colors.deepOrangeAccent[400];
  bool local = true;

  var _pages = [
    DiaryParentScreenBuilder(),
    Simple.DayPlanScreenBuilder(),
    TherapyScreenBuilder(),
  ];

  @override
  void initState() {
    if (pageIndex > _pages.length - 1) {
      pageIndex = _pages.length - 1;
    }
    pageController = PageController(initialPage: pageIndex, keepPage: true);

    super.initState();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
      this.currentIndex = currentIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 10), curve: Curves.linear);

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
        label: "diary",
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
          label: "today"),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          t_2,
          height: 30,
          width: 30,
          color: color,
          fit: BoxFit.fitHeight,
        ),
        label: "therapy",
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
    final dayManager = Provider.of<DayPlanManager>(context, listen: false);
    final therapyManager = Provider.of<TherapyManager>(context, listen: false);
    dayManager.therapyManager = therapyManager;
    return Container(
      color: app_background,
      child: _buildDashboard(),
    );
  }
}
