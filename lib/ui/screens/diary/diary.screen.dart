import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/diary/components/background.dart';
import 'package:diabetty/ui/screens/diary/components/journal_card.dart';
import 'package:diabetty/ui/screens/others/error_screens/drafterror.screen.dart';
import 'package:diabetty/ui/screens/today/components/animatedBox.dart';
import 'package:diabetty/ui/screens/today/components/my_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fcharts/fcharts.dart';
import 'package:fl_chart/fl_chart.dart' as charts;

class DiaryScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryBloc>(builder: (_, DiaryBloc diaryManager, __) {
      diaryManager.resetAddJournalForm();
      return DiaryScreen(
        manager: diaryManager,
      );
    });
  }
}

class DiaryScreen extends StatefulWidget {
  final DiaryBloc manager;

  const DiaryScreen({Key key, this.manager}) : super(key: key);

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  DiaryBloc manager;

  @override
  void initState() {
    manager = widget.manager;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical, child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double firstSectionHeight = 0.25;
    return Container(
      color: appWhite,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
                width: size.width,
                height: size.height * firstSectionHeight,
                child: _buildReportSection(context)),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, -1),
                ),
              ],
              border:
                  Border(top: BorderSide(color: Colors.transparent, width: 1))),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: size.width,
                  minHeight: size.height * (0.9 - firstSectionHeight)),
              child: Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: _buildJournalCards(context),
              )),
        ),
      ]),
    );
  }

  Widget _buildJournalCards(BuildContext context) {
    return StreamBuilder(
        stream: manager.journalStream,
        initialData: manager.usersJournals,
        builder: (context, snapshot) {
          if (manager.usersJournals == null || manager.usersJournals.isEmpty) {
            return Container(
              child: null,
            );
          }
          List<Journal> journals = manager.usersJournals;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ColumnBuilder(
                itemCount: journals.length,
                itemBuilder: (context, index) => JournalCard(
                      journal: journals[index],
                    )),
          );
        });
  }

  Widget _buildReportSection(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              alignment: Alignment.centerLeft,
              child: _buildReportPercCircle(context)),
          Container(child: _buildReportText(context))
        ]));
  }
}

Widget _buildReportPercCircle(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.42,
    padding: EdgeInsets.all(size.width * 0.04),
    alignment: Alignment.centerLeft,
    child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: new CustomPaint(
            foregroundPainter: new MyPainter(
                completeColor: Colors.deepOrange,
                completePercent: 78,
                lineColor: Colors.red.withOpacity(0.2),
                width: 1.5),
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                '78%',
                style: TextStyle(fontSize: 25, color: Colors.deepOrange),
              ),
            ))),
  );
}

Widget _buildReportText(BuildContext context) {
  return Expanded(
    child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [Text('last 4 weeks'), Text('3 late'), Text('3 missed')],
        )),
  );
}

// Navigator.pushNamed(context, appsettings);
