import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/T3Images.dart';
import 'package:diabetttty/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

class DashBoard extends StatefulWidget {
  int initIndex = 0;
  DashBoard({int initIndex}) : this.initIndex = initIndex;
  @override
  _DashBoardState createState() => _DashBoardState(this.initIndex);
}

class _DashBoardState extends State<DashBoard> {
  _DashBoardState(initIndex) : this.pageIndex = initIndex;

  PageController pageController;
  int pageIndex = 0;

  var _pages = [
    // Timeline(),
    // DrafttScreen(),
    DailyPlannerScreen(),
    ReminderScreen(),
    PlanScreen(),
    SOSScreen(),
  ];

  var _items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")), 
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Search")), 
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("Cart")), 
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("My Account")), 
        ] 

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: _pages,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onTap,
        backgroundColor: t3_app_background,
        items: _items,
      ),
    );
    //
  }

  @override
  Widget build(BuildContext context) {
    return buildAuthScreen();
  }
}
