import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:diabetty/ui/screens/therapy/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_option_background.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_options_header.dart';
import 'package:flutter/material.dart';

class EditDosageScreen extends StatefulWidget {
  final Reminder reminder;

  EditDosageScreen({this.reminder});
  @override
  _EditDosageScreenState createState() => _EditDosageScreenState();
}

class _EditDosageScreenState extends State<EditDosageScreen> {
  @override
  Widget build(BuildContext context) {
    return SnoozeOptionsBackground(
        header: SnoozeOptionsHeader(text: 'save'), child: _body(context));
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
        _buildDoseField(context),
        SizedBox(height: size.height * 0.01),
        _buildStrengthField(context),
      ],
    );
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

    if (remStrength == null || remStrengthType == null)
      return "No Strength Set";
    else if (remStrength != null &&
        remStrengthType != null &&
        remStrengthType != 0)
      return "$remStrength ${strengthUnits[remStrengthType]}";
  }
}
