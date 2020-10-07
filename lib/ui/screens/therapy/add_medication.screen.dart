// import 'package:diabetttty/components/AddReminderModal.dart';
import 'dart:ui';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/theraphy/components/date_range_picker.dart'
    as DateRangePicker;
import 'package:diabetty/ui/screens/therapy/components/index.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'components/StrengthTextField.dart';
import 'components/topbar2.dart';

const List<String> intakeAdvice = const <String>[
  "Before Meal",
  "After Meal",
  "Before Bed",
  "After Bed",
];

const List<String> units = const <String>[
  "none",
  "units",
  "mg",
  "mL",
  "ug",
  "mm",
];

const List<String> modeOptions = const <String>[
  "Scheduled",
  "As Planned",
];

List<String> appearanceIcon = appearance_icons;

class AddMedicationScreenBuilder extends StatefulWidget {
  @override
  _AddMedicationScreenBuilderState createState() =>
      _AddMedicationScreenBuilderState();
}

class _AddMedicationScreenBuilderState
    extends State<AddMedicationScreenBuilder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TherapyManager>(
        builder: (_, manager, ___) => AddMedicationScreen._(manager: manager));
  }
}

class AddMedicationScreen extends StatefulWidget {
  static var tag = "/draftscreen";

  const AddMedicationScreen._({Key key, this.manager}) : super(key: key);
  final TherapyManager manager;

  @override
  AddMedicationScreenState createState() => AddMedicationScreenState();
}

class AddMedicationScreenState extends State<AddMedicationScreen> {
  final therapyForm = AddTherapyForm();

  TextEditingController medicationNameController;
  TextEditingController strengthController;
  var unit = "none";
  var unitHeart = false;
  var appearance = appearanceIcon[0];
  var appearanceHeart = false;
  var intake = "none";
  var intakeHeart = false;
  var minRest = "none";
  var minRestHeart = false;
  var window = "none";
  var windowHeart = false;
  var mode;
  var modeHeart = false;
  var startEndDateString = "none";
  var startEndDateStringHeart = false;
  int _selectedIntakeIndex = 0;
  int _selectedModeIndex = 0;
  int _selectedAppearanceIndex = 0;
  int _selectedUnitIndex = 0;
  Duration initialtimer = Duration();
  Duration windowTimer = Duration();
  var timeFormatter = new DateFormat('hh:mm');
  var step = 1;
  bool _btnEnabled;
  bool _isVisible  = false;
  bool _isAsPlanned  = false;

  @override
  void initState() {
    super.initState();
    strengthController = TextEditingController();
    _btnEnabled = false;
    mode = 'Scheduled';
    medicationNameController = TextEditingController();
  }

  _saveData() {
    therapyForm.name = medicationNameController.text;
    therapyForm.minRest = initialtimer;
    var tempStrength;
    var strengthInt;
    (strengthController.text.isEmpty)
        ? therapyForm.strength = null
        : tempStrength = strengthController.text;
    (strengthController.text.isEmpty)
        ? therapyForm.strength = null
        : strengthInt = int.parse(tempStrength);
    therapyForm.strength = strengthInt;
    (unit == "none") ? therapyForm.units = null : therapyForm.units = unit;
    (mode == "none") ? therapyForm.mode = null : therapyForm.mode = mode;
    (intake == "none")
        ? therapyForm.intakeAdvice = null
        : therapyForm.intakeAdvice = intake;
    therapyForm.apperanceIndex = _selectedAppearanceIndex;
    print(therapyForm.name);
    print(therapyForm.minRest);
    print(therapyForm.strength);
    print(therapyForm.units);
    print(therapyForm.mode);
    print(therapyForm.intakeAdvice);
    print(therapyForm.apperanceIndex);
  }

  bool _firstStepValidation() {
    return (medicationNameController.text.isEmpty);
  }

  _nextStep() {
    _firstStepValidation()
        ? print('hey')
        : setState(() {
            step = 2;
          });
  }

