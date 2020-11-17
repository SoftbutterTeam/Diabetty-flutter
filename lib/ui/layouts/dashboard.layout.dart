import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/diary/diary.screen.dart';
import 'package:diabetty/ui/screens/draft_screen.dart';
import 'package:diabetty/ui/screens/today/dayplan.screen.dart';
import 'package:diabetty/ui/screens/therapy/therapy.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoard extends StatefulWidget {
  @override
  DashBoard({Key key, this.initIndex = 1}) : super(key: key);
  //! TODO default index should be 1, only changed for testings
  final int initIndex;

  @override
  _DashBoardState createState() => _DashBoardState(this.initIndex);
}

class _DashBoardState extends State<DashBoard> {
  _DashBoardState(initIndex) : this.pageIndex = initIndex;

  PageController pageController;
  int pageIndex = 0;
  int currentIndex = 0;
  Color color = Colors.deepOrangeAccent[400];

  var _pages = [
    DiaryScreenBuilder(),
    DayPlanScreenBuilder(),
    DrafttScreen(),
    TherapyScreenBuilder(),
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: pageIndex);
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
    return Container(
      color: app_background,
      child: _buildDashboard(),
    );
  }
}
