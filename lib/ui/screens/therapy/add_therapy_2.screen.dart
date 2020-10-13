import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/ui/screens/therapy/mixins/add_therapy_modals.mixin.dart';
import 'package:diabetty/ui/screens/therapy/components/topbar.dart';
import 'package:diabetty/ui/screens/therapy/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/therapy/components/date_range_picker.widget.dart' as DateRangePicker;

import 'components/CustomTextField.dart';

class AddTherapyScreenTwo extends StatefulWidget {
  const AddTherapyScreenTwo(
      {Key key, this.manager, this.pageController, this.pageIndex})
      : super(key: key);
  final TherapyManager manager;
  final PageController pageController;
  final int pageIndex;

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
              child: _buildBody(context),
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
        widget.pageController.jumpToPage(widget.pageIndex);
      },
      onRightTap: () {},
    );
  }

  Column _buildBody(BuildContext context) {
    var formWidgets = <Widget>[
      _buildModeField(),
      _buildWindowField(),
      _buildStartEndDateField(),
    ];

    return Column(children: <Widget>[
      SizedBox(
        height: 50,
      ),
      Container(
        child: Column(
          children: formWidgets,
        ),
      ),
    ]);
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
