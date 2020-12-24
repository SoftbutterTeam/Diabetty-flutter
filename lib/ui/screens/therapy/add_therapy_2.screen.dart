import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_header.dart';
import 'package:diabetty/ui/screens/therapy/components/error_modal.dart';
import 'package:diabetty/ui/screens/therapy/components/reminder_rule_field.widget.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_card.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/ui/screens/therapy/mixins/add_therapy_modals.mixin.dart';
import 'package:diabetty/ui/screens/therapy/components/topbar.dart';
import 'package:diabetty/extensions/string_extension.dart';
import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:diabetty/extensions/datetime_extension.dart';
import 'package:diabetty/extensions/index.dart';

import 'components/CustomTextField.dart';

class AddTherapyScreenTwo extends StatefulWidget {
  const AddTherapyScreenTwo({Key key, this.manager, this.pageController})
      : super(key: key);
  final TherapyManager manager;
  final PageController pageController;

  @override
  _AddTherapyScreenTwoState createState() => _AddTherapyScreenTwoState();
}

class _AddTherapyScreenTwoState extends State<AddTherapyScreenTwo>
    with AddTherapyModalsMixin {
  AddTherapyForm therapyForm;
  @override
  void initState() {
    therapyForm = widget.manager.therapyForm;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (widget.manager.therapyForm.reminderRules != null ||
        widget.manager.therapyForm.reminderRules.length != 0) {
      widget.manager.therapyForm.reminderRules
        ..sort((ReminderRule a, ReminderRule b) =>
            a.time.applyTimeOfDay().compareTo(b.time.applyTimeOfDay()));
    }
    List<Widget> reminderRulesList =
        (widget.manager.therapyForm.reminderRules == null ||
                widget.manager.therapyForm.reminderRules.length == 0)
            ? List()
            : widget.manager.therapyForm.reminderRules
                .map((e) => ReminderRuleField(rule: e) as Widget)
                .toList()
          ..add(_buildAddReminderField(context));

    return Scaffold(
      body: Stack(children: [
        _body(context, reminderRulesList),
        SafeArea(
          child: IntrinsicHeight(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    child: SubPageHeader(
                      text: 'save',
                      saveFunction: () async {
                        try {
                          if (therapyForm.isNeededMode())
                            therapyForm.neededValidation(toThrow: true);
                          else if (therapyForm.isPlannedMode())
                            therapyForm.plannedValidation(toThrow: true);
                          await widget.manager.submitAddTherapy(therapyForm);
                          Navigator.pushNamed(context, therapy);
                        } catch (e) {
                          //print(e.message);
                          //print('this shows up');
                          showErrorModal(context);
                          // TODO Display Model with describing the error
                        }
                      },
                      color: Colors.white,
                      backFunction: () => widget.pageController.jumpToPage(0),
                    ),
                  ))),
        ),
      ]),
    );
  }

  Widget _body(BuildContext context, List<Widget> reminderRulesList) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        _buildHeader(context),
        Expanded(
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: _buildBody(context, reminderRulesList))),
      ],
    );
  }

  @override
  Widget build2(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (widget.manager.therapyForm.reminderRules != null ||
        widget.manager.therapyForm.reminderRules.length != 0) {
      widget.manager.therapyForm.reminderRules
        ..sort((ReminderRule a, ReminderRule b) =>
            a.time.applyTimeOfDay().compareTo(b.time.applyTimeOfDay()));
    }
    List<Widget> reminderRulesList =
        (widget.manager.therapyForm.reminderRules == null ||
                widget.manager.therapyForm.reminderRules.length == 0)
            ? List()
            : widget.manager.therapyForm.reminderRules
                .map((e) => ReminderRuleField(rule: e) as Widget)
                .toList()
          ..add(_buildAddReminderField(context));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: _buildHeader(context),
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: SizedBox(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height * 0.85),
              child: _buildBody(context, reminderRulesList),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Colors.orange[900], Colors.orange[800]]),
      ),
    );
  }

  TopBar _buildHeader2(BuildContext context, size) {
    return TopBar(
        btnEnabled: (therapyForm.name.isEmpty) ? false : true,
        centerText: 'Add Reminders',
        leftButtonText: 'Back',
        rightButtonText: 'Save',
        onLeftTap: () {
          widget.pageController.jumpToPage(0);
        },
        onRightTap: () async {
          //print(therapyForm.name);

          try {
            if (therapyForm.isNeededMode())
              therapyForm.neededValidation(toThrow: true);
            else if (therapyForm.isPlannedMode())
              therapyForm.plannedValidation(toThrow: true);
            await widget.manager.submitAddTherapy(therapyForm);
            Navigator.pushNamed(context, therapy);
          } catch (e) {
            //print(e.message);
            //print('this shows up');
            showErrorModal(context);
            // TODO Display Model with describing the error
          }
        });
  }

  Future showErrorModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => NoResponseErrorModal(
        errorDescription: 'Please add at least one reminder',
      ),
    );
  }

  Column _buildBody(BuildContext context, List<Widget> reminderRulesList) {
    var size = MediaQuery.of(context).size;
    var formWidgets = <Widget>[
      Container(
        width: size.width * 0.8,
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          bottom: 20,
        ),
        child: _buildMedicationCard(),
      ),
      _buildModeField(),
      Visibility(
        visible: therapyForm.isVisible() ? true : false,
        child: _buildWindowField(),
      ),
      Visibility(
        visible: therapyForm.isVisible() ? true : false,
        child: _buildStartEndDateField(),
      ),
      Visibility(
        visible: therapyForm.isVisible() ? true : false,
        child: _buildWeeklyReminderText(),
      ),
      if (reminderRulesList.length > 0)
        Visibility(
            visible: therapyForm.isVisible() ? true : false,
            child: Container(
              padding: EdgeInsets.only(top: 2),
              height: size.height * 0.37,
              child: (reminderRulesList.length < 7)
                  ? ColumnBuilder(
                      itemCount: reminderRulesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return reminderRulesList[index];
                      },
                    )
                  : _buildListViewRep(context, reminderRulesList),
            ))
    ];

    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          child: Column(
            children: formWidgets,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: FractionalOffset.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: therapyForm.isVisible() ? true : false,
                child: _buildAlarmSettingsField(),
              ),
              _buildStockField(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyReminderText() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: text('Weekly Reminders',
          isCentered: true, textColor: Colors.black54, fontSize: 13.0),
    );
  }

  Widget _buildMedicationCard() {
    return TherapyCard(
      therapy: therapyForm.toTherapy(),
    );
  }

  Widget _buildWindowField() {
    return CustomTextField(
      stackIcons: null,
      onTap: () => showWindow(context),
      placeholder: therapyForm.window == null
          ? 'none'
          : prettyDuration(therapyForm.window, abbreviated: false),
      placeholderText: 'Window',
    );
  }

  Widget _buildModeField() {
    return CustomTextField(
      stackIcons: null,
      onTap: () {
        therapyForm.isVisible()
            ? setState(() {
                therapyForm.mode = 'needed';
              })
            : setState(() {
                therapyForm.mode = 'planned';
              });
      },
      placeholder: 'As ' + therapyForm.mode.capitalize(),
      placeholderText: 'Mode',
    );
  }

  Widget _buildStartEndDateField() {
    //print(therapyForm.endDate);
    return CustomTextField(
      stackIcons: null,
      onTap: () => showStartEndDate(context),
      placeholder: (therapyForm.startDate.isSameDayAs(DateTime.now()) &&
              (therapyForm.endDate == null ||
                  therapyForm.startDate.isSameDayAs(therapyForm.endDate)))
          ? "From Today"
          : (therapyForm.endDate == null)
              ? (therapyForm.startDate
                      .isSameDayAs(DateTime.now().add(Duration(days: 1))))
                  ? 'From Tomorrow'
                  : 'From ' +
                      DateFormat('dd/MM/yy').format(therapyForm.startDate)
              : DateFormat('dd/MM/yy').format(therapyForm.startDate) +
                  ' to ' +
                  DateFormat('dd/MM/yy').format(therapyForm.endDate),
      placeholderText: 'Start - End Date',
    );
  }

  Stack _stackedHeartIcons(bool cond) {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: cond ? 0 : 1,
          duration: Duration(milliseconds: 1000),
          child: Icon(
            CupertinoIcons.heart,
            color: Colors.black,
            size: 23,
          ),
        ),
        AnimatedOpacity(
          opacity: cond ? 1 : 0,
          duration: Duration(milliseconds: 1000),
          child: Icon(
            CupertinoIcons.heart_solid,
            color: Colors.red,
            size: 23,
          ),
        )
      ],
    );
  }

  Widget _buildAddReminderField(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          CupertinoTextField(
            onTap: () => showReminderModal(context, widget.manager),
            decoration: BoxDecoration(
              color: appWhite,
              border: Border(
                bottom: BorderSide(
                    color: Colors.grey[200],
                    width: 1.2,
                    style: BorderStyle.solid),
              ),
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
        ],
      ),
    ) as Widget;
  }

  _buildListViewRep(BuildContext context, List<Widget> widgets) {
    var size = MediaQuery.of(context).size;
    Widget addRem = widgets.cast().last as Widget;

    List<Widget> mywidgets = List.of(widgets);
    mywidgets.removeLast();
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.3,
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: mywidgets.cast(),
            ),
          ),
          addRem
        ],
      ),
    );
  }

  Widget _buildAlarmSettingsField() {
    return CustomTextField(
      stackIcons: null,
      onTap: () => showAlarmSettingsDialog(context, widget.manager),
      placeholderText: 'Alarm Settings',
    );
  }

  Widget _buildStockField() {
    return CustomTextField(
      stackIcons: null,
      onTap: () => showStockDialog(context, widget.manager),
      placeholderText: 'Stock',
    );
  }
}
