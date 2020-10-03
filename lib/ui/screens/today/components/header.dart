import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:diabetty/ui/screens/today/components/drop_modal.dart';
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
      pageBuilder: (_, __, ___) => DropModal(),
    );
  }

  Widget _buildDateWidget(BuildContext context) {
    final DayPlanManager dayManager =
        Provider.of<DayPlanManager>(context, listen: false);
    return Positioned(
        child: FlatButton(
      onPressed: () {
        _showDropModal(context, null);
      },
      child: Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 30),
          child: subHeadingText(
              dayManager.currentDateStamp.toString(), Colors.white),
        ),
      ),
    ));
  }

  Widget _buildLayoutButton(BuildContext context) {
    return Positioned(
      top: 35,
      left: 5,
      child: Container(
        padding: EdgeInsets.only(top: 5),
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
    return Positioned(
      top: 35,
      right: 5,
      child: Container(
        padding: EdgeInsets.only(top: 5),
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
      // padding: EdgeInsets.only(left: 15, right: 15),
      child: Stack(
        children: <Widget>[
          _buildDateWidget(context),
          _buildLayoutButton(context),
          _buildFilterButton(context)
        ],
      ),
    );
  }
}
