import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/screens/therapy/components/IntakePopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/custom_timer_picker.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_stock_dialog.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:diabetty/ui/screens/therapy/components/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@optionalTypeArgs
mixin EditTherapyModalsMixin<T extends StatefulWidget> on State<T> {
  Therapy get therapy;

  showEditStockDialog(BuildContext context, TherapyManager manager) {
    showDialog(
        context: context,
        builder: (context) =>
            EditStockDialog(therapyForm: therapy, manager: manager));
  }

  showMinRestPicker(BuildContext context, Therapy therapy) {
    Duration s;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CustomTimerPicker(
          desciption: 'A period of time set between occurences of required medication.\nPlease select your window time-frame.',
          height: height,
          width: width,
          onPressed: () {
            therapy.medicationInfo.restDuration = s;
            setState(() {});
            Navigator.of(context).pop(context);
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: therapy.medicationInfo.restDuration ?? Duration(minutes: 20),
            onTimerDurationChanged: (Duration changedtimer) {
              s = changedtimer;
            },
          ),
        );
      },
    );
  }


  showWindowPicker(BuildContext context, Therapy therapy) {
    Duration s;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    therapy.schedule.window = therapy.schedule.window ?? Duration(minutes: 20);
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CustomTimerPicker(
          desciption: 'How long you have to take medication or respond',
          height: height,
          width: width,
          onPressed: () {
            therapy.schedule.window = s;
            setState(() {});
            Navigator.of(context).pop(context);
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: therapy.schedule.window ?? Duration(minutes: 20),
            onTimerDurationChanged: (Duration changedtimer) {
              s = changedtimer;
            },
          ),
        );
      },
    );
  }

  showIntakeAdvicePicker(context, Therapy therapy) {
    int s;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IntakePopUp(
          height: height,
          width: width,
          onPressed: () {
            if (therapy.medicationInfo.intakeAdvices.isNotEmpty)
            therapy.medicationInfo.intakeAdvices[0] = s;
            else therapy.medicationInfo.intakeAdvices.add(s);
            setState(() {});
            Navigator.of(context).pop(context);
          },
          intakePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(
                initialItem: therapy.medicationInfo.intakeAdvices[0]),
            itemExtent: 35,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int x) {
              s = x;
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

  showAppearancePicker(BuildContext context, Therapy therapy) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    int s;
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return AppearancePopUp(
            height: height,
            width: width,
            onPressed: () {
              Navigator.pop(context);
              therapy.medicationInfo.appearanceIndex = s;
              setState(() {});
            },
            appearancePicker: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                  initialItem: therapy.medicationInfo.appearanceIndex),
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
                s = index;
              },
            ),
          );
        });
  }

  showUnitPicker(BuildContext context, Therapy therapy) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    int s;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IntakePopUp(
          height: height,
          width: width,
          onPressed: () {
            Navigator.of(context).pop(context);
            therapy.medicationInfo.typeIndex = s;
            setState(() {});
          },
          intakePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: 0),
            itemExtent: 35,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int x) {
              s = x;
            },
            children: new List<Widget>.generate(
              unitTypes.length,
              (int index) {
                return new Center(
                  child: new Text(unitTypes[index].plurarlUnits(3)),
                );
              },
            ),
          ),
        );
      },
    );
  }

  showWindow2(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // therapyForm.schedule.window =
    //     therapyForm.schedule.window ?? Duration(minutes: 20);
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CustomTimerPicker(
          desciption: 'How long you have to take medication or respond',
          height: height,
          width: width,
          onPressed: () {
            setState(() {});
            Navigator.of(context).pop(context);
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: Duration(minutes: 20),
            onTimerDurationChanged: (Duration changedtimer) {
              therapy.schedule.setWindow = changedtimer;
            },
          ),
        );
      },
    );
  }

  showMinRestPopup2(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CustomTimerPicker(
          desciption:
              'A period of time set between occurences of required medication.\nPlease select your window time-frame.',
          height: height,
          width: width,
          onPressed: () {
            setState(() {});
            Navigator.of(context).pop(context);
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: Duration(minutes: 0),
            onTimerDurationChanged: (Duration changedtimer) {
              therapy.medicationInfo.setMinRest = changedtimer;
            },
          ),
        );
      },
    );
  }
}
