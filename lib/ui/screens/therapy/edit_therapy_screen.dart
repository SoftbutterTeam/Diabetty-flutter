import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/therapy/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/InputTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/error_modal.dart';
import 'package:diabetty/ui/screens/therapy/components/profile_custom_textfield.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_option_background.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_options_header.dart';
import 'package:diabetty/ui/screens/therapy/edit_reminder.screen.dart';
import 'package:diabetty/ui/screens/therapy/mixins/edit_therapy_modals.mixin.dart';
import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EditTherapyScreen extends StatefulWidget {
  final Therapy therapy;

  EditTherapyScreen({this.therapy});

  @override
  _EditTherapyScreenState createState() => _EditTherapyScreenState();
}

class _EditTherapyScreenState extends State<EditTherapyScreen>
    with EditTherapyModalsMixin {
  TextEditingController medicationNameController = TextEditingController();
  Therapy newTherapy;
  TherapyManager manager;

  @override
  Therapy get therapy => widget.therapy;

  @override
  void initState() {
    super.initState();
    newTherapy = Therapy()
      ..loadFromJson(therapy.toJson()); //TODO therapy = newTheraoyee
  }

  @override
  Widget build(BuildContext context) {
    manager = Provider.of<TherapyManager>(context, listen: true);
    return SnoozeOptionsBackground(
        header: SnoozeOptionsHeader(
          text: 'save',
          backFunction: () {
            Navigator.pop(context);
            // _back();
          },
          saveFunction: () {
            _save();
          },
        ),
        child: _body(context));
  }

  _save() {
    if (medicationNameController.text.isEmpty) {
      return _showErrorModal(context);
    } else {
      therapy.medicationInfo.name = medicationNameController.text;
      therapy.loadFromJson(newTherapy.toJson());
      saveTherapy(newTherapy);
      manager.updateListeners();
      Navigator.pop(context);
    }
  }

  Future _showErrorModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => NoResponseErrorModal(
        errorDescription: 'Please do not leave medication name empty',
      ),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: _buildBody(size),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 25.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _buildDeleteField(context),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(Size size) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        _buildMedicationNameField(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: _buildUnitField(context),
        ),
        _buildAppearanceField(context),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: _buildIntakeAdviceField(),
        ),
        _buildWindowField(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: _buildMinimumRestField(),
        ),
        _buildReminderField(context),
      ],
    );
  }

  InputTextField _buildMedicationNameField() {
    return InputTextField(
      stackIcons: null,
      controller: medicationNameController,
      placeholder: "Medication...",
      initalName: widget.therapy.name,
      onChanged: (val) {
        print(val);
        setState(() {});
        // or widget.manager.updateListeners();
      },
    );
  }

  Widget _buildUnitField(BuildContext context) {
    return ProfileCustomTextField(
      stackIcons: null,
      onTap: () {
        _showUnits(context);
      },
      placeholder: unitTypes[newTherapy.medicationInfo.typeIndex],
      placeholderText: 'Type',
    );
  }

  Widget _buildAppearanceField(BuildContext context) {
    return ProfileCustomTextField(
      stackIcons: null,
      onTap: () {
        _showAppearance(context);
      },
      placeholder: SvgPicture.asset(
        appearance_iconss[newTherapy.medicationInfo.appearanceIndex],
        width: 25,
        height: 25,
      ),
      placeholderText: 'Appearance',
    );
  }

  Widget _buildIntakeAdviceField() {
    int remAdviceInd = newTherapy.medicationInfo.intakeAdvices != null &&
            newTherapy.medicationInfo.intakeAdvices.isNotEmpty
        ? newTherapy.medicationInfo.intakeAdvices[0]
        : 0;
    return ProfileCustomTextField(
      stackIcons: null,
      onTap: () {
        _showIntakeAdvice(context);
      },
      placeholder: (remAdviceInd != 0)
          ? intakeAdvice[newTherapy.medicationInfo.intakeAdvices[0]]
              .toLowerCase()
          : intakeAdvice[0],
      placeholderText: 'Intake Advice',
    );
  }

  Widget _buildMinimumRestField() {
    return ProfileCustomTextField(
      stackIcons: null,
      onTap: () {
        _showMinRest(context);
      },
      placeholder: newTherapy.medicationInfo.restDuration == null
          ? 'none'
          : prettyDuration(newTherapy.medicationInfo.restDuration,
              abbreviated: false),
      placeholderText: 'Minimum Rest Duration',
    );
  }

  Widget _buildWindowField() {
    return ProfileCustomTextField(
      stackIcons: null,
      onTap: () {
        _showWindow(context);
      },
      placeholder: newTherapy.schedule.window == null
          ? 'none'
          : prettyDuration(newTherapy.schedule.window, abbreviated: false),
      placeholderText: 'Window',
    );
  }

  Widget _buildReminderField(BuildContext context) {
    return ProfileCustomTextField(
      stackIcons: null,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditReminder(therapy: newTherapy)),
        );
      },
      placeholder:
          newTherapy.schedule.reminderRules.length.toString() + ' scheduled',
      placeholderText: 'Reminder(s)',
    );
  }

  Widget _buildDeleteField(BuildContext context) {
    return GestureDetector(
        onTap: ()  {
          showYesOrNoActionsheet(context);
          // await Provider.of<AuthService>(context, listen: false).signOut();
          // Navigator.pop(context);
        },
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    color: Colors.grey[200],
                    width: 1.2,
                    style: BorderStyle.solid),
              ),
            ),
            child: text('Delete',
                fontSize: 15.0,
                isCentered: true,
                textColor: CupertinoColors.destructiveRed)));
  }

  _showUnits(BuildContext context) {
    showUnitPicker(context, newTherapy);
  }

  _showAppearance(BuildContext context) {
    showAppearancePicker(context, newTherapy);
  }

  _showIntakeAdvice(BuildContext context) {
    showIntakeAdvicePicker(context, newTherapy);
  }

  _showWindow(BuildContext context) {
    showWindowPicker(context, newTherapy);
  }

  _showMinRest(BuildContext context) {
    showMinRestPicker(context, newTherapy);
  }
}
