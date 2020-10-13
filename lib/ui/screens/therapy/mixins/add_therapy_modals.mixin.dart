import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/ui/screens/therapy/components/MinRestPopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/index.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            setState(() {
              
            });
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
            if (therapyForm.strengthUnitsIndex != 0 && therapyForm.strength != null || therapyForm.strength != 0) {
              therapyForm.strength = 100;
            } else if (therapyForm.strengthUnitsIndex  == 0) {
              therapyForm.strength = null;
            }
            setState(() {
         
            });
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
            setState(() {
              
            });
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
            setState(() {
              
            });
            Navigator.pop(context);
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: therapyForm.window,
            onTimerDurationChanged: (Duration changedtimer) {
              therapyForm.minRest = changedtimer;
            },
          ),
        );
      },
    );
  }
}
