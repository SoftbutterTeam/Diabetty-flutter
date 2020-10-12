import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AddReminderModal extends StatefulWidget {
  @override
  _AddReminderModalState createState() => _AddReminderModalState();
}

class _AddReminderModalState extends State<AddReminderModal> {
  var dosageController;
  bool monday;
  bool tuesday;
  bool wednesday;
  bool thursday;
  bool friday;
  bool saturday;
  bool sunday;
  Duration initialtimer;
  var time;
  var dateTime;
  var initialDate;
  var window;

  ReminderRule reminder;

  @override
  void initState() {
    super.initState();
    reminder = ReminderRule();
    reminder.days = Days();
    monday = false;
    tuesday = false;
    wednesday = false;
    thursday = false;
    friday = false;
    saturday = false;
    sunday = false;
    initialtimer = Duration();
    time = "00:00";
    window = "00:00";
    dateTime = DateTime.now();
    initialDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, 0);
    dosageController = TextEditingController();
  }

  _showWindow() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xff999999),
                    width: 0.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                    child: Text('Confirm'),
                    onPressed: () {
                      Navigator.pop(context);
                      var timeSelected = initialtimer.toString();
                      var trimmedtimeSelected = timeSelected.lastIndexOf(':');
                      String result = (trimmedtimeSelected != -1)
                          ? timeSelected.substring(0, trimmedtimeSelected)
                          : timeSelected;
                      setState(() {
                        window = result;
                      });
                      print(window);
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: height * 0.35,
                width: width,
                color: Color(0xfff7f7f7),
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  minuteInterval: 5,
                  initialTimerDuration: initialtimer,
                  onTimerDurationChanged: (Duration changedtimer) {
                    setState(() {
                      initialtimer = changedtimer;
                    });
                  },
                )),
          ],
        );
      },
    );
  }

  _showTime() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xff999999),
                    width: 0.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: CupertinoColors.destructiveRed,
                      ),
                    ),
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  ),
                  CupertinoButton(
                    child: Text('Confirm'),
                    onPressed: () {
                      Navigator.pop(context);
                      var timeSelected = dateTime.toString();
                      var trimmedtimeSelected = timeSelected[11] +
                          timeSelected[12] +
                          timeSelected[13] +
                          timeSelected[14] +
                          timeSelected[15];
                      var result = trimmedtimeSelected;
                      print(result);
                      setState(() {
                        time = result;
                      });
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: height * 0.35,
              width: width,
              color: Color(0xfff7f7f7),
              child: CupertinoDatePicker(
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
            ),
          ],
        );
      },
    );
  }

  _saveData() {
    if (dosageController.text.isEmpty || time == '00:00' || window == '00:00') {
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
      manager.therapyForm.reminderRules.add(reminder);
      manager.updateListeners();
      print(manager.therapyForm.reminderRules.length);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return CupertinoAlertDialog(
      title: new Text("Add Reminder"),
      content: Container(
        margin: EdgeInsets.only(top: 20),
        height: height * 0.21,
        width: width,
        child: Column(
          children: <Widget>[
            Container(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        monday = !monday;
                      });
                    },
                    child: Container(
                      height: height * 0.03,
                      width: width * 0.052,
                      decoration: BoxDecoration(
                        color: monday
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text("M").withStyle(
                            fontSize: 15,
                            color: monday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 5,
                    color: Colors.transparent,
                  ).paddingOnly(top: 32, left: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tuesday = !tuesday;
                        print(tuesday);
                      });
                    },
                    child: Container(
                      height: height * 0.03,
                      width: width * 0.052,
                      decoration: BoxDecoration(
                        color: tuesday
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text("T").withStyle(
                            fontSize: 15,
                            color: tuesday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 5,
                    color: Colors.transparent,
                  ).paddingOnly(top: 32, left: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        wednesday = !wednesday;
                        print(wednesday);
                      });
                    },
                    child: Container(
                      height: height * 0.03,
                      width: width * 0.052,
                      decoration: BoxDecoration(
                        color: wednesday
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text("W").withStyle(
                            fontSize: 15,
                            color: wednesday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 5,
                    color: Colors.transparent,
                  ).paddingOnly(top: 32, left: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        thursday = !thursday;
                        print(thursday);
                      });
                    },
                    child: Container(
                      height: height * 0.03,
                      width: width * 0.052,
                      decoration: BoxDecoration(
                        color: thursday
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text("T").withStyle(
                            fontSize: 15,
                            color: thursday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 5,
                    color: Colors.transparent,
                  ).paddingOnly(top: 32, left: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        friday = !friday;
                        print(friday);
                      });
                    },
                    child: Container(
                      height: height * 0.03,
                      width: width * 0.052,
                      decoration: BoxDecoration(
                        color: friday
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text("F").withStyle(
                            fontSize: 15,
                            color: friday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 5,
                    color: Colors.transparent,
                  ).paddingOnly(top: 32, left: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        saturday = !saturday;
                        print(saturday);
                      });
                    },
                    child: Container(
                      height: height * 0.03,
                      width: width * 0.052,
                      decoration: BoxDecoration(
                        color: saturday
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text("S").withStyle(
                            fontSize: 15,
                            color: saturday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 5,
                    color: Colors.transparent,
                  ).paddingOnly(top: 32, left: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sunday = !sunday;
                        print(sunday);
                      });
                    },
                    child: Container(
                      height: height * 0.03,
                      width: width * 0.052,
                      decoration: BoxDecoration(
                        color: sunday
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text("S").withStyle(
                            fontSize: 15,
                            color: sunday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CupertinoTextField(
                // prefix: Text(
                //   'Dose',
                //   style: TextStyle(
                //     fontSize: textSizeLargeMedium - 3,
                //     color: Colors.grey[700],
                //   ),
                // ),
                controller: dosageController,
                keyboardType: TextInputType.number,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                readOnly: false,
                maxLines: 1,
                maxLength: 3,
                placeholder: "Dose",
                padding:
                    EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
                placeholderStyle: TextStyle(
                  fontSize: textSizeLargeMedium - 3,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CupertinoTextField(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                suffix: GestureDetector(
                  onTap: () => _showTime(),
                  child: Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 5, bottom: 2),
                            child: text(time, fontSize: textSizeMedium2)),
                        Icon(
                          CupertinoIcons.right_chevron,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                placeholder: 'Time',
                readOnly: true,
                maxLines: 1,
                maxLength: 30,
                padding:
                    EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
                placeholderStyle: TextStyle(
                  fontSize: textSizeLargeMedium - 3,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CupertinoTextField(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                suffix: GestureDetector(
                  onTap: () => _showWindow(),
                  child: Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 5, bottom: 2),
                            child: text(window, fontSize: textSizeMedium2)),
                        Icon(
                          CupertinoIcons.right_chevron,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                placeholder: 'Window',
                readOnly: true,
                maxLines: 1,
                maxLength: 30,
                padding:
                    EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
                placeholderStyle: TextStyle(
                  fontSize: textSizeLargeMedium - 3,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: new Text("Save"),
          onPressed: () {
            _saveData();
          },
        )
      ],
    );
  }
}
