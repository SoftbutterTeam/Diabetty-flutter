import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/AppearancePopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/InputTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/IntakePopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/MinRestPopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/StrengthTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/topbar.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/ui/screens/therapy/mixins/add_therapy_modals.mixin.dart';
import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddTherapyScreenOne extends StatefulWidget {
  const AddTherapyScreenOne({Key key, this.manager, this.pageController, this.pageIndex})
      : super(key: key);
  final TherapyManager manager;
  final PageController pageController;
  final int pageIndex;

  @override
  _AddTherapyScreenOneState createState() => _AddTherapyScreenOneState();
}

class _AddTherapyScreenOneState extends State<AddTherapyScreenOne>
    with AddTherapyModalsMixin {
  AddTherapyForm therapyForm;
  TextEditingController medicationNameController;
  TextEditingController strengthController;

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
      centerText: 'Add Medication',
      leftButtonText: 'Cancel',
      rightButtonText: 'Next',
      onLeftTap: () {
        Navigator.pop(context);
      },
      onRightTap: () {
        widget.pageController.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.bounceOut);
      },
    );
  }

  Column _buildBody(BuildContext context) {
    var formWidgets = <Widget>[
      Padding(
        padding: EdgeInsets.only(
          bottom: 20,
        ),
        child: text('Med Info'),
      ),
      _buildMedicationNameField(),
    ]..addAll(<Widget>[
        _buildUnitField(context),
        _buildStrengthField(),
        _buildAppearanceField(context),
        _buildDividerHeader(),
        _buildIntakeAdviceField(),
        _buildMinimumRestField(),
      ].map((e) => animatedOpacity(e, therapyForm.isNameValid()) as Widget));

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

  AnimatedOpacity animatedOpacity(Widget e, bool cond) {
    return AnimatedOpacity(
        opacity: cond ? 1 : 0, duration: Duration(milliseconds: 900), child: e);
  }

  Container _buildDividerHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: 10,
        bottom: 10,
      ),
      child: text('extra details for more assistance features',
          fontSize: textSizeSmall),
    );
  }

  InputTextField _buildMedicationNameField() {
    return InputTextField(
      stackIcons: _stackedHeartIcons(therapyForm.isNameValid()),
      controller: medicationNameController,
      placeholder: 'Medication Name...',
      onChanged: (val) {
        therapyForm.name = val;
        setState(() {});
        // or widget.manager.updateListeners();
      },
    );
  }

  Widget _buildUnitField(BuildContext context) {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
      onTap: () => showUnitPopUp(context),
      placeholder: unitTypes[therapyForm.unitsIndex],
      placeholderText: 'Unit',
    );
  }

  Widget _buildStrengthField() {
    return StrengthTextField(
      controller: strengthController,
      stackIcons: _stackedHeartIcons(true),
      onTap: () {
        showStrengthUnitPopUp(context, strengthController);
      },
      placeholder: strengthUnits[therapyForm.strengthUnitsIndex],
      placeholderText: 'Set Strength',
    );
  }

  Widget _buildAppearanceField(BuildContext context) {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
      onTap: () => showAppearance(context),
      placeholder: SvgPicture.asset(
        appearance_iconss[therapyForm.apperanceIndex],
        width: 25,
        height: 25,
      ),
      placeholderText: 'Appearance',
    );
  }

  Widget _buildIntakeAdviceField() {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(therapyForm.isIntakeAdviceValid()),
      onTap: () => showIntakePopUp(),
      placeholder: intakeAdvice[therapyForm.intakeAdviceIndex],
      placeholderText: 'Intake Advice',
    );
  }

  Widget _buildMinimumRestField() {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(therapyForm.minRest != null),
      onTap: () => showMinRestPopup(context),
      placeholder: therapyForm.minRest == null
          ? 'none'
          : prettyDuration(therapyForm.minRest),
      placeholderText: 'Minimum Rest Duration',
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