  _onPressedWindowPopUp() {
    Navigator.pop(context);
    var windowSelected = windowTimer.toString();
    var formattedWindowTime = windowSelected.lastIndexOf(':');
    String result = (formattedWindowTime != -1)
        ? windowSelected.substring(0, formattedWindowTime)
        : windowSelected;
    setState(() {
      window = result;
    });
  }

  _onPressedMinRestPopUp() {
    Navigator.pop(context);
    var timeSelected = initialtimer.toString();
    var trimmedtimeSelected = timeSelected.lastIndexOf(':');
    String result = (trimmedtimeSelected != -1)
        ? timeSelected.substring(0, trimmedtimeSelected)
        : timeSelected;
    setState(() {
      minRest = result;
    });
  }

  _onPressedModePopUp() {
    Navigator.pop(context);
    print(modeOptions[_selectedModeIndex]);
    setState(() {
      mode = modeOptions[_selectedModeIndex];
    });
    (mode == "Scheduled")
        ? setState(() {
            _isAsPlanned = false;
          })
        : setState(() {
            _isAsPlanned = true;
      });
  }

  _onPressedUnitPopUp() {
    Navigator.pop(context);
    print(units[_selectedUnitIndex]);
    (strengthController.text.isEmpty)
        ? setState(() {
            strengthController = TextEditingController(text: '100');
            unit = units[_selectedUnitIndex];
          })
        : setState(() {
            unit = units[_selectedUnitIndex];
          });
    (unit == 'none') ? strengthController.clear() : print('heyhey');
  }

  _onPressedIntakePopUp() {
    Navigator.pop(context);
    print(intakeAdvice[_selectedIntakeIndex]);
    setState(() {
      intake = intakeAdvice[_selectedIntakeIndex];
    });
  }

  _showUnitPopUp() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IntakePopUp(
          height: height,
          width: width,
          onPressed: () {
            _onPressedUnitPopUp();
          },
          intakePicker: CupertinoPicker(
            scrollController:
                FixedExtentScrollController(initialItem: _selectedUnitIndex),
            itemExtent: 35,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int x) {
              setState(() {
                _selectedUnitIndex = x;
              });
            },
            children: new List<Widget>.generate(
              units.length,
              (int index) {
                return new Center(
                  child: new Text(units[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }

  _showWindow() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return MinRestPopUp(
          height: height,
          width: width,
          onPressed: () {
            _onPressedWindowPopUp();
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: windowTimer,
            onTimerDurationChanged: (Duration changedtimer) {
              setState(() {
                windowTimer = changedtimer;
              });
            },
          ),
        );
      },
    );
  }

  _showMinRestPopup() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return MinRestPopUp(
          height: height,
          width: width,
          onPressed: () {
            _onPressedMinRestPopUp();
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: initialtimer,
            onTimerDurationChanged: (Duration changedtimer) {
              setState(() {
                initialtimer = changedtimer;
              });
            },
          ),
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
        return ModePopUp(
          height: height,
          width: width,
          onPressed: () {
            _onPressedModePopUp();
          },
          modePicker: CupertinoPicker(
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
        return IntakePopUp(
          height: height,
          width: width,
          onPressed: () {
            _onPressedIntakePopUp();
          },
          intakePicker: CupertinoPicker(
            scrollController:
                FixedExtentScrollController(initialItem: _selectedIntakeIndex),
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
        return AppearancePopUp(
          height: height,
          width: width,
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              appearance = appearanceIcon[_selectedAppearanceIndex];
              appearanceHeart = true;
            });
          },
          appearancePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(
                initialItem: _selectedAppearanceIndex),
            magnification: 1,
            backgroundColor: Colors.white,
            children: List<Widget>.generate(
              appearanceIcon.length,
              (int index) {
                return new Center(
                  child: SvgPicture.asset(
                    appearanceIcon[index],
                    width: 30,
                    height: 30,
                  ),
                );
              },
            ),
            itemExtent: 50,
            onSelectedItemChanged: (int index) {
              print(index);
              _selectedAppearanceIndex = index;
            },
          ),
        );
      },
    );
  }

