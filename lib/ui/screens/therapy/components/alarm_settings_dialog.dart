import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                color: (criticalToggleSwitch && (checkBox || checkBox2))
                    ? Colors.indigo
                    : Colors.black26,
              ),
            ),
            onPressed: () {
              if (criticalToggleSwitch && (checkBox || checkBox2))
                Navigator.pop(context);
            },
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
          children: [
            text("Sound", fontSize: 16.0, textColor: Colors.black),
            _buildNoReminderToggle("No Reminder"),
            _buildSilentToggle("Silent"),
          ],
        ));
  }

  Container _buildCriticalAlertField(Size size) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      // color: Colors.red,
      child: _buildCriticalAlertToggle("Enable Critical Alerts"),
    );
  }

  Padding _buildCriticalAlertToggle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(title,
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
    );
  }

  Padding _buildNoReminderToggle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(title,
              fontSize: 15.0,
              fontFamily: fontBold,
              textColor: (checkBox) ? Colors.black : Colors.black26),
          CupertinoSwitch(
            activeColor: Colors.indigo,
            value: checkBox,
            onChanged: (v) {
              setState(() {
                checkBox = v;
                checkBox2 = !v;
              });
            },
          ),
        ],
      ),
    );
  }

  Padding _buildSilentToggle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(title,
              fontSize: 15.0,
              fontFamily: fontBold,
              textColor: (checkBox2) ? Colors.black : Colors.black26),
          CupertinoSwitch(
            activeColor: Colors.indigo,
            value: checkBox2,
            onChanged: (v) {
              setState(() {
                checkBox = !v;
                checkBox2 = v;
              });
            },
          ),
        ],
      ),
    );
  }
}

// Row(
//   children: [
//     CircularCheckBox(
//       visualDensity: VisualDensity.comfortable,
//         value: checkBox,
//         materialTapTargetSize: MaterialTapTargetSize.padded,
//         onChanged: (bool value) {
//           setState(() {
//             checkBox = value;
//             checkBox2 = !value;
//           });
//         }),
// Checkbox(

//         onChanged: (bool value) {
//           setState(() {
//            checkBox = value;
//            checkBox2 = !value;
//           });
//         },
//         // tristate: i == 1,
//        value: checkBox,
//       ),
//     Text(
//       'No Reminder',
//       style: Theme.of(context).textTheme.subtitle1.copyWith(
//           color:
//               (checkBox == true) ? Colors.black38 : Colors.black),
//     ),
//   ],
// ),
// CheckboxListTile(
//   title: text("No Reminder",
//       fontSize: 15.0,
//       textColor: (checkBox) ? Colors.black : Colors.black26),
//   value: checkBox,
//   onChanged: (value) {
//     setState(() {
//       checkBox = value;
//       checkBox2 = !value;
//     });
//   },
//   activeColor: Colors.indigo,
// ),
// CheckboxListTile(
//   title: text("Silent",
//       fontSize: 15.0,
//       textColor: (checkBox2) ? Colors.black : Colors.black26),
//   value: checkBox2,
//   onChanged: (value) {
//     setState(() {
//       checkBox = !value;
//       checkBox2 = value;
//     });
//   },
//   activeColor: Colors.indigo,
// ),
