import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:diabetttty/themee/icons.dart';

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
    DrafttScreen(),
    DrafttScreen(),
    DrafttScreen(),
    DrafttScreen()
  ];

  var __items = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        d_5,
        height: 30,
        width: 30,
        fit: BoxFit.fitHeight,
      ),
      title: Text("diary"),
    ),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          today_gradient2,
          height: 30,
          width: 30,
          fit: BoxFit.fitHeight,
        ),
        title: Text("today")),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          sos_ic_gradient,
          height: 32,
          width: 32,
          fit: BoxFit.fitHeight,
        ),
        title: Text("team")),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        t_1,
        //"images/gradient-icons/013-pills-1.svg",
        height: 30,
        width: 30,
        fit: BoxFit.fitHeight,
      ),
      title: Text("therapy"),
    ),
  ];

  var _items = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Colors.black12,
      ),
      title: Text("activity"),
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.search, color: Colors.black12), title: Text("today")),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart, color: Colors.black12),
        title: Text("sos")),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.account_circle,
          color: Colors.black12,
        ),
        title: Text("theraphy")),
  ];

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

  Scaffold buildDashboard() {
    return Scaffold(
      body: PageView(
          children: _pages,
          controller: pageController,
          onPageChanged: onPageChanged),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onTap,
        elevation: 10.0,
        type: BottomNavigationBarType.fixed,
        // backgroundColor: t3_app_background,
        items: __items,
      ),
    );
    //
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: t3_app_background,
        child: SafeArea(
          top: true,
          bottom: true,
          child: buildDashboard(),
        ));
  }
}
