import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/timerpicker.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:intl/intl.dart';
import 'package:diabetty/extensions/timeofday_extension.dart';
import 'package:diabetty/extensions/datetime_extension.dart';

class EditReminderModal2 extends StatefulWidget {
  final Therapy therapyForm;
  final ReminderRule rule;
  final TherapyManager manager;

  EditReminderModal2({this.therapyForm, this.manager, this.rule});
  @override
  _EditReminderModal2State createState() => _EditReminderModal2State();
}

class _EditReminderModal2State extends State<EditReminderModal2> {
  ReminderRule reminder;
  bool _isFilled;
  int lastTapped;
  TextEditingController dosageController;
  String timeString;
  DateTime initialDate;
  DateTime timeSelected;
  Days days;

  @override
  void initState() {
    super.initState();
    final rules = widget.therapyForm?.schedule?.reminderRules;
    if (rules != null) {
      days = Days.fromDays(rules.isNotEmpty ? widget.rule.days : Days());
      dosageController = TextEditingController(
          text: (widget.rule.dose == null)
              ? ''
              : widget.rule.dose.toString()); //TODO use widget.rule
      timeSelected = getInitialTime();

      initialDate = timeSelected;
      reminder = ReminderRule();
      reminder.days = Days();
      _isFilled = ((dosageController.text.isNotEmpty && days.isADaySelected))
          ? true
          : false;
      timeString = timeSelected.formatTime();
    } else {
      days = Days.fromDays(Days());
      dosageController = TextEditingController();
      timeSelected = getInitialTime();

      initialDate = timeSelected;
      reminder = ReminderRule();
      reminder.days = Days();
      _isFilled = ((dosageController.text.isNotEmpty && days.isADaySelected))
          ? true
          : false;
      timeString = timeSelected.formatTime();
    }
  }

  DateTime getInitialTime() {
    if (widget.therapyForm.schedule?.reminderRules == null ||
        widget.therapyForm.schedule.reminderRules.isEmpty)
      return DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 00);
    else
      return widget.rule.time.applyTimeOfDay();
    // .add(widget.therapyForm.medicationInfo.restDuration ??
    //     Duration(hours: 4))
  }

  @override
  void dispose() {
    dosageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height * 0.35,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: size.width * 0.8,
          child: Column(
            children: [
              _buildDaySelector(size),
              _buildTimeField(size),
              _buildDosageField(size),
              _buildCancelAndSubmitButtons(),
            ],
          ),
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
              child: Text('cancel',
                  style: TextStyle(
                    color: CupertinoColors.destructiveRed,
                  )),
              onPressed: () {
                Navigator.pop(context);
                // print(initialDate);
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              )),
          CupertinoButton(
              child: Text('save',
                  style: TextStyle(
                    color: _isFilled ? Colors.indigo : Colors.black26,
                  )),
              onPressed: () {
                if (_isFilled) {
                  _handleSubmit();
                }
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              ))
        ],
      ),
    );
  }

  Container _buildTimeField(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 15),
      height: size.height * 0.045,
      width: size.width * 0.5,
      child: CupertinoTextField(
        textAlign: TextAlign.center,
        enableInteractiveSelection: false,
        onTap: () {
          _showTimePicker();
        },
        placeholder: timeString,
        placeholderStyle: (timeString == 'Time')
            ? TextStyle(
                fontSize: textSizeLargeMedium - 3,
                color: Colors.grey[700],
              )
            : TextStyle(
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
    final hourAndMin = DateFormat.jm().format(timeSelected);
    setState(() {
      timeString = hourAndMin;
    });
    // print(hourAndMin);
    Navigator.pop(context);
  }

  _showTimePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return TimerPicker(
          onConfirm: () {
            if (timeSelected.minute % 5 == 0) {
              _updateTime();
              allFieldsFilled();
            } else {
              // print('naw way fam');
            }
            // print(timeSelected);
          },
          timepicker: CupertinoDatePicker(
            use24hFormat: false,
            mode: CupertinoDatePickerMode.time,
            minuteInterval: 5,
            initialDateTime: timeSelected,
            onDateTimeChanged: (dateTimeChange) {
              timeSelected = dateTimeChange;
              setState(() {});
              // print(initialDate);
            },
          ),
        );
      },
    );
  }

  Container _buildDosageField(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: size.height * 0.045,
      width: size.width * 0.5,
      // color: Colors.red,
      child: CupertinoTextField(
        textAlign: TextAlign.center,
        controller: dosageController,
        placeholder: "Dosage",
        placeholderStyle: TextStyle(
          fontSize: textSizeLargeMedium - 3,
          color: Colors.grey[700],
        ),
        onChanged: (val) {
          allFieldsFilled();
        },
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
    switch (v) {
      case 1:
        setState(() {
          days.monday = !days.monday;
        });
        break;
      case 2:
        setState(() {
          days.tuesday = !days.tuesday;
        });
        break;
      case 3:
        setState(() {
          days.wednesday = !days.wednesday;
        });
        break;
      case 4:
        setState(() {
          days.thursday = !days.thursday;
        });
        break;
      case 5:
        setState(() {
          days.friday = !days.friday;
        });
        break;
      case 6:
        setState(() {
          days.saturday = !days.saturday;
        });
        break;
      case 7:
        setState(() {
          days.sunday = !days.sunday;
        });
        break;
    }
    // print(v);
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
          allFieldsFilled();
        },
        values: [
          days.sunday, // Sunday
          days.monday, // Monday
          days.tuesday, // Tuesday
          days.wednesday, // Wednesday
          days.thursday, // Thursday
          days.friday, // Friday
          days.saturday, // Saturday
        ],
      ),
    );
  }

  _handleSubmit() {
    widget.rule.days = days;
    var doseStringToDouble = int.parse(dosageController.text);
    widget.rule.dose = doseStringToDouble;
    widget.rule.time = TimeOfDay.fromDateTime(timeSelected);
    final TherapyManager manager =
        Provider.of<TherapyManager>(context, listen: false);

    // manager.therapyForm.reminderRules.add(reminder);
    manager.updateListeners();
    // print(manager.therapyForm.reminderRules.length);
    Navigator.pop(context);
  }

  allFieldsFilled() {
    if (dosageController.text.isNotEmpty && days.isADaySelected) {
      setState(() {
        _isFilled = true;
      });
    } else {
      setState(() {
        _isFilled = false;
      });
    }
  }
}
