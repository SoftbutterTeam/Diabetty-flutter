import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmSettingsDialog extends StatefulWidget {
  @override
  _AlarmSettingsDialogState createState() => _AlarmSettingsDialogState();
}

class _AlarmSettingsDialogState extends State<AlarmSettingsDialog> {
  bool criticalToggleSwitch;
  bool checkBox;
  bool checkBox2;

  @override
  void initState() {
    super.initState();
    criticalToggleSwitch = false;
    checkBox = false;
    checkBox2 = false;
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
          children: [
            _buildCriticalAlertField(size),
            _buildAlarmSound(size),
            _buildCancelAndSubmitButtons(),
          ],
        ),
      ),
    );
  }

  Expanded _buildCancelAndSubmitButtons() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
              'Submit',
              style: TextStyle(
                color: Colors.indigo,
              ),
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

  Container _buildAlarmSound(Size size) {
    return Container(
        width: size.width * 0.8,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            text("Sound", fontSize: 16.0, textColor: Colors.black),
            CheckboxListTile(
              title: text("No Reminder",
                  fontSize: 15.0,
                  textColor: (checkBox) ? Colors.black : Colors.black26),
              value: checkBox,
              onChanged: (value) {
                setState(() {
                  checkBox = value;
                  checkBox2 = !value;
                });
              },
              activeColor: Colors.indigo,
            ),
            CheckboxListTile(
              title: text("Silent",
                  fontSize: 15.0,
                  textColor: (checkBox2) ? Colors.black : Colors.black26),
              value: checkBox2,
              onChanged: (value) {
                setState(() {
                  checkBox = !value;
                  checkBox2 = value;
                });
              },
              activeColor: Colors.indigo,
            ),
          ],
        ));
  }

  Container _buildCriticalAlertField(Size size) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      height: size.height * 0.09,
      width: size.width * 0.8,
      // color: Colors.red,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              text("Enable Critical Alerts",
                  fontSize: 15.0,
                  fontFamily: fontBold,
                  textColor:
                      (criticalToggleSwitch) ? Colors.black : Colors.black26),
              CupertinoSwitch(
                activeColor: Colors.indigo,
                value: criticalToggleSwitch,
                onChanged: (v) {
                  setState(() {
                    criticalToggleSwitch = v;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}



