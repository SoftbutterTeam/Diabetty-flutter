import 'package:diabetttty/components/GridListing.dart';
import 'package:diabetttty/screens/DayPlanScreens/DayPlanScreen.dart';
import 'package:diabetttty/utils/model/Models.dart';
import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:diabetttty/utils/DataGenerator.dart';
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
  int currentIndex = 0;
  List<Category> mFavouriteList;

  var _pages = [
    // Timeline(),
    DayPlanner(),
    DayPlanner(),
    DrafttScreen(),
    TherapyPlanner()
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
      this.currentIndex = currentIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(pageIndex);

    if (pageIndex == 3 && currentIndex == 3) {
      showSheet(context);
    }
    currentIndex = pageIndex;
  }

  showSheet(BuildContext aContext) {
    changeStatusColor(Colors.transparent);
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

  Scaffold buildDashboard() {
    var __items = [
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
              padding: EdgeInsets.only(left: 2.5),
              child: SvgPicture.asset(
                'images/icons/checkbox/clock.svg',
                height: 33,
                width: 33,
                color: Colors.indigo,
                fit: BoxFit.fitHeight,
              )),
          title: Text("today")),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            sos_ic_gradient,
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
          more_ic,
          height: 30,
          width: 30,
          color: Colors.indigo,
          fit: BoxFit.fitHeight,
        ),
        title: pageIndex == 3 ? Text("more") : Text("therapy"),
      ),
    ];
    return Scaffold(
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
        // backgroundColor: t3_app_background,
        items: __items,
      ),
    );
    //
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(t3_app_background);
    return Container(
        color: t3_app_background,
        child: SafeArea(
          top: false,
          bottom: false,
          child: buildDashboard(),
        ));
  }
}
