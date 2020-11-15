import 'dart:ui';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_modal.dart';
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
  final int count = 0;

  @override
  Widget build(BuildContext context) {
    // //print('£4');
    // //print((ModalRoute.of(context).settings.arguments as Map).toString());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: [
          _buildHeader(size),
          _buildBody(size),
        ],
      ),
    );
  }

  Padding _buildBody(Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.4),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: SingleChildScrollView(
          child: (widget.therapy.schedule.reminderRules.length == 0)
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
            color: Colors.black,
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
                          color: Colors.white,
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
      height: size.height * 0.25,
      width: size.width,
      decoration: BoxDecoration(
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Colors.orange[900], Colors.orange[600]]),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Row(
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
                          color: Colors.white,
                          fontFamily: fontBold,
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      (widget.therapy.stock?.currentLevel ?? '0'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "in stock",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      (widget.therapy.schedule?.reminderRules?.length
                              .toString() ??
                          '0'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "active reminders",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    final actionsheet = addOptionsActionSheet(context);
                    showCupertinoModalPopup(
                        context: context, builder: (context) => actionsheet);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white60),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 5, bottom: 5),
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ],
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
          onPressed: () {},
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
