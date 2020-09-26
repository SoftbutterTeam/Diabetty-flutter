import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class DayPlanHeader extends StatefulWidget {
  const DayPlanHeader({
    Key key,
  }) : super(key: key);

  @override
  _DayPlanHeaderState createState() => _DayPlanHeaderState();
}

class _DayPlanHeaderState extends State<DayPlanHeader> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildDateWidget(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          text("Friday", fontFamily: 'Regular'),
          text('22 August',
              fontFamily: 'Regular',
              // isCentered: true,
              fontSize: textSizeSmall),
        ],
      ),
    );
  }

  Widget _buildLayoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(top: 5),
          child: SvgPicture.asset(
            'assets/icons/navigation/clock/list.svg',
            width: 24,
            height: 24,
            color: Colors.indigo,
          )),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return FocusedMenuHolder(
      onPressed: () {},
      menuWidth: MediaQuery.of(context).size.width * 0.3,
      blurSize: 5.0,
      menuItemExtent: 45,
      menuBoxDecoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      duration: Duration(milliseconds: 100),
      animateMenuItems: true,
      blurBackgroundColor: Colors.black54,
      menuOffset: 20,
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(title: Text("All"), onPressed: () {}),
        FocusedMenuItem(title: Text("Missed"), onPressed: () {}),
        FocusedMenuItem(title: Text("Scheduled"), onPressed: () {}),
        FocusedMenuItem(
            title: Text(
              "Deleted",
              style: TextStyle(color: Colors.redAccent),
            ),
            onPressed: () {})
      ],
      child: Container(
        padding: EdgeInsets.only(top: 5, right: 10),
        alignment: Alignment.centerLeft,
        child: SvgPicture.asset('assets/icons/navigation/clock/filter.svg',
            width: 24, height: 24, color: Colors.indigo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ]),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              _buildDateWidget(context),
              _buildLayoutButton(context),
              _buildFilterButton(context)
            ],
          ),
        ),
      ),
    );
  }
}
