import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/ui/screens/therapy/mixins/add_therapy_modals.mixin.dart';
import 'package:diabetty/ui/screens/therapy/components/topbar.dart';
import 'package:flutter/material.dart';

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
      // Column(
      //   children: [
      //     _buildAddReminderField(),
      //   ],
      // ),
      // if (reminderRulesList.length > 0)
      //                     (reminderRulesList.length < 20)
      //                         ? Visibility(
      //                             visible: _isAsPlanned,
      //                             child: ColumnBuilder(
      //                               itemCount: reminderRulesList.length,
      //                               itemBuilder:
      //                                   (BuildContext context, int index) {
      //                                 return reminderRulesList[index];
      //                               },
      //                             ),
      //                           )
      //                         : _buildListViewRep(context, reminderRulesList),
    ];

    return Column(children: <Widget>[
      SizedBox(
        height: 20,
      ),
      Container(
        child: Column(
          children: formWidgets,
        ),
      ),
    ]);
  }

  _buildModeField() {}

  _buildWindowField() {}

  _buildStartEndDateField() {}
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
