import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/therapy.service.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSoundSettingsDialog extends StatefulWidget {
  final Therapy therapy;
  final TherapyManager manager;

  EditSoundSettingsDialog({this.therapy, this.manager});
  @override
  _EditSoundSettingsDialogState createState() =>
      _EditSoundSettingsDialogState();
}

class _EditSoundSettingsDialogState extends State<EditSoundSettingsDialog> {
  bool notificationsToggle;
  bool silentToggle;
  bool lateToggle;

  @override
  void initState() {
    super.initState();
    notificationsToggle = (widget.therapy.schedule.alarmSettings.notifications);
    silentToggle = (widget.therapy.schedule.alarmSettings.silent);
    lateToggle = (widget.therapy.schedule.alarmSettings.lateReminders);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: size.width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCriticalAlertField(size),
            _buildAlarmSound(size),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Expanded _buildButtons() {
    const verticalPadding = 30.0;
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: verticalPadding / 2),
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
                vertical: verticalPadding / 2,
              ),
            ),
            CupertinoButton(
              child: Text(
                '',
                style: TextStyle(
                  color: (notificationsToggle || silentToggle)
                      ? Colors.indigo
                      : Colors.black26,
                ),
              ),
              onPressed: () {},
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: verticalPadding / 2,
              ),
            ),
            CupertinoButton(
              child: Text(
                'save',
                style: TextStyle(
                  color: (true) ? Colors.orange[800] : Colors.black26,
                ),
              ),
              onPressed: () {
                _handleSubmit();
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: verticalPadding / 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildAlarmSound(Size size) {
    return Container(
        width: size.width * 0.8,
        padding: EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            text("Sound", fontSize: 16.0, textColor: Colors.black),
            _buildNotificationsToggle("Notifications"),
            _buildLateToggle('Late Reminders'),
            _buildSilentToggle("Silent"),
          ],
        ));
  }

  Container _buildCriticalAlertField(Size size) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      child: null,
    );
  }

  Padding _buildNotificationsToggle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(title,
              fontSize: 15.0,
              fontFamily: fontBold,
              textColor: (true) ? Colors.black : Colors.black26),
          CupertinoSwitch(
            activeColor: Colors.orange[100],
            value: notificationsToggle,
            onChanged: (v) {
              setState(() {
                notificationsToggle = v;
              });
            },
          ),
        ],
      ),
    );
  }

  Padding _buildSilentToggle(String title) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 10, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(title,
              fontSize: 15.0,
              fontFamily: fontBold,
              textColor: (notificationsToggle) ? Colors.black : Colors.black26),
          CupertinoSwitch(
            activeColor: Colors.orange[100],
            value: notificationsToggle ? silentToggle : false,
            onChanged: (v) {
              setState(() {
                if (notificationsToggle) silentToggle = v;
              });
            },
          ),
        ],
      ),
    );
  }

  Padding _buildLateToggle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(title,
              fontSize: 15.0,
              fontFamily: fontBold,
              textColor: (notificationsToggle) ? Colors.black : Colors.black26),
          CupertinoSwitch(
            activeColor: Colors.orange[100],
            value: notificationsToggle ? lateToggle : false,
            onChanged: (v) {
              setState(() {
                if (notificationsToggle) lateToggle = v;
              });
            },
          ),
        ],
      ),
    );
  }

  _handleSubmit() {
    widget.therapy.schedule.alarmSettings.notifications = notificationsToggle;
    widget.therapy.schedule.alarmSettings.silent = silentToggle;
    widget.therapy.schedule.alarmSettings.lateReminders = lateToggle;

    TherapyService().saveTherapy(widget.therapy);
    widget.manager.updateListeners();
    var daymanager = Provider.of<DayPlanManager>(context, listen: false);
    daymanager.scheduleNotifications();
    daymanager.updateListeners();

    Navigator.pop(context);
  }
}
