import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/add_reminder_modal.v2.dart';
import 'package:diabetty/ui/screens/therapy/components/reminder_rule_field.widget.dart';
import 'package:diabetty/ui/screens/therapy/components/stock_dialog.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/ui/screens/therapy/mixins/add_therapy_modals.mixin.dart';
import 'package:diabetty/ui/screens/therapy/components/topbar.dart';
import 'package:diabetty/ui/screens/therapy/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/therapy/components/date_range_picker.widget.dart'
    as DateRangePicker;

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
    print('yooooooooooooooo' + therapyForm.window.toString());
    var size = MediaQuery.of(context).size;
    List<Widget> reminderRulesList =
        (widget.manager.therapyForm.reminderRules == null ||
                widget.manager.therapyForm.reminderRules.length == 0)
            ? List()
            : widget.manager.therapyForm.reminderRules
                .map((e) => ReminderRuleField(rule: e))
                .toList()
                .cast();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: _buildHeader(context),
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: SizedBox(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height * 0.7),
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
      onRightTap: () {},
    );
  }

  Column _buildBody(
      BuildContext context, List<Widget> reminderRulesList, size) {
    var formWidgets = <Widget>[
      _buildModeField(),
      _buildWindowField(),
      _buildStartEndDateField(),
      Column(
        children: [
          _buildAddReminderField(context),
        ],
      ),
      if (reminderRulesList.length > 0)
        (reminderRulesList.length < 20)
            ? ColumnBuilder(
                itemCount: reminderRulesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return reminderRulesList[index];
                },
              )
            : _buildListViewRep(context, reminderRulesList),
    ];

    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
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
                    _buildAlarmSettingsField(),
                    _buildStockField(),
                  ],
                ))),
        SizedBox(height: size.height * 0.08),
      ],
    );
  }

  Widget _buildWindowField() {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
      onTap: () {},
      placeholder: 'hixs',
      placeholderText: 'Window',
    );
  }

  Widget _buildModeField() {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
      onTap: () {},
      placeholder: 'As ' + therapyForm.mode.capitalize(),
      placeholderText: 'Mode',
    );
  }

  _showStartEndDate() async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: new DateTime.now(),
        initialLastDate: new DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 1)),
        lastDate: new DateTime(2026, 12, 31));
    if (picked != null && picked.length == 2) {
      print(picked);
    }
  }

  Widget _buildStartEndDateField() {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
      onTap: () => _showStartEndDate(),
      placeholder: 'hi',
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

  _showReminderModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddReminderModal2(),
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

  Widget _buildAlarmSettingsField() {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
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

  _showAlarmSettingsDialog() {
    showDialog(context: context, builder: (context) => StockDialog());
  }

  //AlarmSettingsDialog()

  Widget _buildStockField() {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
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
}

//  ,
//                   Expanded(
//                       child: Container(
//                           padding: EdgeInsets.symmetric(vertical: 10),
//                           alignment: FractionalOffset.bottomCenter,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               _buildAlarmSettingsField(),
//                               _buildStockField(),
//                             ],
//                           ))),
//                   SizedBox(height: height * 0.08),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
