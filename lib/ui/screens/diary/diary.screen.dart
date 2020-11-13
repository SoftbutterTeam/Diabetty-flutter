import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/diary/components/background.dart';
import 'package:diabetty/ui/screens/diary/components/journal_card.dart';
import 'package:diabetty/ui/screens/others/error_screens/drafterror.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
        SizedBox(width: size.width, height: size.height * firstSectionHeight),
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
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: manager.journalStream,
        initialData: manager.usersJournals,
        builder: (context, snapshot) {
          if (manager.usersJournals.isEmpty) {
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
}

// Navigator.pushNamed(context, appsettings);
