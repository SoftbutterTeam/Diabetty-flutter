import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_background.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_header.dart';
import 'package:diabetty/ui/screens/therapy/components/AppearancePopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/InputTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/IntakePopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/custom_timer_picker.dart';
import 'package:diabetty/ui/screens/therapy/components/StrengthTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/topbar.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/ui/screens/therapy/mixins/add_therapy_modals.mixin.dart';
import 'package:diabetty/ui/screens/today/components/common_background.dart';
import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:diabetty/extensions/string_extension.dart';

import 'components/header.dart';

class AddTherapyScreenOne extends StatefulWidget {
  const AddTherapyScreenOne({Key key, this.manager, this.pageController})
      : super(key: key);
  final TherapyManager manager;
  final PageController pageController;

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
    strengthController = TextEditingController();
    medicationNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    strengthController?.dispose();
    medicationNameController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SubPageBackground(
      child: _body(context),
      header: SubPageHeader(
          text: 'next',
          backFunction: () {
            Navigator.pop(context);
            // _back();
          },
          saveFunction: () {
            if (therapyForm.name.isNotEmpty) {
              widget.manager.updateListeners();
              FocusScope.of(context).unfocus();
              widget.pageController.jumpToPage(1);
            }
          }),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        // _buildHeader(context),
        Expanded(
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: _buildBody(context))),
      ],
    );
  }

  @override
  Widget build2(BuildContext context) {
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

  TopBar _buildHeader2(BuildContext context) {
    return TopBar(
      btnEnabled: (therapyForm.name.isEmpty) ? false : true,
      centerText: 'Add Medication',
      leftButtonText: 'Cancel',
      rightButtonText: 'Next',
      onLeftTap: () {
        Navigator.pop(context);
      },
      onRightTap: () {
        widget.manager.updateListeners();
        FocusScope.of(context).unfocus();
        widget.pageController.jumpToPage(1);
      },
    );
  }

  Column _buildBody(BuildContext context) {
    var formWidgets = <Widget>[
      _buildPageTitle(),
      _buildMedicationNameField(),
    ]..addAll(<Widget>[
        _buildUnitField(context),
        _buildStrengthField(),
        _buildAppearanceField(context),
        _buildDividerHeader(),
        _buildIntakeAdviceField(),
        //  _buildMinimumRestField(),
      ].map((e) => IgnorePointer(
          ignoring: !therapyForm.isNameValid(),
          child: animatedOpacity(e, therapyForm.isNameValid()) as Widget)));

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
        opacity: cond ? 1 : 0, duration: Duration(milliseconds: 500), child: e);
  }

  Widget _buildPageTitle() {
    return Container(
      padding: EdgeInsets.only(
        bottom: 20,
      ),
      child: text('Med Info'),
    );
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
      // stackIcons: _stackedHeartIcons(therapyForm.isNameValid()),
      stackIcons: null,
      autoFocus: true,
      controller: medicationNameController,
      placeholder: 'Medication Name...',
      initalName: therapyForm.name,
      onChanged: (val) {
        therapyForm.name = val;
        setState(() {});
        // widget.manager.updateListeners();
      },
    );
  }

  Widget _buildUnitField(BuildContext context) {
    return CustomTextField(
      stackIcons: null,
      onTap: () => showUnitPopUp(context),
      placeholder: unitTypes[therapyForm.typeIndex],
      placeholderText: 'Type',
    );
  }

  Widget _buildStrengthField() {
    return Container(
        child: StrengthTextField(
      therapyForm: therapyForm,
      initialText:
          (therapyForm.strength == null) ? '' : therapyForm.strength.toString(),
      controller: strengthController,
      stackIcons: null,
      onTap: () {
        showStrengthUnitPopUp(context, strengthController);
      },
      onChange: (String val) {
        therapyForm.strength = val != '' ? int.parse(val) : null;
        setState(() {});
      },
      placeholder: strengthUnits[therapyForm.strengthUnitsIndex],
      placeholderText: 'Set Strength',
    ));
  }

  Widget _buildAppearanceField(BuildContext context) {
    return CustomTextField(
      stackIcons: null,
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
      // stackIcons: _stackedHeartIcons(therapyForm.intakeAdviceIndex != 0),
      stackIcons: null,
      onTap: () => showIntakePopUp(),
      placeholder: intakeAdvice[therapyForm.intakeAdviceIndex],
      placeholderText: 'Intake Advice',
    );
  }

  Widget _buildMinimumRestField() {
    return CustomTextField(
      // stackIcons: _stackedHeartIcons(therapyForm.minRest != null),
      stackIcons: null,
      onTap: () => showMinRestPopup(context),
      placeholder: therapyForm.minRest == null
          ? 'none'
          : prettyDuration(therapyForm.minRest, abbreviated: false),
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
