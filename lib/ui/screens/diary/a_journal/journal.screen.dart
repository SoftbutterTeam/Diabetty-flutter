import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/diary/a_journal/header.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:diabetty/ui/screens/diary/a_journal/journal_background.dart';
import 'package:diabetty/ui/screens/diary/components/journal_card.dart';
import 'package:diabetty/ui/screens/diary/components/journal_entry_card.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:diabetty/ui/screens/diary/a_journal/journal_add_record.modal.dart';

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
          _buildJournalFooter(size)
        ]);
  }

  Widget _buildJournalCards(BuildContext context) {
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

  GestureDetector _buildAddNoteColumn(
      Size size, BoxDecoration decorationStyle, TextStyle style) {
    return GestureDetector(
      onTap: () {
        navigateToAddJournalNote(context);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: size.height * 0.08,
              width: size.width * 0.16,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.orange[100]),
              child: Center(
                child: Icon(
                  Icons.note_add,
                  color: Colors.orange[800],
                  size: 35,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Center(
                child: Text(
              'Note',
              style: style,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildJournalFooter(Size size) {
    final decorationStyle = BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.black87));

    final style = TextStyle(
      color: Colors.orange[800],
      fontFamily: 'Regular',
      fontSize: 15.0,
    );

    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height * 0.15),
        child: IntrinsicHeight(
            child: Container(
          padding: EdgeInsets.only(top: 15),
          width: size.width,
          decoration: BoxDecoration(
              color: appWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0),
                  spreadRadius: 0.5,
                  blurRadius: 1.5,
                  offset: Offset(0, -1),
                ),
              ],
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(200, 100, 100, 0.2),
                  width: 0.7,
                ),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  flex: 1,
                  child: _buildAddNoteColumn(size, decorationStyle, style)),
              Flexible(
                flex: 1,
                child:
                    _buildAddJournalEntryColumn(size, decorationStyle, style),
              )
            ],
          ),
        )));
  }

  Widget _buildAddJournalEntryColumn(
      Size size, BoxDecoration decorationStyle, TextStyle style) {
    return GestureDetector(
      onTap: () {
        showAddRecordPopupModal(context);
      },
      child: Column(
        children: [
          Container(
            height: size.height * 0.08,
            width: size.width * 0.16,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.orange[100]),
            child: Center(
              child: Icon(
                Icons.library_add,
                color: Colors.orange[800],
                size: 35,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Center(
            child: Text(
              'Record',
              style: style,
            ),
          )
        ],
      ),
    );
  }
}
