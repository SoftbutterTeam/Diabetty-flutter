import 'package:weekday_selector/weekday_selector.dart';

import 'package:diabetttty/components/index.dart';

import 'package:diabetttty/theme/Extension.dart';
import 'package:diabetttty/theme/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:nb_utils/nb_utils.dart';

const List<String> units = const <String>[
  'Pills',
  'Powerder',
  'Thing',
  'Another Thing',
];

const List<String> intake = const <String>[
  'Before Meals',
  'After Meals',
  'Empty Stomach',
  'Before Bed',
];

class AddMedication extends StatefulWidget {
  @override
  _AddMedicationState createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  int _selectedIndex = 0;
  int _intakeIndex = 0;
  int _refillIndex = 0;
  int timerLength = 14;
  int intervalLength = 14;
  final values = List.filled(7, true);
  var unitString = 'units';
  var refillValue = 'refill';
  var intervalString;
  var intakeString = 'intake';
  var intervalValue = "interval";
  var timeValue = 'time';
  var intakeValue = "Before meal";
  Duration initialtimer = new Duration();
  Duration initialtime = new Duration();
  var list = new List<int>.generate(10, (i) => i + 1);

  var btn2 = false;
  var step = 1;
  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.white);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // _convertTimer(time) {
    //   int timeLength = time.length;
    //   return (timeLength == 14) ? time[0] + ':' + time[2] + time[3] : time[0] + time[1] + ':' + time[2] + time[3];
    // }

    _reset() {
      setState(() {
        unitString = 'units';
        refillValue = 'refill';
        intervalValue = "interval";
        intakeString = 'intake';
      });
      print('reset');
    }

    _saveData() {
      print(unitString);
      print(refillValue);
      print(intakeString);
      print(initialtimer);
      setState(() {
        step = 2;
        btn2 = true;
      });
      _reset();
    }

    _showTime() {
      changeStatusColor(Colors.transparent);
      showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: height * 0.3,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: CupertinoColors.destructiveRed),
                          ),
                          onPressed: () {
                            print('Clicked Off');
                            Navigator.pop(context);
                          }),
                      CupertinoButton(
                          child: Text(
                            'Save',
                            style: TextStyle(color: CupertinoColors.activeBlue),
                          ),
                          onPressed: () {
                            print('Clicked');
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  Container(
                    child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hm,
                      minuteInterval: 15,
                      initialTimerDuration: initialtime,
                      onTimerDurationChanged: (Duration changedtimers) {
                        setState(() {
                          initialtime = changedtimers;
                        });

                        print('changedtimers == ' + changedtimers.toString());
                        print('initialtime == ' + initialtime.toString());

                        print('initialtime == ' + initialtime.toString());

                        print('timeValue == ' + timeValue.toString());
                        timeValue = initialtime.toString();
                        int timeValueLength = timeValue.length;
                        (timeValueLength == 15)
                            ? setState(() {
                                timerLength = 15;
                              })
                            : setState(() {
                                timerLength = 14;
                              });
                        print(
                            'timevaluelenth == ' + timeValueLength.toString());
                        print('@@@@@');
                        print((timerLength == 14)
                            ? initialtime.toString()[0] +
                                ':' +
                                initialtime.toString()[2] +
                                initialtime.toString()[3]
                            : initialtime.toString()[0] +
                                initialtime.toString()[1] +
                                ':' +
                                initialtime.toString()[3] +
                                initialtime.toString()[4]);
                      },
                    ),
                  ),
                ],
              ),
            );
          });
    }

    _showInterval() {
      changeStatusColor(Colors.transparent);
      showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: height * 0.3,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: CupertinoColors.destructiveRed),
                          ),
                          onPressed: () {
                            print('Clicked Off');
                            Navigator.pop(context);
                          }),
                      CupertinoButton(
                          child: Text(
                            'Save',
                            style: TextStyle(color: CupertinoColors.activeBlue),
                          ),
                          onPressed: () {
                            print('Clicked');
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  Container(
                    child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hm,
                      minuteInterval: 15,
                      initialTimerDuration: initialtimer,
                      onTimerDurationChanged: (Duration changedtimer) {
                        setState(() {
                          initialtimer = changedtimer;
                        });
                        intervalValue = initialtimer.toString();
                        int intervalValueLength = intervalValue.length;
                        (intervalValueLength == 15)
                            ? setState(() {
                                intervalLength = 15;
                              })
                            : setState(() {
                                intervalLength = 14;
                              });
                        print(initialtimer.toString()[0] +
                            ':' +
                            initialtimer.toString()[2] +
                            initialtimer.toString()[3]);
                            print('@@@@@');
                        print((intervalLength == 14)
                            ? initialtimer.toString()[0] +
                                ':' +
                                initialtimer.toString()[2] +
                                initialtimer.toString()[3]
                            : initialtimer.toString()[0] +
                                initialtimer.toString()[1] +
                                ':' +
                                initialtimer.toString()[3] +
                                initialtimer.toString()[4]);
                      },
                    ),
                  ),
                ],
              ),
            );
          });
    }

    _showUnits() {
      changeStatusColor(Colors.transparent);
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: height * 0.3,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                        child: Text(
                          'Cancel',
                          style:
                              TextStyle(color: CupertinoColors.destructiveRed),
                        ),
                        onPressed: () {
                          print('Clicked Off');
                          Navigator.pop(context);
                        }),
                    CupertinoButton(
                        child: Text(
                          'Save',
                          style: TextStyle(color: CupertinoColors.activeBlue),
                        ),
                        onPressed: () {
                          print('Clicked');
                          Navigator.pop(context);
                        }),
                  ],
                ),
                Container(
                  height: height * 0.2,
                  child: CupertinoPicker(
                      backgroundColor: Colors.transparent,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          _selectedIndex = index;
                          unitString = units[_selectedIndex];
                        });
                        print('You have selected ' + units[_selectedIndex]);
                      },
                      itemExtent: 32.0,
                      children:
                          List<Widget>.generate(units.length, (int index) {
                        return new Center(
                          child: new Text(units[index]),
                        );
                      })),
                ),
              ],
            ),
          );
        },
      );
    }

    _showIntake() {
      changeStatusColor(Colors.transparent);
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: height * 0.3,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: CupertinoColors.destructiveRed),
                          ),
                          onPressed: () {
                            print('Clicked Off');
                            Navigator.pop(context);
                          }),
                      CupertinoButton(
                          child: Text(
                            'Save',
                            style: TextStyle(color: CupertinoColors.activeBlue),
                          ),
                          onPressed: () {
                            print('Clicked');
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  Container(
                    height: height * 0.2,
                    child: CupertinoPicker(
                        backgroundColor: Colors.transparent,
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            _intakeIndex = index;
                            intakeString = intake[_intakeIndex];
                          });
                          print('You have selected ' + intake[_intakeIndex]);
                        },
                        itemExtent: 32.0,
                        children:
                            List<Widget>.generate(intake.length, (int index) {
                          return new Center(
                            child: new Text(intake[index]),
                          );
                        })),
                  ),
                ],
              ),
            );
          });
    }

    _showRefill() {
      changeStatusColor(Colors.transparent);
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: height * 0.3,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                        child: Text(
                          'Cancel',
                          style:
                              TextStyle(color: CupertinoColors.destructiveRed),
                        ),
                        onPressed: () {
                          print('Clicked Off');
                          Navigator.pop(context);
                        }),
                    CupertinoButton(
                        child: Text(
                          'Save',
                          style: TextStyle(color: CupertinoColors.activeBlue),
                        ),
                        onPressed: () {
                          print('Clicked');
                          Navigator.pop(context);
                        }),
                  ],
                ),
                Container(
                  height: height * 0.2,
                  child: CupertinoPicker(
                      backgroundColor: Colors.transparent,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          _refillIndex = index;
                          refillValue = list[_refillIndex].toString();
                        });
                        print('You have selected ' +
                            list[_refillIndex].toString());
                      },
                      itemExtent: 32.0,
                      children: List<Widget>.generate(list.length, (int index) {
                        return new Center(
                          child: new Text(list[index].toString()),
                        );
                      })),
                ),
              ],
            ),
          );
        },
      );
    }

    final name = TextInputs(
      hintText: "Name",
    );

    final add = Container(
      margin: EdgeInsets.only(top: 10),
      height: height * 0.8,
      child: Column(
        children: <Widget>[
          Wrap(
            runSpacing: 20,
            children: <Widget>[
              SizedBox(height: 20),
              Padding(padding: const EdgeInsets.only(top: 20), child: name),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => _showUnits(),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    height: 60,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        text("Units",
                            fontFamily: fontBold, fontSize: textSizeMedium),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: width * 0.3,
                          child: text(unitString,
                              fontFamily: fontRegular,
                              fontSize: textSizeMedium),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => _showIntake(),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    height: 60,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        text("Intake",
                            fontFamily: fontBold, fontSize: textSizeMedium),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: width * 0.3,
                          child: text(intakeString,
                              fontFamily: fontRegular,
                              fontSize: textSizeMedium),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => _showInterval(),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    height: 60,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        text('Interval',
                            fontFamily: fontBold, fontSize: textSizeMedium),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: width * 0.3,
                          child: text(
                                  (intervalLength == 14)
                                      ? initialtimer.toString()[0] +
                                          ':' +
                                          initialtimer.toString()[2] +
                                          initialtimer.toString()[3]
                                      : initialtimer.toString()[0] +
                                          initialtimer.toString()[1] +
                                          ':' +
                                          initialtimer.toString()[3] +
                                          initialtimer.toString()[4],
                                  fontFamily: fontRegular,
                                  fontSize: textSizeMedium),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => _showRefill(),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    height: 60,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        text("Refill",
                            fontFamily: fontBold, fontSize: textSizeMedium),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: width * 0.3,
                          child: text(refillValue,
                              fontFamily: fontRegular,
                              fontSize: textSizeMedium),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: width * 0.4,
                  child: RoundedButton(
                      textContent: "Reset",
                      onPressed: () {
                        _reset();
                      }),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  width: width * 0.4,
                  child: RoundedButton(
                      textContent: "Next",
                      onPressed: () {
                        _saveData();
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final reminder = Container(
      height: height * 0.8,
      child: Column(
        children: <Widget>[
          Wrap(
            runSpacing: 20,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: WeekdaySelector(
                  fillColor: Colors.white,
                  selectedFillColor:
                      Theme.of(context).primaryColor.withOpacity(0.6),
                  onChanged: (int day) {
                    setState(() {
                      // Use module % 7 as Sunday's index in the array is 0 and
                      // DateTime.sunday constant integer value is 7.
                      final index = day % 7;
                      // We "flip" the value in this example, but you may also
                      // perform validation, a DB write, an HTTP call or anything
                      // else before you actually flip the value,
                      // it's up to your app's needs.
                      values[index] = !values[index];
                    });

                    print('values[6] ' + values[6].toString());
                    print((values[6] == true)
                        ? 'Saturday Slected'
                        : 'Saturday not sleected');
                    print('values[5] ' + values[5].toString());
                    print('values[4] ' + values[4].toString());
                    print('values[3] ' + values[3].toString());
                    print('values[2] ' + values[2].toString());
                    print('values[1] ' + values[1].toString());
                    print('values[0] ' + values[0].toString());
                  },
                  values: values,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 2, color: Colors.black),
                          bottom: BorderSide(width: 2, color: Colors.black),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => _showTime(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            text("Time",
                                fontFamily: fontBold, fontSize: textSizeMedium),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              width: width * 0.3,
                              child: text(
                                  (timerLength == 14)
                                      ? initialtime.toString()[0] +
                                          ':' +
                                          initialtime.toString()[2] +
                                          initialtime.toString()[3]
                                      : initialtime.toString()[0] +
                                          initialtime.toString()[1] +
                                          ':' +
                                          initialtime.toString()[3] +
                                          initialtime.toString()[4],
                                  fontFamily: fontRegular,
                                  fontSize: textSizeMedium),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );

    final stepView =
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      MaterialButton(
        child: Text("1").withStyle(fontSize: 18, color: whiteColor),
        color: Theme.of(context).primaryColor,
        minWidth: 50,
        height: 50,
        onPressed: () {
          setState(() {
            btn2 = false;
            step = 1;
          });
        },
      ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 20),
      Container(
        height: 1,
        width: 250,
        color: Colors.black12,
      ).paddingOnly(top: 32, left: 8),
      MaterialButton(
        child: Text("2").withStyle(
            fontSize: 18,
            color: btn2 ? whiteColor : Theme.of(context).primaryColor),
        color: btn2 ? Theme.of(context).primaryColor : whiteColor,
        minWidth: 50,
        height: 50,
        onPressed: () {
          setState(() {
            btn2 = true;
            step = 2;
          });
        },
      ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 8),
    ]);

    selectedWidget() {
      if (step == 1) {
        return add;
      } else {
        return reminder;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: text((step == 1) ? "Add Medication" : "Add Reminder",
            textColor: Colors.black, fontFamily: fontRegular),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[stepView, selectedWidget()],
          ).paddingOnly(top: 16),
        ),
      ),
    );
  }
}
