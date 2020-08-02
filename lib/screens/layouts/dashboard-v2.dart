import 'package:diabetttty/screens/index.dart';
import 'package:flutter/material.dart';

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
        type: BottomNavigationBarType.fixed,
        // backgroundColor: t3_app_background,
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
