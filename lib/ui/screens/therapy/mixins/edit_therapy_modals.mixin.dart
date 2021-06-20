import 'dart:ui';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/therapy.service.dart';
import 'package:diabetty/ui/screens/therapy/components/IntakePopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/add_reminder_modal.v2.dart';
import 'package:diabetty/ui/screens/therapy/components/add_reminder_modal_3.dart';
import 'package:diabetty/ui/screens/therapy/components/custom_timer_picker.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_reminder_modal.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_stock_dialog.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:diabetty/ui/screens/therapy/components/index.dart';
import 'package:diabetty/ui/screens/therapy/components/refill_dialog.dart';
import 'package:diabetty/ui/screens/therapy/components/take_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@optionalTypeArgs
mixin EditTherapyModalsMixin<T extends StatefulWidget> on State<T> {
  Therapy get therapy;
  TherapyService therapyService = TherapyService();

  _transitionBuilderStyle1() =>
      (BuildContext context, Animation<double> anim1, anim2, Widget child) {
        bool isReversed = anim1.status == AnimationStatus.reverse;
        double animValue = isReversed ? 0 : anim1.value;
        var size = MediaQuery.of(context).size;
        return SafeArea(
          child: BackdropFilter(
            filter:
                ImageFilter.blur(sigmaX: 8 * animValue, sigmaY: 8 * animValue),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: size.height * .1),
              child: FadeTransition(
                opacity: anim1,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: GestureDetector(
                        onTapDown: (TapDownDetails tp) =>
                            Navigator.pop(context),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    child,
                  ],
                ),
              ),
            ),
          ),
        );
      };

  Future<void> saveTherapy(Therapy therapy) {
    if (therapy.id == null || therapy.userId == null) return null;
    try {
      therapyService.saveTherapy(therapy);
    } catch (e) {
      print(e);
    }
  }

  void showEditReminderModal(
          BuildContext context, Therapy therapy, ReminderRule rule) =>
      showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        barrierColor: Colors.black12, //black12 white
        pageBuilder: (context, anim1, anim2) => Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          child: EditReminderModal2(therapyForm: therapy, rule: rule),
        ),
        transitionBuilder: _transitionBuilderStyle1(),
        transitionDuration: Duration(milliseconds: 250),
      );

  // showEditReminderModal2(BuildContext context, Therapy therapy) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AddReminderModal3(therapyForm: therapy),
  //   );
  // }

  void showRefillDialog(BuildContext context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      barrierColor: Colors.black12, //black12 white
      pageBuilder: (context, anim1, anim2) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: RefillDialog(therapyForm: therapy),
      ),
      transitionBuilder: _transitionBuilderStyle1(),
      transitionDuration: Duration(milliseconds: 250),
    );
  }

  void showTakenModal(BuildContext context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      barrierColor: Colors.black12, //black12 white
      pageBuilder: (context, anim1, anim2) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: TakeModal(therapy: therapy),
      ),
      transitionBuilder: _transitionBuilderStyle1(),
      transitionDuration: Duration(milliseconds: 250),
    );
  }

  void showEditReminderModal2(BuildContext context, Therapy therapy) =>
      showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        barrierColor: Colors.black12, //black12 white
        pageBuilder: (context, anim1, anim2) => Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          child: AddReminderModal3(therapyForm: therapy),
        ),
        transitionBuilder: _transitionBuilderStyle1(),
        transitionDuration: Duration(milliseconds: 250),
      );

  void showEditStockDialog2(BuildContext context) => showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        barrierColor: Colors.black12, //black12 white
        pageBuilder: (context, anim1, anim2) => Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          child: EditStockDialog(therapyForm: therapy),
        ),
        transitionBuilder: _transitionBuilderStyle1(),
        transitionDuration: Duration(milliseconds: 250),
      );

  showMinRestPicker(BuildContext context, Therapy therapy) {
    Duration s;
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
            therapy.medicationInfo.restDuration = s;
            setState(() {});
            Navigator.pop(context);
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration:
                therapy.medicationInfo.restDuration ?? Duration(minutes: 20),
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
          desciption: 'Time given to respond to reminder',
          height: height,
          width: width,
          onPressed: () {
            therapy.schedule.window = s;
            setState(() {});
            Navigator.pop(context);
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration:
                therapy.schedule.window ?? Duration(minutes: 20),
            onTimerDurationChanged: (Duration changedtimer) {
              s = changedtimer;
            },
          ),
        );
      },
    );
  }

  showIntakeAdvicePicker(context, Therapy therapy) {
    int s = therapy.medicationInfo.intakeAdvices[0];
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
            else
              therapy.medicationInfo.intakeAdvices.add(s);
            setState(() {});
            Navigator.pop(context);
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
    int s = therapy.medicationInfo.typeIndex;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IntakePopUp(
          height: height,
          width: width,
          onPressed: () {
            Navigator.pop(context);
            therapy.medicationInfo.typeIndex = s;
            setState(() {});
          },
          intakePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: s),
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
          desciption: 'Time given to respond to reminder',
          height: height,
          width: width,
          onPressed: () {
            setState(() {});
            Navigator.pop(context);
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
            Navigator.pop(context);
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

  void showYesOrNoActionsheet(context, therapy, {BuildContext prevContext}) {
    BuildContext mainContext = context;
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text('Are you sure?'),
        actions: [
          CupertinoActionSheetAction(
            child: Text("Yes"),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop(context);
              therapyService.deleteTherapy(therapy);
              Navigator.of(mainContext).pop(context);
              if (prevContext != null) {
                Navigator.of(prevContext).pop(context);
              }
            },
          ),
          CupertinoActionSheetAction(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Container(color: Colors.white, child: Text('Cancel')),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
      ),
    );
  }
}
