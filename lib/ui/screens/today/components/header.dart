import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/mixins/date_mixin.dart';
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

class _DayPlanHeaderState extends State<DayPlanHeader> with DateMixin {
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
      pageBuilder: (_, __, ___) => DatePickerModal(),
    );
  }

  Widget _buildDateWidget(BuildContext context) {
    final DayPlanManager dayManager =
        Provider.of<DayPlanManager>(context, listen: false);
    var currentDateStamp = dayManager.currentDateStamp;
    return Center(
        child: FlatButton(
      onPressed: () {
        _showDropModal(context, null);
      },
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: subHeadingText(
              shortenDateRepresent(currentDateStamp), Colors.grey[900]),
        ),
      ),
    ));
  }

  Widget _buildSilentButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Opacity(
      opacity: 0,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: size.width * 0),
        child: FlatButton(
          shape: CircleBorder(),
          onPressed: () {},
          color: Colors.white,
          child:
              Icon(Icons.keyboard_arrow_up, size: 30, color: Colors.grey[900]),
        ),
      ),
    );
  }

  Widget _buildTakeButton(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Opacity(
      opacity: 0,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: size.width * 0),
        child: FlatButton(
          shape: CircleBorder(),
          onPressed: () {},
          color: Colors.white,
          child: Icon(Icons.add, size: 30, color: Colors.grey[900]),
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
          _buildSilentButton(context),
          _buildTakeButton(context),
          _buildDateWidget(context),
        ],
      ),
    );
  }
}
