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
  TextEditingController strengthController;
  int dose;
  Reminder reminderForm;

  @override
  Reminder get reminder => widget.reminder;

  @override
  void initState() {
    reminderForm = Reminder();
    reminderForm.loadFromJson(reminder.tojson());
    dosageController = TextEditingController(text: reminder.dose.toString());
    strengthController = TextEditingController(
        text: reminder.strength != null ? reminder.strength.toString() : '');
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
    Navigator.pop(context);
  }

  _save() {
    DayPlanManager dayPlanManager =
        Provider.of<DayPlanManager>(context, listen: false);
    if (dosageController.text.isEmpty || strengthController.text.isEmpty) {
      return showErrorModal(context);
    } else {
      dayPlanManager.editDoseReminder(reminder, reminderForm.dose,
          strength: reminderForm.strength);
      Navigator.pop(context);
    }
  }

  Future showErrorModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => NoResponseErrorModal(
        errorDescription: 'Please fill in all fields',
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

  InputTextField _buildInputDoseField(BuildContext context) {
    return InputTextField(
      stackIcons: null,
      controller: dosageController,
      placeholder: 'Dosage',
      initalName:
          widget.reminder.dose != null ? widget.reminder.dose.toString() : '',
      onChanged: (val) {
        reminderForm.dose = toInt(val);
        setState(() {});
        // or widget.manager.updateListeners();
      },
    );
  }

  InputTextField _buildInputStrengthField(BuildContext context) {
    return InputTextField(
      stackIcons: null,
      controller: strengthController,
      placeholder: 'Strength',
      initalName: widget.reminder.strength != null
          ? widget.reminder.strength.toString()
          : '',
      onChanged: (val) {
        reminderForm.strength = toInt(val);
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
          child:
              Text('Edit Dosage', style: TextStyle(color: Colors.orange[800])),
        ),
        _buildInputDoseField(context),
        SizedBox(height: size.height * 0.01),
        if (widget.reminder.strength != null)
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text('Edit Strength',
                style: TextStyle(color: Colors.orange[800])),
          ),
        _buildInputStrengthField(context),
      ],
    );
  }
}
