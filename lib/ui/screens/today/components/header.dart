import 'package:diabetty/blocs/app_context.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/today/components/drop_modal.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/extensions/index.dart';

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

  DayPlanManager dayManager;

  final DropModal dropModal = DropModal();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dayManager = Provider.of<DayPlanManager>(context, listen: false);
    bool readOnly = Provider.of<AppContext>(context, listen: false).readOnly;
    return Container(
      height: size.height * 0.11,
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (readOnly)
            Flexible(
              flex: 1,
              child: _buildBackButton(context),
            ),
          readOnly
              ? _buildDateWidget(context)
              : Expanded(
                  child: _buildDateWidget(context),
                ),
          if (readOnly)
            Flexible(
              flex: 1,
              child: _buildTakeButton(context),
            ),
        ],
      ),
    );
  }

  void _showDateSelectDropModal(BuildContext context, Widget child) async {
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
      pageBuilder: (_, __, ___) => DropModal(
        manager: dayManager,
      ),
    );
  }

  Widget _buildDateWidget(BuildContext context) {
    AppContext appContext = Provider.of<AppContext>(context, listen: false);
    bool readOnly = appContext.readOnly;

    String name = (((appContext.user.displayName == null ||
                appContext.user.displayName.isEmpty
            ? appContext.user.name
            : appContext.user.displayName) ??
        ''));
    name = name.isEmpty ? "friend" : name;
    name += "'s";

    name = name
        .substring(0, name.length > 10 ? 10 : name.length)
        .capitalizeBegins();
    final DayPlanManager dayManager =
        Provider.of<DayPlanManager>(context, listen: false);
    return Center(
        child: FlatButton(
      onPressed: () {
        dayManager.fadeAnimation?.reset();
        _showDateSelectDropModal(context, null);
      },
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: subHeadingText(
              readOnly
                  ? name + ' ' + dayManager.currentDateStamp.formatShortShort()
                  : dayManager.currentDateStamp.shortenDateRepresent(),
              Colors.white),
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

  Widget _buildBackButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerLeft,
      child: FlatButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pushReplacementNamed(context, team);
        },
        color: Colors.transparent,
        disabledTextColor: Colors.grey,
        disabledColor: Colors.transparent,
        padding: EdgeInsets.only(left: 0),
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios, color: Colors.white, size: 17),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(
                  CupertinoIcons.profile_circled,
                  size: 30,
                  color: Colors.white,
                ),
              )
            ],
          ),
          alignment: Alignment.centerLeft,
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
