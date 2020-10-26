import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/medication_card.dart';
import 'package:diabetty/ui/screens/therapy/components/reminder_rule_field.widget.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/ui/screens/therapy/mixins/add_therapy_modals.mixin.dart';
import 'package:diabetty/ui/screens/therapy/components/topbar.dart';
import 'package:diabetty/ui/screens/therapy/extensions/string_extension.dart';
import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:diabetty/ui/screens/therapy/extensions/datetime_extension.dart';

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
              child: _buildBody(context, reminderRulesList, size),
            ),
          ),
        ),
      ),
    );
  }

  TopBar _buildHeader(BuildContext context) {
    return TopBar(
      btnEnabled: (therapyForm.name.isEmpty) ? false : true,
      centerText: 'Add Reminders',
      leftButtonText: 'Back',
      rightButtonText: 'Save',
      onLeftTap: () {
        widget.pageController.jumpToPage(0);
      },
      onRightTap: () {
        if (therapyForm.isAsNeededValid()) {
          therapyForm.handleAsNeededSave();
          Navigator.pushNamed(context, therapy);
        } else {
          if (therapyForm.isPlannedValid()) {
            therapyForm.handleAsPlannedSave();
            Navigator.pushNamed(context, therapy);
          }
        }
      },
    );
  }

  Column _buildBody(
      BuildContext context, List<Widget> reminderRulesList, size) {
    var formWidgets = <Widget>[
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
              padding: EdgeInsets.only(top: 9),
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
        Expanded(
          child: Container(
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
    return MedicationCard(
      name: therapyForm.name,
      appearance: appearance_iconss[therapyForm.apperanceIndex],
    );
  }

  Widget _buildWindowField() {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(therapyForm.window != null),
      onTap: () => showWindow(context),
      placeholder: therapyForm.window == null
          ? 'none'
          : prettyDuration(therapyForm.window, abbreviated: false),
      placeholderText: 'Window',
    );
  }

  Widget _buildModeField() {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
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
    print(therapyForm.endDate);
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
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
            onTap: () => showReminderModal(context),
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
        ],
      ),
    ) as Widget;
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
      stackIcons: _stackedHeartIcons(true),
      onTap: () => showAlarmSettingsDialog(context, widget.manager),
      placeholderText: 'Alarm Settings',
    );
  }

  Widget _buildStockField() {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(therapyForm.stock.isActive),
      onTap: () => showStockDialog(context, widget.manager),
      placeholderText: 'Stock',
    );
  }
}
