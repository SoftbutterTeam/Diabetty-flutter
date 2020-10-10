import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/timerpicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:intl/intl.dart';

class AddReminderModal2 extends StatefulWidget {
  @override
  _AddReminderModal2State createState() => _AddReminderModal2State();
}

class _AddReminderModal2State extends State<AddReminderModal2> {
  ReminderRule reminder;
  bool monday;
  bool tuesday;
  bool wednesday;
  bool thursday;
  bool friday;
  bool saturday;
  bool sunday;
  int lastTapped;
  TextEditingController dosageController;
  String timeString;
  DateTime initialDate;
  DateTime dateTime;

  @override
  void initState() {
    super.initState();
    monday = false;
    tuesday = false;
    wednesday = false;
    thursday = false;
    friday = false;
    saturday = false;
    sunday = false;
    dosageController = TextEditingController();
    timeString = "Time";
    dateTime = DateTime.now();
    initialDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, 0);
    reminder = ReminderRule();
    reminder.days = Days();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: size.height * 0.3,
        width: size.width * 0.8,
        child: Column(
          children: [
            _buildDaySelector(size),
            _buildDosageField(size),
            _buildTimeField(size),
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
            onPressed: () {
              _handleSubmit();
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

  Container _buildTimeField(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: size.height * 0.045,
      width: size.width * 0.7,
      child: CupertinoTextField(
        enableInteractiveSelection: false,
        padding: EdgeInsets.only(left: 15.0),
        onTap: () {
          _showTimePicker();
        },
        placeholder: timeString,
        placeholderStyle: (timeString == 'Time') ? TextStyle(
          fontSize: textSizeLargeMedium - 3,
          color: Colors.grey[700],
        ) : TextStyle(
          fontSize: textSizeLargeMedium - 2,
          color: Colors.black,
        ),
        readOnly: true,
        decoration: BoxDecoration(
          color: Color(0xfff7f7f7),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  _updateTime() {
    final hourAndMin = DateFormat('HH:mm').format(dateTime);
    setState(() {
      timeString = hourAndMin;
    });
    Navigator.pop(context);
  }

  _showTimePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return TimerPicker(
          onConfirm: () {
            _updateTime();
          },
          timepicker: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            minuteInterval: 5,
            initialDateTime: initialDate,
            onDateTimeChanged: (dateTimeChange) {
              print(dateTimeChange);
              setState(() {
                dateTime = dateTimeChange;
              });
              print(dateTime);
            },
          ),
        );
      },
    );
  }

  Container _buildDosageField(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 15),
      height: size.height * 0.045,
      width: size.width * 0.7,
      // color: Colors.red,
      child: CupertinoTextField(
        padding: EdgeInsets.only(left: 15.0),
        controller: dosageController,
        placeholder: "Dosage",
        placeholderStyle: TextStyle(
          fontSize: textSizeLargeMedium - 3,
          color: Colors.grey[700],
        ),
        keyboardType: TextInputType.number,
        maxLength: 3,
        maxLengthEnforced: true,
        decoration: BoxDecoration(
          color: Color(0xfff7f7f7),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  _updateDaySelected(int v) {
    (v == 1)
        ? setState(() {
            monday = !monday;
          })
        : null;
    (v == 2)
        ? setState(() {
            tuesday = !tuesday;
          })
        : null;
    (v == 3)
        ? setState(() {
            wednesday = !wednesday;
          })
        : null;
    (v == 4)
        ? setState(() {
            thursday = !thursday;
          })
        : null;
    (v == 5)
        ? setState(() {
            friday = !friday;
          })
        : null;
    (v == 6)
        ? setState(() {
            saturday = !saturday;
          })
        : null;
    (v == 7)
        ? setState(() {
            sunday = !sunday;
          })
        : null;
    print(v);
    setState(() => lastTapped = v);
  }

  Container _buildDaySelector(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      height: size.height * 0.045,
      width: size.width,
      // color: Colors.red,
      child: WeekdaySelector(
        // We display the last tapped value in the example app
        onChanged: (v) {
          _updateDaySelected(v);
        },
        values: [
          sunday, // Sunday
          monday, // Monday
          tuesday, // Tuesday
          wednesday, // Wednesday
          thursday, // Thursday
          friday, // Friday
          saturday, // Saturday
        ],
      ),
    );
  }

  _handleSubmit() {
    if (dosageController.text.isEmpty || timeString == 'Time') {
      print('pls fill it out dumbnuts');
    } else {
      monday ? reminder.days.monday = true : reminder.days.monday = false;
      tuesday ? reminder.days.tuesday = true : reminder.days.tuesday = false;
      wednesday
          ? reminder.days.wednesday = true
          : reminder.days.wednesday = false;
      thursday ? reminder.days.thursday = true : reminder.days.thursday = false;
      friday ? reminder.days.friday = true : reminder.days.friday = false;
      saturday ? reminder.days.saturday = true : reminder.days.saturday = false;
      sunday ? reminder.days.sunday = true : reminder.days.sunday = false;
      var doseStringToDouble = double.parse(dosageController.text);
      reminder.dose = doseStringToDouble;
      print(reminder.dose);
      print(reminder.time);
      print(reminder.window);
      print(dosageController.text);
      print(reminder.days.monday);
      print(reminder.days.tuesday);
      print(reminder.days.wednesday);
      print(reminder.days.thursday);
      print(reminder.days.friday);
      print(reminder.days.saturday);
      print(reminder.days.sunday);
      final TherapyManager manager =
          Provider.of<TherapyManager>(context, listen: false);
      manager.therapyForm = AddTherapyForm();
      manager.therapyForm.reminderRules.add(reminder);
      manager.updateListeners();
      print(manager.therapyForm.reminderRules.length);
      Navigator.pop(context);
    }
  }
}
