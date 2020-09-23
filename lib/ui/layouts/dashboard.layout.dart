import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/draft_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoard extends StatefulWidget {
  @override
  DashBoard({Key key, this.initIndex = 0}) : super(key: key);
  final int initIndex;

  @override
  _DashBoardState createState() => _DashBoardState(this.initIndex);
}

class _DashBoardState extends State<DashBoard> {
  _DashBoardState(initIndex) : this.pageIndex = initIndex;

  PageController pageController;
  int pageIndex = 0;
  int currentIndex = 0;

  var _pages = [DrafttScreen(), DrafttScreen(), DrafttScreen(), DrafttScreen()];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
          color: Colors.indigo,
          fit: BoxFit.fitHeight,
        ),
        title: Text("diary"),
      ),
      BottomNavigationBarItem(
          icon: Container(
              padding: EdgeInsets.only(left: 1.5),
              child: SvgPicture.asset(
                'assets/icons/navigation/checkbox/clock.svg',
                height: 33,
                width: 33,
                color: Colors.indigo,
                fit: BoxFit.fitHeight,
              )),
          title: Text("today")),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            sos_icon,
            height: 32,
            width: 32,
            color: Colors.indigo,
            fit: BoxFit.fitHeight,
          ),
          title: Text("team")),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          t_2,
          height: 30,
          width: 30,
          color: Colors.indigo,
          fit: BoxFit.fitHeight,
        ),
        activeIcon: SvgPicture.asset(
          'assets/icons/navigation/more/more.svg',
          height: 29,
          width: 29,
          color: Colors.indigo,
          fit: BoxFit.fitHeight,
        ),
        title: pageIndex == 3 ? Text("more") : Text("therapy"),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageView(
          children: _pages,
          controller: pageController,
          onPageChanged: onPageChanged),
      bottomNavigationBar: BottomNavigationBar(
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
