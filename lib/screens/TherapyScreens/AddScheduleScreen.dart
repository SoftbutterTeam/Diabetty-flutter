import 'package:diabetttty/components/AddReminderModal.dart';
import 'package:diabetttty/theme/AppColors.dart';
import 'package:diabetttty/theme/AppConstant.dart';
import 'package:diabetttty/theme/AppWidget.dart';
import 'package:diabetttty/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';

const List<String> intakeAdvice = const <String>[
  "Before Meal",
  "After Meal",
  "Before Bed",
  "After Bed",
];

const List<String> modeOptions = const <String>[
  "Scheduled",
  "As Planned",
];

List<Widget> appearanceIcon = <Widget>[
  SvgPicture.asset(
    'images/icons/clock/pills.svg',
    width: 30,
    height: 30,
  ),
  SizedBox(height: 10),
  SvgPicture.asset(
    'images/icons/clock/drugs.svg',
    width: 30,
    height: 30,
  ),
  SizedBox(height: 10),
  SvgPicture.asset(
    'images/icons/clock/drugs (1).svg',
    width: 30,
    height: 30,
  ),
];

class AddScheduleScreen extends StatefulWidget {
  static var tag = "/draftscreen";

  @override
  AddScheduleScreenState createState() => AddScheduleScreenState();
}

class AddScheduleScreenState extends State<AddScheduleScreen> {
  TextEditingController medicationNameController = TextEditingController();
  TextEditingController strengthController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  var strength = "none";
  Widget appearance = Text('none');
  var appearanceHeart = false;
  var intake = "none";
  var minRest = "none";
  var mode = 'Scheduled';
  int _selectedIntakeIndex = 0;
  int _selectedModeIndex = 0;
  int _selectedAppearanceIndex = 0;
  Duration initialtimer = Duration();
  var f = new DateFormat('hh:mm');
  var step = 1;

  bool monday = false;
  var tuesday = false;
  var wednesday = false;
  var thursday = false;
  var friday = false;
  var saturday = false;
  var sunday = false;

  @override
  void initState() {
    super.initState();
  }

  _saveData() {
    (medicationNameController.text.isEmpty ||
            strength == 'none' ||
            appearance == Text('none') ||
            intake == 'none' ||
            minRest == 'none')
        ? print('nah fam srry')
        : setState(() {
            step = 2;
          });
    print(medicationNameController.text);
    print(strength);
    print(appearance);
    print(intake);
    print(minRest);
  }

