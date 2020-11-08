import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/today/components/drop_modal.dart';
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

  final DropModal dropModal = DropModal();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.11,
      decoration: BoxDecoration(
        color: Colors.transparent,
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

  void _showDateSelectDropModal(BuildContext context, Widget child) async {
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

//        dayManager.pushAnimation.forward();
        return child;
      },
      pageBuilder: (_, __, ___) => dropModal,
    );
  }

  Widget _buildDateWidget(BuildContext context) {
    final DayPlanManager dayManager =
        Provider.of<DayPlanManager>(context, listen: false);
    return Center(
        child: FlatButton(
      onPressed: () {
        if (dayManager.isPagePushed.value != true)
          dayManager.isPagePushed.value = true;
        _showDateSelectDropModal(context, null);
      },
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: subHeadingText(
              shortenDateRepresent(dayManager.currentDateStamp), Colors.white),
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
}
