import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/therapy/add_therapy_1.screen.dart';
import 'package:diabetty/ui/screens/therapy/add_therapy_2.screen.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

final appearanceIcons = appearance_icons;

class AddMedicationScreenBuilder extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<TherapyManager>(
        builder: (_, manager, ___) => AddMedicationScreen._(manager: manager));
  }
}

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen._({Key key, this.manager, this.pageindex = 0})
      : super(key: key);
  final TherapyManager manager;
  final int pageindex;

  @override
  AddMedicationScreenState createState() => AddMedicationScreenState();
}

class AddMedicationScreenState extends State<AddMedicationScreen>
    with TickerProviderStateMixin {
  AddTherapyForm therapyForm;
  ReminderRule reminder;

  TextEditingController medicationNameController;
  TextEditingController strengthController;
  bool medicationNameHeart,
      unitHeart,
      appearanceHeart,
      intakeHeart,
      minRestHeart,
      windowHeart,
      modeHeart;
  PageController pageController;
  int pageIndex;
  int currentIndex;
  @override
  void initState() {
    super.initState();
    strengthController = TextEditingController();
    medicationNameController = TextEditingController();
    //*page view & controller set up
    pageIndex = widget.pageindex;
    currentIndex = widget.pageindex;
    therapyForm = widget.manager.therapyForm = AddTherapyForm();
    pageController = PageController(initialPage: pageIndex);
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
      this.currentIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        AddTherapyScreenOne(
          pageController: pageController,
          manager: widget.manager,
        ),
        AddTherapyScreenTwo(
          manager: widget.manager,
          pageController: pageController,
        )
      ],
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
    );
  }
}
