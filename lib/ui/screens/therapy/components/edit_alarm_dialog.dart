import 'dart:async';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/sub_models/stock.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/mixins/edit_therapy_modals.mixin.dart';
import 'package:diabetty/ui/screens/therapy/snooze_option.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditAlarmDialog extends StatefulWidget {
  final Therapy therapyForm;
  final TherapyManager manager;

  EditAlarmDialog({this.therapyForm, this.manager});
  @override
  _EditAlarmDialogState createState() => _EditAlarmDialogState();
}

class _EditAlarmDialogState extends State<EditAlarmDialog>
    with EditTherapyModalsMixin {
  bool alarmSound;
  bool vibration;
  bool snooze;

  @override
  void initState() {
    super.initState();
    alarmSound = (alarmSound == null) ? false : (alarmSound) ? true : false;
    vibration = (vibration == null) ? false : (vibration) ? true : false;
    snooze = (snooze == null) ? false : (snooze) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: size.height * 0.35,
        width: size.width * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAlarmSoundRow(size),
            _buildVibrationRow(size),
            _buildSnoozeRow(size),
            _buildCancelSaveButtons(),
          ],
        ),
      ),
    );
  }

  Padding _buildCancelSaveButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: CupertinoColors.destructiveRed,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 5.0,
            ),
          ),
          CupertinoButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.orange[800]),
            ),
            onPressed: () {},
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 5.0,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildSnoozeRow(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SnoozeOptionScreen()),
            ),
            child: Container(
              width: size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text("Recurring", style: TextStyle(fontSize: 20.0)),
                  ),
                  Text((snooze) ? "15 min, 3 times" : "off",
                      style: TextStyle(fontSize: 15.0)),
                ],
              ),
            ),
          ),
          SizedBox(width: size.width * 0.1),
          Container(
            margin: EdgeInsets.only(right: 15),
            height: 25,
            width: 2,
            color: Colors.orange[800],
          ),
          CupertinoSwitch(
            value: snooze,
            onChanged: (val) {
              snooze = val;
              setState(() {});
            },
            activeColor: Colors.orange[800],
          ),
        ],
      ),
    );
  }

  Padding _buildVibrationRow(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text("Vibration", style: TextStyle(fontSize: 20.0)),
                ),
                Text((vibration) ? "on" : "off",
                    style: TextStyle(fontSize: 15.0)),
              ],
            ),
          ),
          SizedBox(width: size.width * 0.1),
          Container(
            margin: EdgeInsets.only(right: 15),
            height: 25,
            width: 2,
            color: Colors.orange[800],
          ),
          CupertinoSwitch(
            value: vibration,
            onChanged: (val) {
              vibration = val;
              setState(() {});
            },
            activeColor: Colors.orange[800],
          ),
        ],
      ),
    );
  }

  Padding _buildAlarmSoundRow(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text("Alarm Sound", style: TextStyle(fontSize: 20.0)),
                ),
                Text((alarmSound) ? "ringtone: Homecoming" : "off",
                    style: TextStyle(fontSize: 15.0)),
              ],
            ),
          ),
          SizedBox(width: size.width * 0.1),
          Container(
            margin: EdgeInsets.only(right: 15),
            height: 25,
            width: 2,
            color: Colors.orange[800],
          ),
          CupertinoSwitch(
            value: alarmSound,
            onChanged: (val) {
              alarmSound = val;
              setState(() {});
            },
            activeColor: Colors.orange[800],
          ),
        ],
      ),
    );
  }
}