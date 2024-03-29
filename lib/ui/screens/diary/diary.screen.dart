import 'dart:math';

import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/diary/components/background.dart';
import 'package:diabetty/ui/screens/diary/components/journal_card2.dart';
import 'package:diabetty/ui/screens/today/components/my_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/routes.dart';

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

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 4),
        child: Container(
          margin: EdgeInsets.only(top: 5),
          child: _buildJournalCards(context),
        ));
  }

  Widget _buildJournalCards(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: manager.journalStream,
        initialData: manager.usersJournals,
        builder: (context, snapshot) {
          if (manager.usersJournals == null || manager.usersJournals.isEmpty) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 26),
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: text("Add a journal here!"),
                  ),
                  SvgPicture.asset(
                    'assets/images/empty_diary.svg',
                    height: 250,
                    width: 300,
                  ),
                ],
              ),
            );
          }
          List<Journal> journals = manager.usersJournals
            ..sort(
                (Journal a, Journal b) => b.updatedAt.compareTo(a.updatedAt));
          return Container(
            child: Scrollbar(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: journals.length,
                  addAutomaticKeepAlives: true,
                  itemBuilder: (context, index) => JournalCard2(
                        journal: journals[index],
                      )),
            ),
          );
        });
  }

  // TODO: Remove this if it isn't going to be used in the diary screen anymore.
  Widget _buildReportSection(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 0, right: 10, bottom: 5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              alignment: Alignment.centerLeft,
              child: _buildReportPercCircle(context)),
          Container(child: _buildReportText(context))
        ]));
  }
}

//TODO: Remove this if we're not using the circle in the future.
Widget _buildReportPercCircle(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return SizedBox(
    width: size.width,
    child: Container(
        margin: EdgeInsets.all(size.width * 0.04),
        padding: EdgeInsets.all(size.width * 0.02),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: appWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // a 0.2 is dope
              spreadRadius: 2,
              blurRadius: 3,

              offset: Offset(0, 0), // a 1 is dope
            ),
          ],
        ),
        child: new CustomPaint(
            foregroundPainter: new MyPainter(
                completeColor: Colors.deepOrange,
                completePercent: 78,
                lineColor: Colors.red.withOpacity(0.2),
                width: 2),
            child: Container(
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
        alignment: Alignment.centerRight,
        child: Column(
          children: [Text('last 4 weeks'), Text('3 late'), Text('3 missed')],
        )),
  );
}

// Navigator.pushNamed(context, appsettings);
