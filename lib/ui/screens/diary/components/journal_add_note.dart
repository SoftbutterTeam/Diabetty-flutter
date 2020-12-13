import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_background.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:provider/provider.dart';

class JournalNote extends StatefulWidget {
  final JournalEntry journalEntry;

  JournalNote({this.journalEntry});

  @override
  _JournalNoteState createState() => _JournalNoteState();
}

class _JournalNoteState extends State<JournalNote> {
  JournalEntry journalNotes;

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _contentFocus = FocusNode();

  ScrollController scrollController = ScrollController();

  final _titleFocus = FocusNode();
  @override
  void initState() {
    journalNotes = widget.journalEntry ?? new JournalEntry();
    _titleController.text = (journalNotes.title ?? "").capitalize();
    _contentController.text = (journalNotes.notes ?? "").capitalize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SubPageBackground(
      child: _body(context),
      header: SubPageHeader(
        text: 'save',
        backFunction: () {
          Navigator.pop(context);
          // _back();
        },
        saveFunction: () async {
          Provider.of<DiaryBloc>(context, listen: false)
              .saveJournalEntry(journalNotes);

          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _body(BuildContext ctx) {
    return Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 16, right: 16, top: 12),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.deepOrange.withOpacity(0.6), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        hintText: "Title..."),
                    onChanged: (str) => {journalNotes.title},
                    maxLines: 1,
                    autocorrect: true,
                    textAlign: TextAlign.center,
                    controller: _titleController,
                    focusNode: _titleFocus,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                    cursorColor: Colors.deepOrange,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Divider(color: Colors.black26)),
              Flexible(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.deepOrange.withOpacity(0.6),
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Scrollbar(
                        controller: scrollController,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.black45, fontSize: 18),
                              hintText: "write notes here..."),
                          onChanged: (str) => {journalNotes.notes},
                          maxLines: 300, // line limit extendable later
                          controller: _contentController,
                          focusNode: _contentFocus,
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                          cursorColor: Colors.deepOrange,
                        ),
                      )))
            ],
          ),
          left: true,
          right: true,
          top: false,
          bottom: false,
        ));
  }
}
