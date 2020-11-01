import 'dart:ui';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/today/mixins/ReminderActionsMixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ReminderInfoModal extends StatefulWidget {
  const ReminderInfoModal({
    this.reminder,
    Key key,
  }) : super(key: key);

  final Reminder reminder;

  @override
  _ReminderInfoModalState createState() => _ReminderInfoModalState();
}

class _ReminderInfoModalState extends State<ReminderInfoModal>
    with ReminderActionsMixin {
  MaterialColor colorToFade;
  double opacity;

  @override
  void initState() {
    colorToFade = widget.reminder.isComplete ? Colors.green : Colors.grey;
    opacity = widget.reminder.isComplete ? .3 : .3;
    super.initState();
  }

  double curve = 15;
  double bottomCurve;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Container(
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          child: SizedBox(
            width: size.width * 0.8,
            height: size.height * 0.32,
            child: Card(
              shadowColor: null,
              elevation: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(curve),
              ),
              child: _buildContent(context, size),
            ),
          )),
    );
  }

  Widget _buildContent(BuildContext context, size) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: _buildHeader(),
          ),
          Flexible(
            flex: 3,
            child: _buildBody2(size),
          ),
          Flexible(
            flex: 2,
            child: _buildFooter(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBody2(size) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      appearance_iconss[0],
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5, top: 5),
                    child: text(widget.reminder.name,
                        fontSize: 18.0,
                        textColor: Colors.black,
                        fontFamily: fontBold,
                        latterSpacing: 1.5),
                  ),
                  if (widget.reminder.advice.isNotEmpty ||
                      widget.reminder?.advice[0] != 'none')
                    Padding(
                      padding: EdgeInsets.only(left: 5, bottom: 10),
                      child: text(widget.reminder?.advice[0],
                          fontSize: 15.0,
                          textColor: Colors.black87,
                          fontFamily: fontSemibold),
                    ),
                ],
              ),
            ],
          ),
          Container(
            height: 1,
            width: size.width * 0.75,
            color: Colors.black12,
          ),
          Row(
            children: [
              SizedBox(width: 15),
              Icon(Icons.date_range, size: 20),
              SizedBox(width: 20),
              text('Scheduled for ',
                  // DateFormat('dd/MM/yy').format(widget.reminder.time),
                  fontSize: 12.0),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 15),
              Icon(Icons.filter_center_focus, size: 20),
              SizedBox(width: 20),
              text('Takepill(s)', //  ' + widget.reminder.dose.toString() + '
                  fontSize: 12.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      child: Container(
          decoration: BoxDecoration(
              color: widget.reminder.isComplete ? Colors.greenAccent : null,
              gradient: RadialGradient(
                radius: 5,
                tileMode: TileMode.mirror,
                focalRadius: 2,
                colors: [
                  colorToFade.shade300.withOpacity(opacity),
                  colorToFade.shade200.withOpacity(opacity),
                  Colors.white.withOpacity(.1),
                  Colors.white.withOpacity(.1),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(curve), // was 20  10
                topRight: Radius.circular(curve),
              )),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.more_vert, color: Colors.transparent),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.more_horiz),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: widget.reminder.isComplete ? Colors.greenAccent : null,
            gradient: RadialGradient(
              radius: 5,
              tileMode: TileMode.mirror,
              focalRadius: 2,
              colors: [
                Colors.white.withOpacity(.1),
                colorToFade.shade200.withOpacity(opacity),
                colorToFade.shade500.withOpacity(opacity),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomCurve ?? curve), // was 20  10
              bottomRight: Radius.circular(bottomCurve ?? curve),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 75,
                    width: 60,
                    child: Column(children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _skipActionSheet(context);
                        },
                        padding: EdgeInsets.all(3),
                        icon: SvgPicture.asset(
                          'assets/icons/navigation/x/close.svg',
                          width: 30,
                          height: 30,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      text(
                        "Skip",
                        textColor: Colors.black,
                        fontFamily: fontSemibold,
                        fontSize: 12.0,
                        maxLine: 2,
                        isCentered: true,
                      ),
                    ]))
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 75,
                  width: 60,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _takenActionSheet(context);
                        },
                        padding: EdgeInsets.all(3),
                        icon: SvgPicture.asset(
                          'assets/icons/navigation/checkbox/tick_outline2.svg',
                          width: 30,
                          height: 30,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      text(
                        "Take",
                        textColor: Colors.black,
                        fontFamily: fontSemibold,
                        fontSize: 12.0,
                        maxLine: 2,
                        isCentered: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 75,
                  width: 60,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _snoozeActionSheet(context);
                        },
                        padding: EdgeInsets.all(3),
                        icon: SvgPicture.asset(
                          'assets/icons/navigation/clock/wall-clock.svg',
                          width: 30,
                          height: 30,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      text(
                        "Snooze",
                        textColor: Colors.black,
                        fontFamily: fontSemibold,
                        fontSize: 12.0,
                        maxLine: 2,
                        isCentered: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  void _snoozeActionSheet(BuildContext context) {
    showSnoozeActionSheet(context);
  }

  void _skipActionSheet(BuildContext context) {
    showSkipActionSheet(context);
  }

  void _takenActionSheet(BuildContext context) {
    showTakenActionSheet(context);
  }
}