  _buildMedicationCard() {
    return MedicationCard(
      name: medicationNameController.text,
      appearance: appearance,
    );
  }

  isEmpty() {
    (medicationNameController.text.isNotEmpty)
        ? setState(() {
            _btnEnabled = true;
          })
        : setState(() {
            _btnEnabled = false;
          });
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: _buildFirstScreenHeader(),
      ),
      body: _buildFirstScreenBody(),
    );
  }

  TopBar _buildFirstScreenHeader() {
    return TopBar(
      btnEnabled: _btnEnabled,
      centerText: 'Add Medication',
      leftButtonText: 'Cancel',
      rightButtonText: 'Next',
      onLeftTap: () {
        Navigator.pop(context);
      },
      onRightTap: () {
        (medicationNameController.text.isEmpty) ? print('nah') : _nextStep();
      },
    );
  }

  Column _buildFirstScreenBody() {
    var children2 = <Widget>[
      Padding(
        padding: EdgeInsets.only(
          bottom: 20,
        ),
        child: text('Med Info'),
      ),
      _buildMedicationNameField(),
      AnimatedOpacity(
          opacity: _isVisible ? 1 : 0,
          duration: Duration(milliseconds: 900),
          child: _buildStrengthField()),
      AnimatedOpacity(
          opacity: _isVisible ? 1 : 0,
          duration: Duration(milliseconds: 900),
          child: _buildAppearanceField()),
      AnimatedOpacity(
          opacity: _isVisible ? 1 : 0,
          duration: Duration(milliseconds: 900),
          child: _buildIntakeAdviceField()),
      AnimatedOpacity(
        opacity: _isVisible ? 1 : 0,
        duration: Duration(milliseconds: 900),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: 10,
            bottom: 10,
          ),
          child: text('extra details for more assistance features',
              fontSize: textSizeSmall),
        ),
      ),
      AnimatedOpacity(
          opacity: _isVisible ? 1 : 0,
          duration: Duration(milliseconds: 900),
          child: _buildMinimumRestField()),
    ];
    return Column(children: <Widget>[
      SizedBox(
        height: 20,
      ),
      Container(
        child: Column(
          children: children2,
        ),
      ),
    ]);
  }

  InputTextField _buildMedicationNameField() {
    return InputTextField(
      controller: medicationNameController,
      placeholder: 'Medication Name...',
      onChanged: (val) {
        (val == '')
            ? print('yeye')
            : setState(() {
                _isVisible = true;
              });
        isEmpty();
      },
      icon: (medicationNameController.text.isEmpty)
          ? Icon(
              CupertinoIcons.heart,
              size: 23,
            )
          : Icon(CupertinoIcons.heart_solid, color: Colors.red, size: 23),
    );
  }

  StrengthTextField _buildStrengthField() {
    return StrengthTextField(
      controller: strengthController,
      icon: icon(name: unit),
      onTap: () => _showUnitPopUp(),
      placeholder: unit,
      placeholderText: 'Set Strength & Units',
    );
  }

  CustomTextField _buildAppearanceField() {
    return CustomTextField(
      icon: appearanceicon(name: appearanceHeart),
      onTap: () => _showAppearance(),
      placeholder: (appearance == 'none')
          ? 'none'
          : SvgPicture.asset(
              appearance,
              width: 25,
              height: 25,
            ),
      placeholderText: 'Appearance',
    );
  }

  CustomTextField _buildIntakeAdviceField() {
    return CustomTextField(
      icon: icon(name: intake),
      onTap: () => _showIntakePopUp(),
      placeholder: intake,
      placeholderText: 'Intake Advice',
    );
  }

  CustomTextField _buildMinimumRestField() {
    return CustomTextField(
      icon: icon(name: minRest),
      onTap: () => _showMinRestPopup(),
      placeholder: minRest,
      placeholderText: 'Minimum Rest Duration',
      onSubmitted: (String value) {
        therapyForm.minRest = value as Duration;
      },
    );
  }

  Scaffold _secondScreen() {
    print(widget.manager.therapyForm.reminderRules.length);
    var height = MediaQuery.of(context).size.height;
    List<Widget> widgets = (widget.manager.therapyForm.reminderRules == null ||
            widget.manager.therapyForm.reminderRules.length == 0)
        ? List()
        : widget.manager.therapyForm.reminderRules
            .map((e) => _buildReminderField())
            .toList()
            .cast();
    widgets.add(CupertinoTextField(
      onTap: () {
        widget.manager.therapyForm.reminderRules
            .add(ReminderRule(forceGenerateUID: true));
        widget.manager.updateListeners();
        //_showReminderModal(context);
      },
      decoration: BoxDecoration(
        color: appWhite,
        border: Border.all(
            color: Colors.black54, width: 0.1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(0),
      ),
      prefix: Container(
        padding: EdgeInsets.only(left: 18),
        child: Icon(
          CupertinoIcons.add_circled_solid,
          color: Colors.green,
          size: 23,
        ),
      ),
      placeholder: 'Add Reminder',
      readOnly: true,
      maxLines: 1,
      maxLength: 30,
      padding: EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
      placeholderStyle: TextStyle(
        fontSize: textSizeLargeMedium - 3,
        color: Colors.grey[700],
      ),
    ));
    return Scaffold(
      appBar: _buildSecondScreenHeader(),
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
                      bottom: 20,
                    ),
                    child: _buildMedicationCard(),
                  ),
                ),
                _buildModeField(),
                AnimatedOpacity(
                    opacity: _isAsPlanned ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    child: _buildWindowField()),
                AnimatedOpacity(
                    opacity: _isAsPlanned ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    child: _buildStartEndDateField()),
                AnimatedOpacity(
                  opacity: _isAsPlanned ? 1 : 0,
                  duration: Duration(milliseconds: 300),
                  child: Column(
                    children: [
                      // _buildReminderField(),
                      // CupertinoTextField(
                      //   onTap: () {
                      //     _showReminderModal(context);
                      //   },
                      //   decoration: BoxDecoration(
                      //     color: appWhite,
                      //     border: Border.all(
                      //         color: Colors.black54,
                      //         width: 0.1,
                      //         style: BorderStyle.solid),
                      //     borderRadius: BorderRadius.circular(0),
                      //   ),
                      //   prefix: Container(
                      //     padding: EdgeInsets.only(left: 18),
                      //     child: Icon(
                      //       CupertinoIcons.minus_circled,
                      //       color: Colors.red,
                      //       size: 23,
                      //     ),
                      //   ),
                      //   placeholder: 'M      W  T  F  S  S',
                      //   readOnly: true,
                      //   maxLines: 1,
                      //   maxLength: 30,
                      //   padding: EdgeInsets.only(
                      //       left: 18, top: 9, bottom: 9, right: 10),
                      //   placeholderStyle: textstyle,
                      // ),
                      _buildAddReminderField(),
                    ],
                  ),
                ),
                if (widgets.length > 0)
                  (widgets.length < 7)
                      ? AnimatedOpacity(
                          opacity: _isAsPlanned ? 1 : 0,
                          duration: Duration(milliseconds: 300),
                          child: ColumnBuilder(
                            itemCount: widgets.length,
                            itemBuilder: (BuildContext context, int index) {
                              return widgets[index];
                            },
                          ),
                        )
                      : _buildListViewRep(context, widgets),
              ],
            ),
          ),
          Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: _buildStockField())),
          SizedBox(height: height * 0.08),
        ],
      ),
    );
  }

  CupertinoTextField _buildReminderField() {
    return CupertinoTextField(
      decoration: BoxDecoration(
        color: appWhite,
        border: Border.all(
            color: Colors.black54, width: 0.1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(0),
      ),
      prefix: Container(
        padding: EdgeInsets.only(left: 18),
        child: Icon(
          CupertinoIcons.minus_circled,
          color: Colors.red,
          size: 23,
        ),
      ),
      suffix: Container(
          padding: EdgeInsets.only(right: 15),
          child: Text('01:00 AM', style: textstyle)),
      placeholder: 'M  T  W  T  F  S  S',
      readOnly: true,
      maxLines: 1,
      maxLength: 30,
      padding: EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
      placeholderStyle: textstyle,
      style: textstyle,
    );
  }

  Padding _buildAddReminderField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CupertinoTextField(
        onTap: () {
          _showReminderModal(context);
        },
        decoration: BoxDecoration(
          color: appWhite,
          border: Border.all(
              color: Colors.black54, width: 0.1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(0),
        ),
        prefix: Container(
          padding: EdgeInsets.only(left: 18),
          child: Icon(
            CupertinoIcons.add_circled_solid,
            color: Colors.green,
            size: 23,
          ),
        ),
        placeholder: 'Add Reminder',
        readOnly: true,
        maxLines: 1,
        maxLength: 30,
        padding: EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
        placeholderStyle: TextStyle(
          fontSize: textSizeLargeMedium - 3,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  CustomTextField _buildWindowField() {
    return CustomTextField(
      icon: icon(name: window),
      onTap: () => _showWindow(),
      placeholder: window,
      placeholderText: 'Window',
    );
  }

  CustomTextField _buildModeField() {
    return CustomTextField(
      icon: icon(name: mode),
      onTap: () => _showMode(),
      placeholder: mode,
      placeholderText: 'Mode',
    );
  }

  _showStartEndDate() async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: new DateTime.now(),
        initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2025));
    if (picked != null && picked.length == 2) {
      print(picked);
      var p = picked.toString();
      var selectedStartEndDate = p[9] +
          p[10] +
          p[8] +
          p[6] +
          p[7] +
          ' to ' +
          p[34] +
          p[35] +
          p[8] +
          p[31] +
          p[32];
      print(selectedStartEndDate);
      setState(() {
        startEndDateString = selectedStartEndDate;
      });
    }
  }

  CustomTextField _buildStartEndDateField() {
    return CustomTextField(
      icon: icon(name: startEndDateString),
      onTap: () => _showStartEndDate(),
      placeholder: startEndDateString,
      placeholderText: 'Start - End Date',
    );
  }

  CustomTextField _buildStockField() {
    return CustomTextField(
      icon: Icon(
        CupertinoIcons.shopping_cart,
        color: Color(0XFF5A5C5E),
        size: 23,
      ),
      onTap: () {},
      placeholderText: 'Stock',
    );
  }

  PreferredSize _buildSecondScreenHeader() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: TopBar2(
        centerText: 'Add Reminder',
        leftButtonText: 'Back',
        rightButtonText: 'Save',
        onLeftTap: () {
          setState(() {
            step = 1;
          });
        },
        onRightTap: () {
          _saveData();
        },
      ),
    );
  }

  _buildListViewRep(BuildContext context, List<Widget> widgets) {
    var size = MediaQuery.of(context).size;
    Widget addRem = widgets.cast().last as Widget;

    List<Widget> mywidgets = List.from(widgets);
    mywidgets.removeLast();
    return Container(
        child: Column(
      children: [
        SizedBox(
            height: size.height * 0.3,
            child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: mywidgets.cast())),
        addRem
      ],
    ));
  }

  Icon appearanceicon({var name}) {
    return Icon(
      (name == true) ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
      color: (name == true) ? Colors.red : Colors.black,
      size: 23,
    );
  }

  Icon icon({var name}) {
    return Icon(
      (name != 'none') ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
      color: (name != 'none') ? Colors.red : Colors.black,
      size: 23,
    );
  }

  _showReminderModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddReminderModal(),
    );
  }

  var textstyle = TextStyle(
    letterSpacing: 1.0,
    fontFeatures: [
      // FontFeature.tabularFigures(),
      FontFeature.proportionalFigures(),
    ],
    fontSize: textSizeLargeMedium - 3,
    color: Colors.grey[700],
  );
}
