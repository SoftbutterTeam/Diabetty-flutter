import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/screens/therapy/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/InputTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/error_modal.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_option_background.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_options_header.dart';
import 'package:diabetty/ui/screens/therapy/mixins/edit_therapy_modals.mixin.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  String name;
  int type;
  int appearance;
  int intake;
  Duration window;
  Duration restDuration;

  @override
  Therapy get therapy => widget.therapy;

  @override
  void initState() {
    super.initState();
    newTherapy = Therapy().loadFromJson(therapy.toJson()); //TODO therapy = newTheraoyee
    name = therapy.medicationInfo.name;
    // type = therapy.medicationInfo.typeIndex;
    appearance = therapy.medicationInfo.appearanceIndex;
    window = therapy.schedule.window;
    restDuration = therapy.medicationInfo.restDuration;
  }

  @override
  Widget build(BuildContext context) {
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

  _back() {
    therapy.medicationInfo.name = name;
    therapy.medicationInfo.typeIndex = type;
    therapy.medicationInfo.appearanceIndex = appearance;
    therapy.schedule.window = window;
    therapy.medicationInfo.restDuration = restDuration;
  }

  _save() {
    if (medicationNameController.text.isEmpty) {
      return _showErrorModal(context);
    } else {
      therapy.medicationInfo.name = medicationNameController.text;
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
      placeholder: unitTypes[widget.therapy.medicationInfo.typeIndex],
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
        appearance_iconss[widget.therapy.medicationInfo.appearanceIndex],
        width: 25,
        height: 25,
      ),
      placeholderText: 'Appearance',
    );
  }

  Widget _buildIntakeAdviceField() {
    int remAdviceInd = widget.therapy.medicationInfo.intakeAdvices.isNotEmpty
        ? widget.therapy.medicationInfo.intakeAdvices[0]
        : 0;
    return CustomTextField(
      stackIcons: null,
      onTap: () {
        _showIntakeAdvice(context);
      },
      placeholder: (remAdviceInd != 0)
          ? intakeAdvice[widget.therapy.medicationInfo.intakeAdvices[0]]
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
      placeholder: widget.therapy.medicationInfo.restDuration == null
          ? 'none'
          : prettyDuration(widget.therapy.medicationInfo.restDuration,
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
      placeholder: widget.therapy.schedule.window == null
          ? 'none'
          : prettyDuration(widget.therapy.schedule.window, abbreviated: false),
      placeholderText: 'Window',
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
