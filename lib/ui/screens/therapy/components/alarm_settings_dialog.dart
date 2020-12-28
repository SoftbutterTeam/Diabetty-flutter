import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmSettingsDialog extends StatefulWidget {
  final AddTherapyForm therapyForm;
  final TherapyManager manager;

  AlarmSettingsDialog({this.therapyForm, this.manager});
  @override
  _AlarmSettingsDialogState createState() => _AlarmSettingsDialogState();
}

class _AlarmSettingsDialogState extends State<AlarmSettingsDialog> {
  bool enableCriticalToggle;
  bool noReminderToggle;
  bool silentToggle;

  @override
  void initState() {
    super.initState();
    enableCriticalToggle =
        (widget.therapyForm.settings.enableCriticalAlerts) ? true : false;
    noReminderToggle = (widget.therapyForm.settings.noReminder) ? true : false;
    silentToggle = (widget.therapyForm.settings.silent) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
        height: size.height * 0.36,
        width: size.width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCriticalAlertField(size),
            _buildAlarmSound(size),
            _buildButtons(),
          ],
        ),
      );
  }

  Expanded _buildButtons() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
            child: Text(
              'cancel',
              style: TextStyle(
                color: CupertinoColors.destructiveRed,
              ),
            ),
            onPressed: () => Navigator.pop(context),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 5.0,
            ),
          ),
          CupertinoButton(
            child: Text(
              'clear',
              style: TextStyle(
                color: (noReminderToggle || silentToggle)
                    ? Colors.indigo
                    : Colors.black26,
              ),
            ),
            onPressed: _reset,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 5.0,
            ),
          ),
          CupertinoButton(
            child: Text(
              'save',
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

  void _reset() {
    if (noReminderToggle || silentToggle || enableCriticalToggle)
      enableCriticalToggle = false;
    silentToggle = false;
    noReminderToggle = false;
    widget.therapyForm.settings.handleReset();
    setState(() {});
    widget.manager.updateListeners();
  }

  Container _buildAlarmSound(Size size) {
    return Container(
        width: size.width * 0.8,
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
                  (enableCriticalToggle) ? Colors.black : Colors.black26),
          CupertinoSwitch(
            activeColor: Colors.indigo,
            value: enableCriticalToggle,
            onChanged: (v) {
              setState(() {
                enableCriticalToggle = v;
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
            },
          ),
        ],
      ),
    );
  }

  _handleSubmit() {
    widget.therapyForm.settings
        .handleValidation(silentToggle, noReminderToggle, enableCriticalToggle);
    widget.manager.updateListeners();
    Navigator.pop(context);
  }
}
