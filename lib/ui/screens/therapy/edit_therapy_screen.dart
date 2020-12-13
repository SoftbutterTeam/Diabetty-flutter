import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/screens/therapy/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/InputTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/error_modal.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_option_background.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_options_header.dart';
import 'package:diabetty/ui/screens/therapy/edit_reminder.screen.dart';
import 'package:diabetty/ui/screens/therapy/mixins/edit_therapy_modals.mixin.dart';
import 'package:duration/duration.dart';
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
      ],
    );
  }

  Widget _buildBody(Size size) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        _buildMedicationNameField(),
        _buildUnitField(context),
        _buildAppearanceField(context),
        _buildIntakeAdviceField(),
        _buildWindowField(),
        _buildMinimumRestField(),
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
    return CustomTextField(
      stackIcons: null,
      onTap: () {
        _showUnits(context);
      },
      placeholder: unitTypes[newTherapy.medicationInfo.typeIndex],
      placeholderText: 'Type',
    );
  }

  Widget _buildAppearanceField(BuildContext context) {
    return CustomTextField(
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
    int remAdviceInd = newTherapy.medicationInfo.intakeAdvices.isNotEmpty
        ? newTherapy.medicationInfo.intakeAdvices[0]
        : 0;
    return CustomTextField(
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
    return CustomTextField(
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
    return CustomTextField(
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
    return CustomTextField(
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
