// import 'package:diabetttty/components/AddReminderModal.dart';
import 'dart:async';
import 'dart:ui';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/therapy/add_therapy_1.screen.dart';
import 'package:diabetty/ui/screens/therapy/components/index.dart';
import 'package:diabetty/ui/screens/therapy/components/stock_dialog.dart';
import 'package:diabetty/ui/screens/therapy/components/reminder_rule_field.widget.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';
import "package:diabetty/ui/screens/therapy/extensions/string_extension.dart";

import 'package:diabetty/ui/screens/therapy/components/StrengthTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/add_reminder_modal.v2.dart';
import 'package:diabetty/ui/screens/therapy/components/topbar2.dart';
import 'package:diabetty/ui/screens/therapy/components/date_range_picker.widget.dart'
    as DateRangePicker;

import 'package:duration/duration.dart';

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
          manager: widget.manager,
        ),
        AddTherapyScreenOne(
          manager: widget.manager,
        )
      ],
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
    );
  }
}
