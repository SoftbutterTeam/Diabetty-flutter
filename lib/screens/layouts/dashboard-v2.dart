import 'package:diabetttty/components/GridListing.dart';
import 'package:diabetttty/model/Models.dart';
import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/utils/DataGenerator.dart';
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
  List<Category> mFavouriteList;

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
    mFavouriteList = getBottomSheetItems();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    if (pageIndex != 3) {
      pageController.animateToPage(pageIndex,
          duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
    } else {
      showSheet(context);
    }
  }

  showSheet(BuildContext aContext) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: aContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.38,
              maxChildSize: 1,
              minChildSize: 0.3,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: EdgeInsets.only(top: 24),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      color: Color(0XFFF6F7FA),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Color(0XFFB4BBC2),
                        width: 50,
                        height: 3,
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: GridListing(mFavouriteList, true),
                        ),
                      )
                    ],
                  ),
                );
              });
        });
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
