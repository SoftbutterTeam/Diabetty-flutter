import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/ui/screens/therapy/components/MinRestPopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/add_reminder_modal.v2.dart';
import 'package:diabetty/ui/screens/therapy/components/alarm_settings_dialog.dart';
import 'package:diabetty/ui/screens/therapy/components/index.dart';
import 'package:diabetty/ui/screens/therapy/components/stock_dialog.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:diabetty/ui/screens/therapy/components/date_range_picker.widget.dart'
    as DateRangePicker;

@optionalTypeArgs
mixin AddTherapyModalsMixin<T extends StatefulWidget> on State<T> {
  AddTherapyForm get therapyForm => therapyForm;

  void showUnitPopUp(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IntakePopUp(
          height: height,
          width: width,
          onPressed: () {
            Navigator.pop(context);
            setState(() {});
          },
          intakePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(
                initialItem: therapyForm.unitsIndex),
            itemExtent: 35,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int x) {
              therapyForm.unitsIndex = x;
            },
            children: new List<Widget>.generate(
              unitTypes.length,
              (int index) {
                return new Center(
                  child: new Text(unitTypes[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void showStrengthUnitPopUp(
      BuildContext context, TextEditingController strengthController) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IntakePopUp(
          height: height,
          width: width,
          onPressed: () {
            Navigator.pop(context);
            if (therapyForm.strengthUnitsIndex != 0 &&
                (therapyForm.strength == null || therapyForm.strength == 0)) {
              therapyForm.strength = 100;
              strengthController.text = '100';
            } else if (therapyForm.strengthUnitsIndex == 0) {
              therapyForm.strength = null;
              strengthController.text = '';
            }
            setState(() {});
          },
          intakePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(
                initialItem: therapyForm.strengthUnitsIndex),
            itemExtent: 35,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int x) {
              therapyForm.strengthUnitsIndex = x;
            },
            children: new List<Widget>.generate(
              strengthUnits.length,
              (int index) {
                return new Center(
                  child: new Text(strengthUnits[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void showAppearance(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return AppearancePopUp(
            height: height,
            width: width,
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            appearancePicker: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                  initialItem: therapyForm.apperanceIndex),
              magnification: 1,
              backgroundColor: Colors.white,
              children: List<Widget>.generate(
                appearance_iconss.length,
                (int index) {
                  return new Center(
                    child: SvgPicture.asset(
                      appearance_iconss[index],
                      width: 30,
                      height: 30,
                    ),
                  );
                },
              ),
              itemExtent: 50,
              onSelectedItemChanged: (int index) {
                therapyForm.apperanceIndex = index;
              },
            ),
          );
        });
  }

  void showIntakePopUp() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IntakePopUp(
          height: height,
          width: width,
          onPressed: () {
            setState(() {});
            Navigator.pop(context);
          },
          intakePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(
                initialItem: therapyForm.intakeAdviceIndex),
            itemExtent: 35,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int x) {
              therapyForm.intakeAdviceIndex = x;
            },
            children: new List<Widget>.generate(
              intakeAdvice.length,
              (int index) {
                return new Center(
                  child: new Text(intakeAdvice[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void showMinRestPopup(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return MinRestPopUp(
          desciption:
              'A period of time set between occurences of required medication.\nPlease select your window time-frame.',
          height: height,
          width: width,
          onPressed: () {
            setState(() {});
            Navigator.pop(context);
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: therapyForm.minRest ?? Duration(minutes: 0),
            onTimerDurationChanged: (Duration changedtimer) {
              therapyForm.setMinRest = changedtimer;
            },
          ),
        );
      },
    );
  }

  void showWindow(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return MinRestPopUp(
          desciption: 'How long you have to take medication or respond :)',
          height: height,
          width: width,
          onPressed: () {
            setState(() {});
            Navigator.pop(context);
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: therapyForm.window,
            onTimerDurationChanged: (Duration changedtimer) {
              therapyForm.setWindow = changedtimer;
            },
          ),
        );
      },
    );
  }

  showStartEndDate(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: DateTime.now(),
        initialLastDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 1)),
        lastDate: new DateTime(2026, 12, 31));
    if (picked != null && picked.length > 0) {
      if (picked.length > 1 && isSameDayAs(picked[0], picked[1]))
        picked.removeAt(1);
      print(picked);
      therapyForm.startDate = picked[0];
      therapyForm.endDate = picked[1];
      setState(() {});
    } else if (picked.length == 1) {
      therapyForm.startDate = picked[0];
      therapyForm.endDate = null;
      setState(() {});
    }
  }

  showAlarmSettingsDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlarmSettingsDialog());
  }

  showStockDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => StockDialog());
  }

  showReminderModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddReminderModal2(),
    );
  }

  bool isSameDayAs(DateTime date, DateTime datey) {
    if (datey.day != date.day) return false;
    if (datey.month != date.month) return false;
    if (datey.year != date.year) return false;
    return true;
  }
}
