import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/ui/screens/therapy/components/MinRestPopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@optionalTypeArgs
mixin AddTherapyModalsMixin<T extends StatefulWidget> on State<T> {
  get therapyForm => therapyForm;

  void showUnitPopUp(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IntakePopUp(
          height: height,
          width: width,
          onPressed: () {},
          intakePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: 0),
            itemExtent: 35,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int x) {},
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
          onPressed: () {},
          intakePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: 0),
            itemExtent: 35,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int x) {
              setState(() {});
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
          onPressed: () {},
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: therapyForm.window,
            onTimerDurationChanged: (Duration changedtimer) {},
          ),
        );
      },
    );
  }
}
