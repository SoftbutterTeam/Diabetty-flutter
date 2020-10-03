// import 'package:diabetttty/components/AddReminderModal.dart';
import 'dart:ui';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/theraphy/components/index.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

List<String> appearanceIcon = <String>[
  'assets/icons/navigation/essentials/pills.svg',
  'assets/icons/navigation/essentials/drugs.svg',
  'assets/icons/navigation/essentials/drugs (1).svg',
];

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

  final _addMedicationKey = GlobalKey<FormState>();

  TextEditingController medicationNameController = TextEditingController();
  TextEditingController strengthController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  var strength = "none";
  var appearance = 'none';
  var appearanceHeart = false;
  var intake = "none";
  var minRest = "none";
  var mode = 'Scheduled';
  int _selectedIntakeIndex = 0;
  int _selectedModeIndex = 0;
  int _selectedAppearanceIndex = 0;
  Duration initialtimer = Duration();
  var timeFormatter = new DateFormat('hh:mm');
  var step = 1;

  // therapyForm.minRest = minRest as Duration;
  //       therapyForm.strength = strengthController.text as int;
  //     therapyForm.units = unitController.text;
  // therapyForm.mode = mode;
  // therapyForm.intakeAdvice = intake as List<String>;

  @override
  void initState() {
    super.initState();
  }

  _saveData() {
    therapyForm.name = medicationNameController.text;
    therapyForm.minRest = initialtimer;
    var tempStrength = strengthController.text;
    var strengthInt = int.parse(tempStrength);
    therapyForm.strength = strengthInt;
    therapyForm.units = unitController.text;
    therapyForm.mode = mode;
    therapyForm.intakeAdvice = intake;
    print(therapyForm.name);
    print(therapyForm.minRest);
    print(therapyForm.strength);
    print(therapyForm.units);
    print(therapyForm.mode);
    print(therapyForm.intakeAdvice);
  }

  bool _firstStepValidation() {
    return (medicationNameController.text.isEmpty ||
        strength == 'none' ||
        appearance == 'none' ||
        intake == 'none' ||
        minRest == 'none');
  }

  _nextStep() {
    _firstStepValidation()
        ? print('hey')
        : setState(() {
            step = 2;
          });
    print(therapyForm.minRest);
  }

  _onPressedStrengthDialog() {
    if (strengthController.text.isEmpty || unitController.text.isEmpty) {
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
      Navigator.pop(context);
      setState(() {
        strength = strengthController.text + ' ' + unitController.text;
      });
    }
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
  }

  _onPressedIntakePopUp() {
    Navigator.pop(context);
    print(intakeAdvice[_selectedIntakeIndex]);
    setState(() {
      intake = intakeAdvice[_selectedIntakeIndex];
    });
  }

  _showStrengthDialog() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (_) => StrengthDialog(
        height: height,
        width: width,
        strenghtController: strengthController,
        unitController: unitController,
        strength: strength,
        onPressed: () {
          _onPressedStrengthDialog();
        },
      ),
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

  String _formSave() {
    _addMedicationKey.currentState.save();
    return null;
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
        child: TopBar(
          centerText: 'Add Medication',
          leftButtonText: 'Cancel',
          rightButtonText: 'Next',
          onLeftTap: () {
            Navigator.pop(context);
          },
          onRightTap: () {
            _nextStep();
          },
        ),
      ),
      body: Form(
        key: _addMedicationKey,
        child: Column(
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
                  InputTextField(
                    controller: medicationNameController,
                    placeholder: 'Medication Name...',
                    onSubmitted: (String value) =>
                        therapyForm.name = value.trim(),
                  ),
                  CustomTextField(
                    icon: Icon(
                      (strength == 'none')
                          ? CupertinoIcons.heart
                          : CupertinoIcons.heart_solid,
                      color: (strength == 'none') ? Colors.black : Colors.red,
                      size: 23,
                    ),
                    onTap: () => _showStrengthDialog(),
                    placeholder: strength,
                    placeholderText: 'Set Strength & Units',
                  ),
                  CustomTextField(
                    icon: Icon(
                      (appearanceHeart == true)
                          ? CupertinoIcons.heart_solid
                          : CupertinoIcons.heart,
                      color:
                          (appearanceHeart == true) ? Colors.red : Colors.black,
                      size: 23,
                    ),
                    onTap: () => _showAppearance(),
                    placeholder: (appearance == 'none')
                        ? 'none'
                        : SvgPicture.asset(
                            appearance,
                            width: 30,
                            height: 30,
                          ),
                    placeholderText: 'Appearance',
                  ),
                  CustomTextField(
                    icon: Icon(
                      (intake == 'none')
                          ? CupertinoIcons.heart
                          : CupertinoIcons.heart_solid,
                      color: (intake == 'none') ? Colors.black : Colors.red,
                      size: 23,
                    ),
                    onTap: () => _showIntakePopUp(),
                    placeholder: intake,
                    placeholderText: 'Intake Advice',
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
                  CustomTextField(
                    icon: Icon(
                      (minRest == 'none')
                          ? CupertinoIcons.heart
                          : CupertinoIcons.heart_solid,
                      color: (minRest == 'none') ? Colors.black : Colors.red,
                      size: 23,
                    ),
                    onTap: () => _showMinRestPopup(),
                    placeholder: minRest,
                    placeholderText: 'Minimum Rest Duration',
                    onSubmitted: (String value) {
                      therapyForm.minRest = value as Duration;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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

  Scaffold _secondScreen() {
    print(widget.manager.therapyForm.reminderRules.length);
    var height = MediaQuery.of(context).size.height;
    List<Widget> widgets = (widget.manager.therapyForm.reminderRules == null ||
            widget.manager.therapyForm.reminderRules.length == 0)
        ? List()
        : widget.manager.therapyForm.reminderRules
            .map((e) => CupertinoTextField(
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
                      CupertinoIcons.minus_circled,
                      color: Colors.red,
                      size: 23,
                    ),
                  ),
                  suffix: Container(child: Text('01:00 AM', style: textstyle)),
                  placeholder: 'M  T  W  T  F  S  S',
                  readOnly: true,
                  maxLines: 1,
                  maxLength: 30,
                  padding:
                      EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
                  placeholderStyle: textstyle,
                  style: textstyle,
                ) as Widget)
            .toList()
            .cast();
    widgets.add(CupertinoTextField(
      onTap: () {
        widget.manager.therapyForm.reminderRules.add(ReminderRule());
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
    ) as Widget);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: TopBar(
          centerText: 'Add Reminder',
          leftButtonText: 'Back',
          rightButtonText: 'Save',
          onLeftTap: () {
            setState(() {
              step = 1;
            });
          },
          onRightTap: () {
            // TODO save data function
            _saveData();
          },
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
                CustomTextField(
                  icon: Icon(
                    (mode == 'none')
                        ? CupertinoIcons.heart
                        : CupertinoIcons.heart_solid,
                    color: (mode == 'none') ? Colors.black : Colors.red,
                    size: 23,
                  ),
                  onTap: () => _showMode(),
                  placeholder: mode,
                  placeholderText: 'Mode',
                ),
                Column(
                  children: [
                    CupertinoTextField(
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
                          CupertinoIcons.minus_circled,
                          color: Colors.red,
                          size: 23,
                        ),
                      ),
                      suffix:
                          Container(child: Text('01:00 AM', style: textstyle)),
                      placeholder: 'M  T  W  T  F  S  S',
                      readOnly: true,
                      maxLines: 1,
                      maxLength: 30,
                      padding: EdgeInsets.only(
                          left: 18, top: 9, bottom: 9, right: 10),
                      placeholderStyle: textstyle,
                      style: textstyle,
                    ),
                    CupertinoTextField(
                      onTap: () {
                        _showReminderModal(context);
                      },
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
                          CupertinoIcons.minus_circled,
                          color: Colors.red,
                          size: 23,
                        ),
                      ),
                      placeholder: 'M      W  T  F  S  S',
                      readOnly: true,
                      maxLines: 1,
                      maxLength: 30,
                      padding: EdgeInsets.only(
                          left: 18, top: 9, bottom: 9, right: 10),
                      placeholderStyle: textstyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CupertinoTextField(
                        onTap: () {
                          _showReminderModal(context);
                        },
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
                            CupertinoIcons.add_circled_solid,
                            color: Colors.green,
                            size: 23,
                          ),
                        ),
                        placeholder: 'Add Reminder',
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
                if (widgets.length > 0)
                  (widgets.length < 7)
                      ? ColumnBuilder(
                          itemCount: widgets.length,
                          itemBuilder: (BuildContext context, int index) {
                            return widgets[index];
                          },
                        )
                      : _buildListViewRep(context, widgets),
                CustomTextField(
                  icon: Icon(
                    CupertinoIcons.shopping_cart,
                    color: Color(0XFF5A5C5E),
                    size: 23,
                  ),
                  onTap: () {},
                  placeholderText: 'Inventory',
                ),
                CustomTextField(
                  icon: Icon(
                    CupertinoIcons.time_solid,
                    color: Color(0XFF5A5C5E),
                    size: 23,
                  ),
                  onTap: () {},
                  placeholderText: 'Alarm Settings',
                ),
              ],
            ),
          ),
        ],
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
}
