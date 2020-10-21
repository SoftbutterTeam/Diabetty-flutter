import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';

class AlarmSettingsDialog extends StatefulWidget {
  final AddTherapyForm therapyForm;

  AlarmSettingsDialog({this.therapyForm});
  @override
  _AlarmSettingsDialogState createState() => _AlarmSettingsDialogState();
}

class _AlarmSettingsDialogState extends State<AlarmSettingsDialog> {
  bool criticalToggleSwitch;
  bool noReminderToggle;
  bool silentToggle;

  @override
  void initState() {
    super.initState();
    criticalToggleSwitch = false;
    noReminderToggle = false;
    silentToggle = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: size.height * 0.36,
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
                color: (noReminderToggle || silentToggle)
                    ? Colors.indigo
                    : Colors.black26,
              ),
            ),
            onPressed: () {
              if (noReminderToggle || silentToggle) _handleSubmit();
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
              // if (v) {
              //   widget.therapyForm.enableCriticalAlerts = v;
              // } else {
              //   widget.therapyForm.enableCriticalAlerts = !v;
              // }
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
              textColor: (noReminderToggle) ? Colors.black : Colors.black26),
          CupertinoSwitch(
            activeColor: Colors.indigo,
            value: noReminderToggle,
            onChanged: (v) {
              setState(() {
                noReminderToggle = v;
                silentToggle = !v;
              });
              // if (noReminderToggle) {
              //   widget.therapyForm.noReminder = v;
              // } else {
              //   widget.therapyForm.noReminder = !v;
              // }
              //TODO get noReminder and silent to equal correct value when they change each other
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
              textColor: (silentToggle) ? Colors.black : Colors.black26),
          CupertinoSwitch(
            activeColor: Colors.indigo,
            value: silentToggle,
            onChanged: (v) {
              setState(() {
                noReminderToggle = !v;
                silentToggle = v;
              });

              // if (silentToggle) {
              //   widget.therapyForm.silent = v;
              // } else {
              //   widget.therapyForm.silent = !v;
              // }
            },
          ),
        ],
      ),
    );
  }

  _handleSubmit() {
    if (silentToggle) {
      widget.therapyForm.silent = true;
      widget.therapyForm.noReminder = false;
    }

    if (noReminderToggle) {
      widget.therapyForm.silent = false;
      widget.therapyForm.noReminder = true;
    }

    if (criticalToggleSwitch) {
      widget.therapyForm.enableCriticalAlerts = true;
    } else {
      widget.therapyForm.enableCriticalAlerts = false;
    }
    Navigator.pop(context);
  }
}

// Row(
//   children: [
//     CircularCheckBox(
//       visualDensity: VisualDensity.comfortable,
//         value: noReminderToggle,
//         materialTapTargetSize: MaterialTapTargetSize.padded,
//         onChanged: (bool value) {
//           setState(() {
//             noReminderToggle = value;
//             silentToggle = !value;
//           });
//         }),
// Checkbox(

//         onChanged: (bool value) {
//           setState(() {
//            noReminderToggle = value;
//            silentToggle = !value;
//           });
//         },
//         // tristate: i == 1,
//        value: noReminderToggle,
//       ),
//     Text(
//       'No Reminder',
//       style: Theme.of(context).textTheme.subtitle1.copyWith(
//           color:
//               (noReminderToggle == true) ? Colors.black38 : Colors.black),
//     ),
//   ],
// ),
// CheckboxListTile(
//   title: text("No Reminder",
//       fontSize: 15.0,
//       textColor: (noReminderToggle) ? Colors.black : Colors.black26),
//   value: noReminderToggle,
//   onChanged: (value) {
//     setState(() {
//       noReminderToggle = value;
//       silentToggle = !value;
//     });
//   },
//   activeColor: Colors.indigo,
// ),
// CheckboxListTile(
//   title: text("Silent",
//       fontSize: 15.0,
//       textColor: (silentToggle) ? Colors.black : Colors.black26),
//   value: silentToggle,
//   onChanged: (value) {
//     setState(() {
//       noReminderToggle = !value;
//       silentToggle = value;
//     });
//   },
//   activeColor: Colors.indigo,
// ),
