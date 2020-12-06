import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/diary/add_journal/add_journal_background.dart';
import 'package:diabetty/ui/screens/diary/add_journal/header.dart';
import 'package:diabetty/ui/screens/diary/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/diary/components/InputTextField.dart';
import 'package:diabetty/ui/screens/diary/components/journal_card.dart';
import 'package:diabetty/ui/screens/therapy/components/IntakePopUp.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:diabetty/constants/journal_constants.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/extensions/string_extension.dart';

class AddJournalScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryBloc>(builder: (_, DiaryBloc diaryManager, __) {
      diaryManager.resetAddJournalForm();
      return AddJournalScreen(
        manager: diaryManager,
      );
    });
  }
}

class AddJournalScreen extends StatefulWidget {
  final DiaryBloc manager;
  AddJournalScreen({this.manager});

  @override
  _AddJournalScreenState createState() => _AddJournalScreenState(manager);
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  final DiaryBloc manager;
  _AddJournalScreenState(this.manager);

  TextEditingController textEditingController;
  Journal get newJournal => manager.newJournal;

  @override
  void initState() {
    super.initState();
    textEditingController = new TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return AddJournalBackground(
        header: AddJournalHeader(
            isValid: newJournal.name != '' && newJournal.name != null),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical, child: _body(context)),
        ));
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: size.width * 0.9,
          margin: EdgeInsets.only(top: 5, left: 5, right: 5),
          height: size.height * 0.20,
          alignment: Alignment.center,
          child: IntrinsicHeight(
              child: IgnorePointer(
            ignoring: true,
            child: JournalCard(
              journal: newJournal,
            ),
          )),
        ),
        _buildPageTitle(),
        _buildJournalNameField(),
        _buildReportUnitsField(),
      ],
    );
  }

  InputTextField _buildJournalNameField() {
    return InputTextField(
      stackIcons: _stackedHeartIcons(true),
      controller: textEditingController,
      placeholder: "Journal's Name...",
      initalName: '',
      onChanged: (val) {
        newJournal.name = val;
        setState(() {});
      },
    );
  }

  Widget _buildReportUnitsField() {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
      onTap: () => showReportUnitsPopup(context),
      placeholder: report_measurements[newJournal.reportUnitsIndex ?? 0],
      placeholderText: 'Report Measurements',
    );
  }

  Widget _buildPageTitle() {
    return Container(
      padding: EdgeInsets.only(
        bottom: 20,
      ),
      child: text('Journal Info'),
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

  void showReportUnitsPopup(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IntakePopUp(
          height: height,
          width: width,
          onPressed: () {
            Navigator.of(context).pop(context);
            setState(() {});
          },
          intakePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(
                initialItem: newJournal.reportUnitsIndex ?? 0),
            itemExtent: 35,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int x) {
              newJournal.reportUnitsIndex = x;
            },
            children: new List<Widget>.generate(
              report_measurements.length,
              (int index) {
                return new Center(
                  child: new Text(report_measurements[index].plurarlUnits(3)),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
