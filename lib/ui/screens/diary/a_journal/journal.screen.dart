import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/diary/a_journal/header.dart';
import 'package:diabetty/ui/screens/diary/a_journal/journal_action.mixin.dart';
import 'package:diabetty/ui/screens/diary/a_journal/journal_background.dart';
import 'package:diabetty/ui/screens/diary/components/journal_card.dart';
import 'package:diabetty/ui/screens/diary/components/journal_entry_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JournalScreen extends StatefulWidget {
  final Journal journal;

  const JournalScreen({Key key, this.journal}) : super(key: key);

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen>
    with JournalActionsMixin {
  Journal journal;
  @override
  void initState() {
    journal = widget.journal;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return JournalBackground(
      header: JournalHeader(journal: journal),
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: size.width, height: size.height * 0.25, child: null),
          Expanded(
            child: Container(
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
                  border: Border(
                      top: BorderSide(color: Colors.transparent, width: 1))),
              child: Container(
                width: size.width,
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: _buildJournalCards(context),
              ),
            ),
          ),
        ]);
  }

  Widget _buildJournalCards(BuildContext context) {
    //TODO not needed
    this.journal.dummyJournalData();
    return (journal.journalEntries.isNotEmpty)
        ? ListView.builder(
            itemCount: journal.journalEntries.length,
            itemBuilder: (context, index) {
              return JournalEntryCard(
                journal: this.journal,
                journalEntry: this.journal.journalEntries[index],
              );
            },
          )
        : SizedBox(
            height: 300,
            child: Container(
              child: text('Add one bruddah'),
            ),
          );
  }
}