  _showStrengthDialog() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
        title: new Text("Strength & Units"),
        content: Container(
          margin: EdgeInsets.only(top: 20),
          height: height * 0.12,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: width,
                margin: EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.only(bottom: 10),
                child: CupertinoTextField(
                    keyboardType: TextInputType.number,
                    controller: strengthController,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.black54,
                            width: 0.1,
                            style: BorderStyle.solid),
                      ),
                    ),
                    placeholder: 'Strength...',
                    maxLines: 1,
                    maxLength: 30,
                    padding: EdgeInsets.only(
                        left: 16, top: 9.5, bottom: 9.5, right: 10),
                    style: TextStyle(
                        fontSize: textSizeLargeMedium - 1.5,
                        fontFamily: 'Regular')),
              ),
              Container(
                width: width,
                padding: const EdgeInsets.only(bottom: 10),
                child: CupertinoTextField(
                    keyboardType: TextInputType.text,
                    controller: unitController,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.black54,
                            width: 0.1,
                            style: BorderStyle.solid),
                      ),
                    ),
                    placeholder: 'Units...',
                    maxLines: 1,
                    maxLength: 30,
                    padding: EdgeInsets.only(
                        left: 16, top: 9.5, bottom: 9.5, right: 10),
                    style: TextStyle(
                        fontSize: textSizeLargeMedium - 1.5,
                        fontFamily: 'Regular')),
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text("Save"),
            onPressed: () {
              if (strengthController.text.isEmpty ||
                  unitController.text.isEmpty) {
                showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('Error'),
                        content: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text('Please fill in both fields')),
                        actions: <Widget>[
                          CupertinoDialogAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'))
                        ],
                      );
                    });
              } else {
                print(strengthController.text);
                print(unitController.text);
                Navigator.pop(context);
                setState(() {
                  strength =
                      strengthController.text + ' ' + unitController.text;
                });
              }
            },
          )
        ],
      ),
    );
  }

  _showMinRestPopup() {
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
                      var timeSelected = initialtimer.toString();
                      var trimmedtimeSelected = timeSelected.lastIndexOf(':');
                      String result = (trimmedtimeSelected != -1)
                          ? timeSelected.substring(0, trimmedtimeSelected)
                          : timeSelected;
                      setState(() {
                        minRest = result;
                      });
                      print(minRest);
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

  _showMode() {
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
                      print(modeOptions[_selectedModeIndex]);
                      setState(() {
                        mode = modeOptions[_selectedModeIndex];
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
              child: CupertinoPicker(
                itemExtent: 35,
                backgroundColor: Colors.white,
                onSelectedItemChanged: (int x) {
                  setState(() {
                    _selectedModeIndex = x;
                  });
                },
                children: new List<Widget>.generate(
                  modeOptions.length,
                  (int index) {
                    return new Center(
                      child: new Text(modeOptions[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _showIntakePopUp() {
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
                      print(intakeAdvice[_selectedIntakeIndex]);
                      setState(() {
                        intake = intakeAdvice[_selectedIntakeIndex];
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
              child: CupertinoPicker(
                itemExtent: 35,
                backgroundColor: Colors.white,
                onSelectedItemChanged: (int x) {
                  setState(() {
                    _selectedIntakeIndex = x;
                  });
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
            ),
          ],
        );
      },
    );
  }

  _showAppearance() {
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
                      setState(() {
                        appearance = appearanceIcon[_selectedAppearanceIndex];
                        appearanceHeart = true;
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
              child: CupertinoPicker(
                magnification: 1.5,
                backgroundColor: Colors.white,
                children: <Widget>[
                  SvgPicture.asset(
                    'images/icons/clock/pills.svg',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(height: 10),
                  SvgPicture.asset(
                    'images/icons/clock/drugs.svg',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(height: 10),
                  SvgPicture.asset(
                    'images/icons/clock/drugs (1).svg',
                    width: 30,
                    height: 30,
                  ),
                ],
                itemExtent: 50,
                onSelectedItemChanged: (int index) {
                  print(index);
                  _selectedAppearanceIndex = index;
                },
              ),
            ),
          ],
        );
      },
    );
  }

  _buildMedicationCard() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        setState(() {
          step = 1;
        });
      },
      child: Container(
        height: height * 0.1,
        width: width * 0.9,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[appearance],
                ),
              ),
              Container(
                width: width * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 2),
                      child: Row(
                        children: <Widget>[
                          text(medicationNameController.text,
                              textColor: Colors.black,
                              fontFamily: fontMedium,
                              fontSize: 18.0)
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 2, bottom: 5, top: 2),
                      child: Row(
                        children: <Widget>[
                          text(intake,
                              textColor: Colors.black26,
                              fontFamily: fontRegular,
                              fontSize: 16.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.225,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: height * 0.04,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.more_horiz),
                            onPressed: () {},
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            text(
                              minRest,
                              textColor: Colors.black,
                              fontFamily: fontMedium,
                              fontSize: 12.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            text(
                              strength,
                              textColor: Colors.black,
                              fontFamily: fontMedium,
                              fontSize: 12.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (step == 1) {
      return _firstScreen();
    } else if (step == 2) {
      return _secondScreen();
    }
  }

  Scaffold _firstScreen() {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Center(
                      child: Container(
                        // color: Colors.red,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 1),
                        child: text("Add Medication",
                            //  fontFamily: 'SfPro',
                            fontSize: textSizeMedium),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    child: Container(
                        // color: Colors.green,
                        padding: EdgeInsets.only(top: 5),
                        child: FlatButton(
                          onPressed: () {},
                          disabledTextColor: Colors.grey,
                          disabledColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              print('clicked');
                            },
                            child: Align(
                              child: text('Cancel',
                                  fontSize: textSizeMedium2,
                                  //fontFamily: 'Regular',
                                  textColor: Colors.blue[900]),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        )),
                  ),
                  Positioned(
                    right: 5,
                    child: Container(
                      // color: Colors.blue,
                      padding: EdgeInsets.only(top: 5),
                      child: FlatButton(
                        onPressed: () {
                          print('clickekkekeked');
                          _saveData();

                          print(step);
                        },
                        color: Colors.transparent,
                        disabledTextColor: Colors.grey,
                        disabledColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        child: Align(
                          child: text('Next',
                              fontSize: textSizeMedium2,
                              //fontFamily: 'Regular',
                              textColor: Colors.blue[900]),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: text('Med Info'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: CupertinoTextField(
                      controller: medicationNameController,
                      decoration: BoxDecoration(
                        color: appWhite,
                        border: Border.all(
                            color: Colors.black54,
                            width: 0.1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      prefix: Container(
                        padding: EdgeInsets.only(left: 17),
                        child: Icon(
                          CupertinoIcons.heart,
                          size: 23,
                        ),
                      ),
                      placeholder: 'Medication Name...',
                      maxLines: 1,
                      maxLength: 30,
                      padding: EdgeInsets.only(
                          left: 16, top: 9.5, bottom: 9.5, right: 10),
                      style: TextStyle(
                          fontSize: textSizeLargeMedium - 1.5,
                          fontFamily: 'Regular')),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: Container(
                      padding: EdgeInsets.only(left: 18),
                      child: Icon(
                        (strength == 'none')
                            ? CupertinoIcons.heart
                            : CupertinoIcons.heart_solid,
                        color: (strength == 'none') ? Colors.black : Colors.red,
                        size: 23,
                      ),
                    ),
                    suffix: Container(
                      padding: EdgeInsets.only(right: 15),
                      child: GestureDetector(
                        onTap: () => _showStrengthDialog(),
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 5, bottom: 2),
                                child: text((strength),
                                    fontSize: textSizeMedium2)),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    placeholder: 'Set Strength',
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
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: Container(
                      padding: EdgeInsets.only(left: 18),
                      child: Icon(
                        (appearanceHeart == true)
                            ? CupertinoIcons.heart_solid
                            : CupertinoIcons.heart,
                        color: (appearanceHeart == true)
                            ? Colors.red
                            : Colors.black,
                        size: 23,
                      ),
                    ),
                    suffix: GestureDetector(
                      onTap: () => _showAppearance(),
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 5, bottom: 2),
                                child: appearance),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    placeholder: 'Appearance',
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
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Icon(
                          (intake == 'none')
                              ? CupertinoIcons.heart
                              : CupertinoIcons.heart_solid,
                          color: (intake == 'none') ? Colors.black : Colors.red,
                          size: 23,
                        )),
                    suffix: GestureDetector(
                      onTap: () => _showIntakePopUp(),
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 5, bottom: 2),
                                child: text(intake, fontSize: textSizeMedium2)),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    placeholder: 'Intake Advice',
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
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                  ),
                  child: text('extra details for more assistance features',
                      fontSize: textSizeSmall),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Icon(
                          (minRest == 'none')
                              ? CupertinoIcons.heart
                              : CupertinoIcons.heart_solid,
                          color:
                              (minRest == 'none') ? Colors.black : Colors.red,
                          size: 23,
                        )),
                    suffix: GestureDetector(
                      onTap: () => _showMinRestPopup(),
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 5, bottom: 2),
                                child:
                                    text(minRest, fontSize: textSizeMedium2)),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    placeholder: 'Minimum Rest Duration',
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
          )
        ],
      ),
    );
  }

  _showReminderModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddReminderModal(),
    );
  }

  Scaffold _secondScreen() {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Center(
                      child: Container(
                        // color: Colors.red,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 1),
                        child: text("Add Reminder",
                            //  fontFamily: 'SfPro',
                            fontSize: textSizeMedium),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    child: Container(
                        // color: Colors.green,
                        padding: EdgeInsets.only(top: 5),
                        child: FlatButton(
                          onPressed: () {},
                          disabledTextColor: Colors.grey,
                          disabledColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                step = 1;
                              });
                              print('clicked');
                            },
                            child: Align(
                              child: text('Back',
                                  fontSize: textSizeMedium2,
                                  //fontFamily: 'Regular',
                                  textColor: Colors.blue[900]),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        )),
                  ),
                  Positioned(
                    right: 5,
                    child: Container(
                      // color: Colors.blue,
                      padding: EdgeInsets.only(top: 5),
                      child: FlatButton(
                        onPressed: () {},
                        color: Colors.transparent,
                        disabledTextColor: Colors.grey,
                        disabledColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        child: Align(
                          child: text('Save',
                              fontSize: textSizeMedium2,
                              //fontFamily: 'Regular',
                              textColor: Colors.blue[900]),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 40,
                    ),
                    child: _buildMedicationCard(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: Container(
                      padding: EdgeInsets.only(left: 18),
                      child: Icon(
                        (mode == 'none')
                            ? CupertinoIcons.heart
                            : CupertinoIcons.heart_solid,
                        color: (mode == 'none') ? Colors.black : Colors.red,
                        size: 23,
                      ),
                    ),
                    suffix: GestureDetector(
                      onTap: () => _showMode(),
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 5, bottom: 2),
                                child: text(mode, fontSize: textSizeMedium2)),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    placeholder: 'Mode',
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
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: GestureDetector(
                      onTap: () {
                        _showReminderModal(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Icon(
                          CupertinoIcons.add_circled_solid,
                          color: Colors.green,
                          size: 23,
                        ),
                      ),
                    ),
                    placeholder: 'Add Reminder',
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
                SizedBox(height: height * 0.35),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Icon(
                          CupertinoIcons.shopping_cart,
                          color: Color(0XFF5A5C5E),
                          size: 23,
                        ),
                      ),
                    ),
                    placeholder: 'Inventory',
                    readOnly: true,
                    maxLines: 1,
                    maxLength: 30,
                    padding: EdgeInsets.only(
                        left: 18, top: 9, bottom: 9, right: 10),
                    placeholderStyle: TextStyle(
                      fontSize: textSizeLargeMedium - 3,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Icon(
                          CupertinoIcons.time_solid,
                          color: Color(0XFF5A5C5E),
                          size: 23,
                        ),
                      ),
                    ),
                    placeholder: 'Alarm Settings',
                    readOnly: true,
                    maxLines: 1,
                    maxLength: 30,
                    padding: EdgeInsets.only(
                        left: 18, top: 9, bottom: 9, right: 10),
                    placeholderStyle: TextStyle(
                      fontSize: textSizeLargeMedium - 3,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
