import 'dart:ui';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_modal.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_reminder_modal.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_stock_dialog.dart';
import 'package:diabetty/ui/screens/therapy/mixins/edit_therapy_modals.mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TherapyProfileScreen extends StatefulWidget {
  final Therapy therapy;
  final TherapyManager manager;
  final BuildContext context;
  TherapyProfileScreen({this.context, this.therapy, this.manager});

  @override
  _TherapyProfileScreenState createState() => _TherapyProfileScreenState();
}

class _TherapyProfileScreenState extends State<TherapyProfileScreen>
    with EditTherapyModalsMixin {
  @override
  Therapy get therapy => widget.therapy;
  final int count = 0;
  final Color textColor = Colors.orange[800];

  @override
  Widget build(BuildContext context) {
    // //print('£4');
    // //print((ModalRoute.of(context).settings.arguments as Map).toString());
    //TODO check condition for schedule / mode
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [_buildHeader(size), _buildBody(size), _buildFooter(size)],
      ),
    );
  }

  Padding _buildBody(Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.3),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: (widget.therapy?.schedule?.reminderRules?.length == 0)
              ? _buildNoActiveReminderBody(size)
              : _buildActiveReminderBody(size),
        ),
      ),
    );
  }

  Column _buildActiveReminderBody(Size size) {
    return Column(
      children: [
        Text('yeye'),
      ],
    );
  }

  final style = TextStyle(
      color: Colors.deepOrange[900],
      fontSize: 14.0,
      fontWeight: FontWeight.w500);

  final boxdecorations = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(color: Colors.black87));

  Padding _buildFooter(Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.53),
      child: Container(
        width: size.width,
        height: size.height * 0.16,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          color: Colors.white,
          border: Border.all(
            color: Colors.orange[800],
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: size.height * 0.075,
                    width: size.width * 0.15,
                    decoration: boxdecorations,
                  ),
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                  Text(
                    'alarm',
                    style: style,
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    height: size.height * 0.075,
                    width: size.width * 0.15,
                    decoration: boxdecorations,
                  ),
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                  Text(
                    'refill',
                    style: style,
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    height: size.height * 0.075,
                    width: size.width * 0.15,
                    decoration: boxdecorations,
                  ),
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                  Text(
                    'take',
                    style: style,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildNoActiveReminderBody(Size size) {
    return Column(
      children: [
        GestureDetector(
          onDoubleTap: () => null, //print('yeyeye'),
          onTap: () => null, //print('yeyeye'),
          child: Icon(Icons.error_outline, size: 50),
        ),
        SizedBox(height: size.height * 0.02),
        Text(
          'No Active Reminder',
          style: TextStyle(
            fontSize: 22.0,
            color: textColor,
            fontFamily: fontBold,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.4),
          child: Container(
            width: size.width * 0.7,
            height: size.height * 0.06,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.orange[900], Colors.orange[600]]),
              borderRadius: BorderRadius.circular(40),
            ),
            child: GestureDetector(
              onTap: () => showEditModal(context),
              child: Center(
                  child: Text('Edit Profile',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400))),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildHeader(Size size) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          border: Border(
            bottom: BorderSide(
              color: textColor,
              width: 1.0,
            ),
          )),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back_ios, color: textColor, size: 25),
                GestureDetector(
                  onTap: () {
                    final actionsheet = addOptionsActionSheet(context);
                    showCupertinoModalPopup(
                        context: context, builder: (context) => actionsheet);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: textColor, width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 5, bottom: 5),
                      child: Text(
                        "edit",
                        style: TextStyle(color: textColor, fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Container(
                    height: size.height * 0.05,
                    width: size.width * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      appearance_iconss[
                          widget.therapy.medicationInfo.appearanceIndex],
                      width: 10,
                      height: 10,
                    ),
                  ),
                  SizedBox(width: size.width * 0.05),
                  Column(
                    children: [
                      Text(widget.therapy.name,
                          style: TextStyle(
                              fontSize: 22.0,
                              color: textColor,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        // (widget.therapy.stock?.currentLevel ?? '0'),
                        'Last Taken',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "3 hours ago",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Next Dose",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "in 6 hours",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CupertinoActionSheet addOptionsActionSheet(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: text("Add Stock", fontSize: 18.0, textColor: Colors.indigo),
          onPressed: () {
            Navigator.pop(context);
            showEditStockDialog2(context);
          },
        ),
        CupertinoActionSheetAction(
          child: text("Add Reminder", fontSize: 18.0, textColor: Colors.indigo),
          onPressed: () {
            Navigator.pop(context);
            showEditReminderDialog2(context);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Container(color: Colors.white, child: Text('Cancel')),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future showEditStockDialog2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => EditStockDialog(
            // manager: widget.manager,
            therapyForm: widget.therapy) //TODO complete this modal
        );
  }

  Future showEditReminderDialog2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => EditReminderModal2(
            manager: widget.manager,
            therapyForm: widget.therapy) //TODO complete this modal
        );
  }

  Future showEditModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => EditModal(),
    );
  }
}
