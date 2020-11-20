import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/screens/therapy/components/custom_timer_picker.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_stock_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@optionalTypeArgs
mixin EditTherapyModalsMixin<T extends StatefulWidget> on State<T> {
  Therapy get therapyForm => therapyForm;

  showEditStockDialog(BuildContext context, TherapyManager manager) {
    showDialog(
        context: context,
        builder: (context) =>
            EditStockDialog(therapyForm: therapyForm, manager: manager));
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
            Navigator.pop(context);
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: Duration(minutes: 20),
            onTimerDurationChanged: (Duration changedtimer) {
              therapyForm.schedule.setWindow = changedtimer;
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
              therapyForm.medicationInfo.setMinRest = changedtimer;
            },
          ),
        );
      },
    );
  }


}
