import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:diabetty/ui/screens/therapy/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/today/components/input_field.dart';
import 'package:diabetty/ui/screens/therapy/components/error_modal.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_option_background.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_options_header.dart';
import 'package:diabetty/ui/screens/today/mixins/ReminderActionsMixin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/sanitizers.dart';

class EditDosageScreen extends StatefulWidget {
  final Reminder reminder;

  EditDosageScreen({this.reminder});
  @override
  _EditDosageScreenState createState() => _EditDosageScreenState();
}

class _EditDosageScreenState extends State<EditDosageScreen>
    with ReminderActionsMixin {
  TextEditingController dosageController;
  int dose;
  int y;
  int z;

  @override
  Reminder get reminder => widget.reminder;

  @override
  void initState() {
    dosageController = TextEditingController(text: reminder.dose.toString());
    y = reminder.dose;
    z = reminder.doseTypeIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SnoozeOptionsBackground(
        header: SnoozeOptionsHeader(
          text: 'save',
          backFunction: () {
            _back();
          },
          saveFunction: () {
            _save();
          },
        ),
        child: _body(context));
  }

  _back() {
    reminder.dose = y;
    reminder.doseTypeIndex = z;
    Navigator.pop(context);
  }

  _save() {
    DayPlanManager dayPlanManager =
        Provider.of<DayPlanManager>(context, listen: false);
    if (dosageController.text.isEmpty) {
      return showErrorModal(context);
    } else {
      reminder.dose = int.parse(dosageController.text);
      setState(() {});
      dayPlanManager.updateListeners();
      Navigator.pop(context);
    }
  }

  Future showErrorModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => NoResponseErrorModal(
        errorDescription: 'Please fill in the dosage field',
      ),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        // _buildHeader(size),
        Expanded(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: _buildBody2(size),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(Size size) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        _buildInputDoseField(context),
        SizedBox(height: size.height * 0.01),
        _buildStrengthField(context),
      ],
    );
  }

  InputTextField _buildInputDoseField(BuildContext context) {
    return InputTextField(
      stackIcons: null,
      controller: dosageController,
      placeholder: 'Dosage',
      initalName: widget.reminder.dose.toString(),
      onChanged: (val) {
        dose = toInt(val);
        setState(() {});
        // or widget.manager.updateListeners();
      },
    );
  }

  Widget _buildBody2(Size size) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text('Edit Dosage',
              style: TextStyle(color: Colors.orange[800])),
        ),
        _buildInputDoseField(context),
        SizedBox(height: size.height * 0.01),
        Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text('Edit Dosage Type',
              style: TextStyle(color: Colors.orange[800])),
        ),
        _buildDoseTypeField(context, reminder, size),
      ],
    );
  }

  Widget _buildDoseTypeField(
      BuildContext context, Reminder reminder, Size size) {
    return CustomTextField(
      stackIcons: null,
      onTap: () => showTypeThing(context, reminder, size),
      placeholder: _dosePlaceholder2(),
      placeholderText: 'Dose Type',
    );
  }

  showTypeThing(BuildContext context, Reminder reminder, Size size) {
    void settingState() {
      return setState(() {});
    }

    openTypeThing(context, reminder, size, settingState);
  }

  Widget _buildDoseField(BuildContext context) {
    return CustomTextField(
      stackIcons: null,
      onTap: () {},
      placeholder: _dosePlaceholder(),
      placeholderText: 'Dose',
    );
  }

  Widget _buildStrengthField(BuildContext context) {
    return CustomTextField(
      stackIcons: null,
      onTap: () {},
      placeholder: _strengthPlaceholder(),
      placeholderText: 'Strength',
    );
  }

  _dosePlaceholder2() {
    // int remStrength = widget.reminder.strength;
    // int remStrengthType = widget.reminder.strengthUnitindex;
    int remQuantity = widget.reminder.dose;
    int remType = widget.reminder.doseTypeIndex;

    String remDescription = "";
    // if (remStrength != null && remStrengthType != null && remStrengthType != 0)
    //   remDescription += "$remStrength ${strengthUnits[remStrengthType]}";
    // if (remDescription.isNotEmpty) remDescription += ', ';
    if (remType != null && remQuantity != null)
      remDescription += "${unitTypes[remType].plurarlUnits(remQuantity ?? 1)}";

    return remDescription;
  }

  _dosePlaceholder() {
    // int remStrength = widget.reminder.strength;
    // int remStrengthType = widget.reminder.strengthUnitindex;
    int remQuantity = widget.reminder.dose;
    int remType = widget.reminder.doseTypeIndex;

    String remDescription = "";
    // if (remStrength != null && remStrengthType != null && remStrengthType != 0)
    //   remDescription += "$remStrength ${strengthUnits[remStrengthType]}";
    // if (remDescription.isNotEmpty) remDescription += ', ';
    if (remType != null && remQuantity != null)
      remDescription +=
          "${remQuantity ?? ''} ${unitTypes[remType].plurarlUnits(remQuantity ?? 1)}";

    return remDescription;
  }

  _strengthPlaceholder() {
    int remStrength = widget.reminder.strength;
    int remStrengthType = widget.reminder.strengthUnitindex;

    if (remStrength != null || remStrengthType != null || remStrengthType != 0)
      return "$remStrength ${strengthUnits[remStrengthType]}";
  }
}
