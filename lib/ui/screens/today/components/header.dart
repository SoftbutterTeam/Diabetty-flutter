import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/repositories/therapy.repository.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:diabetty/ui/screens/today/components/date_picker_modal.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DayPlanHeader extends StatefulWidget {
  const DayPlanHeader({Key key}) : super(key: key);

  @override
  _DayPlanHeaderState createState() => _DayPlanHeaderState();
}

class _DayPlanHeaderState extends State<DayPlanHeader> {
  @override
  void initState() {
    super.initState();
  }

  TherapyRepository repo = TherapyRepository();

  void _showDropModal(BuildContext context, Widget child) async {
    final DayPlanManager dayManager =
        Provider.of<DayPlanManager>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      // barrierColor: Colors.black12,
      transitionDuration: Duration(milliseconds: 100),
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, -0.5);
        var end = Offset.zero;
        var curve = Curves.linear;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        if (offsetAnimation.status == AnimationStatus.reverse) {
          offsetAnimation.value.translate(0, -0.5);
          return SizedBox(
            height: size.height,
            width: size.width,
          );
        }
        dayManager.pushAnimation.forward();
        return child;
      },
      pageBuilder: (_, __, ___) => DatePickerModal(),
    );
  }

  Widget _buildDateWidget(BuildContext context) {
    final DayPlanManager dayManager =
        Provider.of<DayPlanManager>(context, listen: false);
    var currentDateStamp = dayManager.currentDateStamp;
    return Center(
        child: FlatButton(
      onPressed: () async {
        await repo.getAllTherapy(null, null);
        _showDropModal(context, null);
      },
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: subHeadingText(
              (isSameDay(currentDateStamp, DateTime.now())
                      ? "Today, " + DateFormat("d").format(currentDateStamp)
                      : DateFormat("EE, d").format(currentDateStamp)) +
                  DateFormat(" MMM").format(currentDateStamp),
              Colors.grey[900]),
        ),
      ),
    ));
  }

  bool isSameDay(DateTime x, DateTime y) {
    if (x.day != y.day || x.month != y.month || x.year != y.year) {
      return false;
    }
    return true;
    /***? 
        subHeadingText(
              (isSameDay(currentDateStamp, DateTime.now())
                      ? "Today " + DateFormat("d").format(currentDateStamp)
                      : DateFormat("EE d").format(currentDateStamp)) +
                  getDayOfMonthSuffix(currentDateStamp.day) +
                  DateFormat(" MMM").format(currentDateStamp),
              Colors.grey[900]),
        */
  }

  String getDayOfMonthSuffix(final int n) {
    if (n >= 11 && n <= 13) {
      return '\u1d57\u02b0';
    }
    switch (n % 10) {
      case 1:
        return '\u02e2\u1d57';
      case 2:
        return '\u207f\u1d48';
      case 3:
        return '\u02b3\u1d48';
      default:
        return '\u1d57\u02b0';
    }
  }

  Widget _buildLayoutButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Opacity(
      opacity: 0,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: size.width * 0.05),
        child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          child: Align(
            child: SvgPicture.asset(
              'assets/icons/navigation/essentials/012-settings.svg',
              height: 22,
              width: 22,
              color: Colors.white,
            ),
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Opacity(
      opacity: 0,
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: size.width * 0.05),
        child: FlatButton(
          onPressed: () {},
          color: Colors.transparent,
          disabledTextColor: Colors.grey,
          disabledColor: Colors.transparent,
          padding: EdgeInsets.zero,
          child: Align(
            child: Icon(Icons.add, color: Colors.white),
            alignment: Alignment.centerRight,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.11,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
        color: appWhite,
      ),
      // padding: EdgeInsets.only(left: 15, right: 15),
      child: Stack(
        children: <Widget>[
          _buildLayoutButton(context),
          _buildFilterButton(context),
          _buildDateWidget(context),
        ],
      ),
    );
  }
}
