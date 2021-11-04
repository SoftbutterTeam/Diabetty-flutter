import 'dart:ui';

import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_background.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';

class JournalAddNote extends StatefulWidget {
  final JournalEntry journalEntry;
  final Journal journal;
  final bool readOnly;

  JournalAddNote({this.journal, this.journalEntry, this.readOnly = false});

  @override
  _JournalAddNoteState createState() => _JournalAddNoteState();
}

class _JournalAddNoteState extends State<JournalAddNote>
    with JournalActionsMixin {
  JournalEntry journalNotes;
  bool leftAlign;
  bool centerAlign;
  bool rightAlign;
  bool bold;
  bool underlined;
  Journal journal;

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _contentFocus = FocusNode();
  final _titleFocus = FocusNode();

  bool readOnly;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    readOnly = widget.readOnly;
    journal = widget.journal;
    journalNotes = widget.journalEntry ??
        new JournalEntry.generated(journal: widget.journal);
    _titleController.text = (journalNotes.title ?? "").capitalize();
    _contentController.text = (journalNotes.notes ?? "").capitalize();
    leftAlign = true;
    centerAlign = false;
    rightAlign = false;
    bold = false;
    underlined = false;
    super.initState();
  }

  DiaryBloc manager;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SubPageBackground(
      child: _body(context),
      header: SubPageHeader(
        text: readOnly ? "" : 'save',
        backFunction: () {
          Navigator.pop(context);
          // _back();
        },
        saveFunction: readOnly
            ? () {}
            : () async {
                journalNotes.notes ??= '';
                Provider.of<DiaryBloc>(context, listen: false)
                    .saveJournalEntry(journalNotes);

                Navigator.pop(context);
              },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        _buildDate(),
        _buildTextFormatter(context),
        Flexible(child: _buildTextInput(context)),
      ],
    );
  }

  Widget _buildTextInput(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        width: size.width * 0.95,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: appWhite,
          border: Border.all(color: Colors.black26, width: 0.3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), //was 20
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Scrollbar(
          controller: scrollController,
          child: TextField(
            textAlign: (leftAlign)
                ? TextAlign.left
                : (centerAlign)
                    ? TextAlign.center
                    : TextAlign.right,
            keyboardType: TextInputType.multiline,
            maxLengthEnforced: true,
            readOnly: readOnly,
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black45, fontSize: 15),
                hintText: readOnly ? "" : "write notes here..."),
            onChanged: (str) {
              journalNotes.notes = str;
            },
            maxLines: 120, // line limit extendable later
            controller: _contentController,
            focusNode: _contentFocus,

            style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: (bold) ? FontWeight.w600 : FontWeight.normal,
                decoration: (underlined)
                    ? TextDecoration.underline
                    : TextDecoration.none),
            cursorColor: Colors.deepOrange,
          ),
        ));
  }

  Padding _buildTextFormatter(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: size.width * 0.75,
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: appWhite,
              border: Border.all(color: Colors.black26, width: 0.3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), //was 20
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              readOnly: readOnly,
              maxLengthEnforced: true,
              textAlign: (leftAlign)
                  ? TextAlign.center
                  : (centerAlign)
                      ? TextAlign.center
                      : TextAlign.right,
              decoration: new InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 15, right: 15, bottom: 0),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black45, fontSize: 15),
                  hintText: readOnly ? "" : "write title here..."),
              onChanged: (str) {
                journalNotes.title = str;
              },
              maxLines: 50,
              controller: _titleController,
              focusNode: _titleFocus,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: (bold) ? FontWeight.w600 : FontWeight.normal,
                  decoration: (underlined)
                      ? TextDecoration.underline
                      : TextDecoration.none),
              cursorColor: Colors.deepOrange,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black54,
            ),
            onPressed: () {
              showEditNotesActionSheet(context, journalNotes, readOnly, () {
                setState(() {
                  readOnly = false;
                });
              });
            },
          ),
        ],
      ),
    );
  }

  Column _buildDate() {
    manager = Provider.of<DiaryBloc>(context, listen: true);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25.0, bottom: 5),
          child: Row(
            children: [
              Text(
                journalNotes.date.justDayRepresent(),
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 27.0, bottom: 10),
          child: Row(
            children: [
              Text(
                journalNotes.date.monthYearRepresent(),
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
