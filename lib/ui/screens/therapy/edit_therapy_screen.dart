import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/extensions/datetime_extension.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/therapy/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/InputTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/StrengthTextField.dart';
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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/ui/screens/therapy/components/date_range_picker.widget.dart'
    as DateRangePicker;

class EditTherapyScreen extends StatefulWidget {
  final Therapy therapy;
  final BuildContext prevContext;

  EditTherapyScreen({this.therapy, this.prevContext});

  @override
  _EditTherapyScreenState createState() => _EditTherapyScreenState();
}

class _EditTherapyScreenState extends State<EditTherapyScreen>
    with EditTherapyModalsMixin {
  TextEditingController medicationNameController = TextEditingController();
  TextEditingController strengthController = TextEditingController();

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
      therapy.loadFromJson(newTherapy.toJson());
      saveTherapy(therapy);

      manager.updateListeners();
      Provider.of<DayPlanManager>(context, listen: false)
        ..scheduleNotifications()
        ..updateListeners();

      Navigator.pop(context);
      setState(() {});
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
            child: _buildDeleteField(context, therapy),
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
          padding: EdgeInsets.only(top: 4.0),
          child: _buildUnitField(context),
        ),
        _buildAppearanceField(context),
        Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: _buildStrengthField(),
        ),
        if (therapy.schedule != null)
          Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: _buildIntakeAdviceField(),
          ),
        if (therapy.schedule != null)
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: _buildWindowField(),
          ),
        if (therapy.schedule != null)
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: _buildReminderField(context),
          ),
        if (therapy.schedule != null)
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: _buildStartEndDateField(),
          ),
      ],
    );
  }

  Widget _buildStartEndDateField() {
    //// print(therapy.schedule.endDate);
    return ProfileCustomTextField(
      stackIcons: null,
      onTap: () => showStartEndDate(context),
      placeholder: (therapy.schedule.startDate.isSameDayAs(DateTime.now()) &&
              (therapy.schedule.endDate == null ||
                  therapy.schedule.startDate
                      .isSameDayAs(therapy.schedule.endDate)))
          ? "From Today"
          : (therapy.schedule.endDate == null)
              ? (therapy.schedule.startDate
                      .isSameDayAs(DateTime.now().add(Duration(days: 1))))
                  ? 'From Tomorrow'
                  : 'From ' +
                      DateFormat('dd MMM yy').format(therapy.schedule.startDate)
              : DateFormat('dd MMM yy').format(therapy.schedule.startDate) +
                  ' - ' +
                  DateFormat('dd MMM yy').format(therapy.schedule.endDate),
      placeholderText: 'Start - End date',
    );
  }

  showStartEndDate(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: newTherapy.schedule.startDate,
        initialLastDate:
            newTherapy.schedule.endDate ?? newTherapy.schedule.startDate,
        firstDate: DateTime.now().subtract(Duration(days: 1)),
        lastDate: new DateTime(2026, 12, 31));
    if (picked != null && picked.length > 0) {
      if (picked.length > 1 && isSameDayAs(picked[0], picked[1]))
        picked.removeAt(1);
      else if (picked.length > 1) {
        //// print(picked);
        newTherapy.schedule.startDate = picked[0];
        newTherapy.schedule.endDate = picked[1];
        setState(() {});
      } else if (picked.length == 1) {
        newTherapy.schedule.startDate = picked[0];
        newTherapy.schedule.endDate = null;
        setState(() {});
      }
    }
  }

  bool isSameDayAs(DateTime date, DateTime datey) {
    if (datey.day != date.day) return false;
    if (datey.month != date.month) return false;
    if (datey.year != date.year) return false;
    return true;
  }

  InputTextField _buildMedicationNameField() {
    return InputTextField(
      stackIcons: null,
      controller: medicationNameController,
      placeholder: "Medication...",
      initalName: newTherapy.name,
      onChanged: (val) {
        // print(val);
        newTherapy.name = val ?? '';
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
    int remAdviceInd = newTherapy.medicationInfo.intakeAdviceIndex ?? 0;
    return ProfileCustomTextField(
      stackIcons: null,
      onTap: () {
        _showIntakeAdvice(context);
      },
      placeholder: (remAdviceInd != 0)
          ? intakeAdvice[remAdviceInd].toLowerCase()
          : intakeAdvice[0],
      placeholderText: 'Intake Advice',
    );
  }

  Widget _buildStrengthField() {
    return Container(
        child: StrengthTextField(
      therapyForm: null,
      therapy: newTherapy,
      initialText: therapy.medicationInfo.strength?.toString() ?? '',
      controller: strengthController,
      stackIcons: null,
      onTap: () {
        _showStrengthUnitPopUp(context, strengthController);
      },
      onChange: (String val) {
        newTherapy.medicationInfo.strength = val != '' ? int.parse(val) : null;
        setState(() {});
      },
      placeholder: strengthUnits[newTherapy.medicationInfo.unitIndex],
      placeholderText: 'Set Strength',
    ));
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
              builder: (context) =>
                  EditReminderRulesScreen(therapy: newTherapy)),
        );
      },
      placeholder: (newTherapy.schedule.reminderRules == null
              ? 'none'
              : newTherapy.schedule.reminderRules.length.toString()) +
          ' scheduled',
      placeholderText: 'Reminder(s)',
    );
  }

  Widget _buildDeleteField(BuildContext context, Therapy therapy) {
    return GestureDetector(
        onTap: () {
          showYesOrNoActionsheet(context, therapy,
              prevContext: widget.prevContext);
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

  void _showStrengthUnitPopUp(
      BuildContext context, TextEditingController strengthController) {
    showStrengthUnitPopUp(context, strengthController, newTherapy);
  }
}
