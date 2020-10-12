// import 'package:diabetttty/components/AddReminderModal.dart';
import 'dart:async';
import 'dart:ui';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/therapy/components/alarm_settings_dialog.dart';
import 'package:diabetty/ui/screens/therapy/components/index.dart';
import 'package:diabetty/ui/screens/therapy/components/stock_dialog.dart';
import 'package:diabetty/ui/screens/therapy/components/reminder_rule_field.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';
import "package:diabetty/ui/screens/therapy/extensions/string_extension.dart";

import 'package:diabetty/ui/screens/therapy/components/StrengthTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/add_reminder_modal.v2.dart';
import 'package:diabetty/ui/screens/therapy/components/topbar2.dart';
import 'package:diabetty/ui/screens/therapy/components/date_range_picker.widget.dart'
    as DateRangePicker;

const List<String> intakeAdvice = const <String>[
  "Before Meal",
  "After Meal",
  "Before Bed",
  "After Bed",
];

const List<String> units = const <String>[
  "none",
  "units",
  "Pills",
  "Tabs",
  "Injection",
  "Poweder (That Cokey stuff yeh)",
];

const List<String> strengthUnitList = const <String>[
  "none",
  "mm",
  "ug",
  "ml",
  "cm-3",
  "g",
];

const List<String> modeOptions = const <String>[
  "As Planned",
  "As Needed",
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

class AddMedicationScreenState extends State<AddMedicationScreen>
    with TickerProviderStateMixin {
  final therapyForm = AddTherapyForm();
  ReminderRule reminder;

  TextEditingController medicationNameController;
  TextEditingController strengthController;
  var medicationNameHeart = false;
  var unit = "none";
  var unitHeart = false;
  var strengthUnit = "none";
  var strengthUnitHeart = false;
  var appearance = appearanceIcon[0];
  var appearanceHeart = false;
  var intake = "none";
  var intakeHeart = false;
  var minRest = "none";
  var minRestHeart = false;
  var window = "0:20";
  var windowHeart = true;
  var mode;
  var modeHeart = true;
  var startEndDateString = "From Today";
  var startEndDateStringHeart = true;
  int _selectedIntakeIndex = 0;
  int _selectedModeIndex = 0;
  int _selectedAppearanceIndex = 0;
  int _selectedUnitIndex = 0;
  int _selectedStrengthUnitIndex = 0;
  Duration initialtimer;
  Duration windowTimer = Duration();
  var timeFormatter = new DateFormat('hh:mm');
  var step = 1;
  bool _btnEnabled;
  bool _isVisible = false;
  bool _isAsPlanned = true;
  DateTime startDate;
  DateTime endDate;

  @override
  void initState() {
    super.initState();
    strengthController = TextEditingController();
    reminder = ReminderRule();
    _btnEnabled = false;
    mode = 'planned';
    medicationNameController = TextEditingController();
    windowTimer = Duration(minutes: 20);
    initialtimer = Duration();
    startDate = DateTime.now();
    endDate = DateTime.now();
  }

  _saveAsPlannedData() {
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
    therapyForm.mode = (mode == "none") ? null : mode.toString().toLowerCase();
    (intake == "none")
        ? therapyForm.intakeAdvice = null
        : therapyForm.intakeAdvice = intake;
    therapyForm.apperanceIndex = _selectedAppearanceIndex;

    therapyForm.window = windowTimer;
    therapyForm.startDate = startDate;
    therapyForm.endDate = endDate;
    print(therapyForm.name);
    print(therapyForm.minRest);
    print(therapyForm.strength);
    print(therapyForm.units);
    print(therapyForm.mode);
    print(therapyForm.intakeAdvice);
    print(therapyForm.apperanceIndex);
    print(therapyForm.window);
    print(therapyForm.startDate);
    print(therapyForm.endDate);
  }

  _saveAsNeededData() {
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
    therapyForm.mode = (mode == "none") ? null : mode.toString().toLowerCase();
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

  _saveData() {
    (mode == 'planned') ? _saveAsPlannedData() : _saveAsNeededData();
  }

  bool _firstStepValidation() {
    return (medicationNameController.text.isEmpty);
  }

  _updateStep() {
    setState(() {
      step = 2;
    });
  }

  _nextStep() {
    _firstStepValidation() ? print('hey') : _updateStep();
  }

  _updateWindow() {
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

  _onPressedWindowPopUp() {
    (windowTimer == Duration()) ? print('nah') : _updateWindow();
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
    (mode == "As Planned")
        ? setState(() {
            _isAsPlanned = true;
          })
        : setState(() {
            _isAsPlanned = false;
          });
  }

  _onPressedUnitPopUp() {
    Navigator.pop(context);
    print(units[_selectedUnitIndex]);
    setState(() {
      unit = units[_selectedUnitIndex];
    });
  }

  _onPressedIntakePopUp() {
    Navigator.pop(context);
    print(intakeAdvice[_selectedIntakeIndex]);
    setState(() {
      intake = intakeAdvice[_selectedIntakeIndex];
    });
  }

  _onPressedStrengthUnitPopUp() {
    Navigator.pop(context);
    print(strengthUnitList[_selectedStrengthUnitIndex]);
    (strengthController.text.isEmpty)
        ? setState(() {
            strengthController = TextEditingController(text: '100');
            strengthUnit = strengthUnitList[_selectedStrengthUnitIndex];
          })
        : setState(() {
            strengthUnit = strengthUnitList[_selectedStrengthUnitIndex];
          });
    (strengthUnit == 'none') ? strengthController.clear() : print('heyhey');
  }

  _showStrengthUnitPopUp() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IntakePopUp(
          height: height,
          width: width,
          onPressed: () {
            _onPressedStrengthUnitPopUp();

            setState(() {
              strengthUnitHeart = true;
            });
          },
          intakePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(
                initialItem: _selectedStrengthUnitIndex),
            itemExtent: 35,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int x) {
              setState(() {
                _selectedStrengthUnitIndex = x;
              });
            },
            children: new List<Widget>.generate(
              strengthUnitList.length,
              (int index) {
                return new Center(
                  child: new Text(strengthUnitList[index]),
                );
              },
            ),
          ),
        );
      },
    );
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

            setState(() {
              unitHeart = true;
            });
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
          desciption: 'How long you have to take medication or respond :)',
          height: height,
          width: width,
          onPressed: () {
            setState(() {
              windowHeart = true;
            });
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
          desciption:
              'A period of time set between occurences of required medication.\nPlease select your window time-frame.',
          height: height,
          width: width,
          onPressed: () {
            _onPressedMinRestPopUp();

            setState(() {
              minRestHeart = true;
            });
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
            setState(() {
              modeHeart = true;
            });
            _onPressedModePopUp();
          },
          modePicker: CupertinoPicker(
            scrollController:
                FixedExtentScrollController(initialItem: _selectedModeIndex),
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
            setState(() {
              intakeHeart = true;
            });
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: _buildFirstScreenHeader(),
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: SizedBox(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height * 0.7),
              child: _buildFirstScreenBody(),
            ),
          ),
        ),
      ),
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
          child: _buildUnitField()),
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

  _medicationNameValueEntered() {
    setState(() {
      _isVisible = true;
    });
  }

  InputTextField _buildMedicationNameField() {
    return InputTextField(
      controller: medicationNameController,
      placeholder: 'Medication Name...',
      onChanged: (val) {
        (val == '') ? print('yeye') : _medicationNameValueEntered();
        isEmpty();
      },
      icon: strengthAppearanceHeartIcon(heart: _isVisible),
      icon2: strengthAppearanceHeartIcon2(heart: _isVisible),
    );
  }

  StrengthTextField _buildStrengthField() {
    return StrengthTextField(
      controller: strengthController,
      icon: strengthAppearanceHeartIcon(heart: strengthUnitHeart),
      icon2: strengthAppearanceHeartIcon2(heart: strengthUnitHeart),
      onTap: () {
        _showStrengthUnitPopUp();
      },
      placeholder: strengthUnit,
      placeholderText: 'Set Strength',
    );
  }

  CustomTextField _buildUnitField() {
    return CustomTextField(
      icon: icon(heart: unitHeart),
      icon2: icon2(heart: unitHeart),
      onTap: () => _showUnitPopUp(),
      placeholder: unit,
      placeholderText: 'Unit',
    );
  }

  CustomTextField _buildAppearanceField() {
    return CustomTextField(
      // icon: strengthAppearanceHeartIcon(heart: appearanceHeart),
      icon: strengthAppearanceHeartIcon(heart: appearanceHeart),
      icon2: strengthAppearanceHeartIcon2(heart: appearanceHeart),
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
      icon: icon(heart: intakeHeart),
      icon2: icon2(heart: intakeHeart),
      onTap: () => _showIntakePopUp(),
      placeholder: intake,
      placeholderText: 'Intake Advice',
    );
  }

  CustomTextField _buildMinimumRestField() {
    return CustomTextField(
      icon: icon(heart: minRestHeart),
      icon2: icon2(heart: minRestHeart),
      onTap: () => _showMinRestPopup(),
      placeholder: minRest,
      placeholderText: 'Minimum Rest Duration',
    );
  }

  Scaffold _secondScreen() {
    // print(widget.manager.therapyForm.reminderRules.length);

    var size = MediaQuery.of(context).size;

    var height = MediaQuery.of(context).size.height;
    List<Widget> reminderRulesList =
        (widget.manager.therapyForm.reminderRules == null ||
                widget.manager.therapyForm.reminderRules.length == 0)
            ? List()
            : widget.manager.therapyForm.reminderRules
                .map((e) => ReminderRuleField(textstyle: textstyle, rule: e))
                .toList()
                .cast();
    // ..add(_buildAddReminderField());
    return Scaffold(
      appBar: _buildSecondScreenHeader(),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: SizedBox(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height * 0.9),
              child: Column(
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
                        Visibility(
                            visible: _isAsPlanned, child: _buildWindowField()),
                        Visibility(
                            visible: _isAsPlanned,
                            child: _buildStartEndDateField()),
                        Visibility(
                          visible: _isAsPlanned,
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
                        if (reminderRulesList.length > 0)
                          (reminderRulesList.length < 20)
                              ? Visibility(
                                  visible: _isAsPlanned,
                                  child: ColumnBuilder(
                                    itemCount: reminderRulesList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return reminderRulesList[index];
                                    },
                                  ),
                                )
                              : _buildListViewRep(context, reminderRulesList),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: FractionalOffset.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildAlarmSettingsField(),
                              _buildStockField(),
                            ],
                          ))),
                  SizedBox(height: height * 0.08),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddReminderField() {
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
      icon: icon(heart: windowHeart),
      icon2: icon2(heart: windowHeart),
      onTap: () => _showWindow(),
      placeholder: window,
      placeholderText: 'Window',
    );
  }

  toggleMode() {
    (mode == "needed")
        ? setState(() {
            mode = "planned";
            modeHeart = true;
          })
        : setState(() {
            mode = "needed";
          });
    (mode == "planned")
        ? setState(() {
            _isAsPlanned = true;
          })
        : setState(() {
            _isAsPlanned = false;
          });
  }

  CustomTextField _buildModeField() {
    return CustomTextField(
      icon: icon(heart: modeHeart),
      icon2: icon2(heart: modeHeart),
      onTap: () => toggleMode(),
      placeholder: 'As ' + mode.toString().capitalize(),
      placeholderText: 'Mode',
    );
  }

  _showStartEndDateValidation(List<DateTime> picked) {
    final DateFormat formatter = DateFormat('dd-MM-yy');

    var now = DateTime.now();
    final String nowFormatted = formatter.format(now);

    final String formatted = formatter.format(picked[0]); // First date selected

    final String formatted2 =
        formatter.format(picked[1]); // Second date selected

    var selectedStartEndDate = formatted + ' to ' + formatted2;
    var todayStartEndDate = 'Today to ' + formatted2;

    (nowFormatted == formatted)
        ? setState(() {
            startEndDateString = todayStartEndDate;
            startEndDateStringHeart = true;
          })
        : setState(() {
            startEndDateString = selectedStartEndDate;
            startEndDateStringHeart = true;
          });

    (nowFormatted == formatted && nowFormatted == formatted2)
        ? setState(() {
            startEndDateString = 'From Today';
            startEndDateStringHeart = true;
          })
        : print('something');

    startDate = picked[0];
    endDate = picked[1];
  }

  _showStartEndDate() async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: new DateTime.now(),
        initialLastDate: new DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 1)),
        lastDate: new DateTime(2026, 12, 31));
    if (picked != null && picked.length == 2) {
      _showStartEndDateValidation(picked);
    }
  }

  CustomTextField _buildStartEndDateField() {
    return CustomTextField(
      icon: icon(heart: startEndDateStringHeart),
      icon2: icon2(heart: startEndDateStringHeart),
      onTap: () => _showStartEndDate(),
      placeholder: startEndDateString,
      placeholderText: 'Start - End Date',
    );
  }

  CustomTextField _buildStockField() {
    return CustomTextField(
      icon: icon(heart: startEndDateStringHeart),
      icon2: icon2(heart: startEndDateStringHeart),
      // icon: Icon(
      //   CupertinoIcons.shopping_cart,
      //   color: Colors.black,
      //   size: 23,
      // ),
      onTap: () {
        _showStockDialog();
      },
      placeholderText: 'Stock',
    );
  }

  _showStockDialog() {
    showDialog(context: context, builder: (context) => StockDialog());
  }

  _showAlarmSettingsDialog() {
    showDialog(context: context, builder: (context) => AlarmSettingsDialog());
  }

  CustomTextField _buildAlarmSettingsField() {
    return CustomTextField(
      icon: icon(heart: startEndDateStringHeart),
      icon2: icon2(heart: startEndDateStringHeart),
      // icon: Icon(
      //   CupertinoIcons.shopping_cart,
      //   color: Colors.black,
      //   size: 23,
      // ),
      onTap: () {
        _showAlarmSettingsDialog();
      },
      placeholderText: 'Alarm Settings',
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

  AnimatedOpacity strengthAppearanceHeartIcon({var heart}) {
    return AnimatedOpacity(
      opacity: heart ? 0 : 1,
      duration: Duration(milliseconds: 1000),
      child: Icon(
        CupertinoIcons.heart,
        color: Colors.black,
        size: 23,
      ),
    );
  }

  AnimatedOpacity strengthAppearanceHeartIcon2({var heart}) {
    return AnimatedOpacity(
      opacity: heart ? 1 : 0,
      duration: Duration(milliseconds: 1000),
      child: Icon(
        CupertinoIcons.heart_solid,
        color: Colors.red,
        size: 23,
      ),
    );
  }

  AnimatedOpacity icon({var heart}) {
    return AnimatedOpacity(
      opacity: heart ? 0 : 1,
      duration: Duration(milliseconds: 1000),
      child: Icon(
        CupertinoIcons.heart,
        color: Colors.black,
        size: 23,
      ),
    );
  }

  AnimatedOpacity icon2({var heart}) {
    return AnimatedOpacity(
      opacity: heart ? 1 : 0,
      duration: Duration(milliseconds: 1000),
      child: Icon(
        CupertinoIcons.heart_solid,
        color: Colors.red,
        size: 23,
      ),
    );
  }

  _showReminderModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddReminderModal2(),
    );
  }

  var textstyle = TextStyle(
    letterSpacing: 1.0,
    fontFeatures: [
      FontFeature.proportionalFigures(),
    ],
    fontSize: textSizeLargeMedium - 3,
    color: Colors.grey[700],
  );
}
