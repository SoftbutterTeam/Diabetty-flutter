import 'dart:ui';

import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_background.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:provider/provider.dart';

class JournalAddNote extends StatefulWidget {
  final JournalEntry journalEntry;
  final Journal journal;

  JournalAddNote({this.journal, this.journalEntry});

  @override
  _JournalAddNoteState createState() => _JournalAddNoteState();
}

class _JournalAddNoteState extends State<JournalAddNote> {
  JournalEntry journalNotes;
  bool leftAlign;
  bool centerAlign;
  bool rightAlign;
  bool bold;
  bool underlined;

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _contentFocus = FocusNode();

  ScrollController scrollController = ScrollController();

  final _titleFocus = FocusNode();
  @override
  void initState() {
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

  Widget _body(BuildContext context) {
    return Column(
      children: [
        _buildDate(),
        _buildTextFormatter(),
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
                : (centerAlign) ? TextAlign.center : TextAlign.right,
            keyboardType: TextInputType.multiline,
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black45, fontSize: 15),
                hintText: "write notes here..."),
            onChanged: (str) => {journalNotes.notes},
            maxLines: 50, // line limit extendable later
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

  Padding _buildTextFormatter() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.format_align_left,
                color: (leftAlign) ? Colors.orange : Colors.black54),
            onPressed: () {
              leftAlign = true;
              centerAlign = false;
              rightAlign = false;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.format_align_center,
                color: (centerAlign) ? Colors.orange : Colors.black54),
            onPressed: () {
              leftAlign = false;
              centerAlign = true;
              rightAlign = false;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.format_align_right,
                color: (rightAlign) ? Colors.orange : Colors.black54),
            onPressed: () {
              leftAlign = false;
              centerAlign = false;
              rightAlign = true;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.format_bold,
                color: (bold) ? Colors.orange : Colors.black54),
            onPressed: () {
              bold = !bold;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.format_underlined,
                color: (underlined) ? Colors.orange : Colors.black54),
            onPressed: () {
              underlined = !underlined;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.clear, color: Colors.black54),
            onPressed: () {
              _contentController.clear();
            },
          ),
        ],
      ),
    );
  }

  Column _buildDate() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25.0, bottom: 5),
          child: Row(
            children: [
              Text(
                DateTime.now().shortenDayRepresent2(),
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.0, bottom: 10),
          child: Row(
            children: [
              Text(
                DateTime.now().shortenDayRepresent3(),
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

  Widget _body2(BuildContext ctx) {
    return Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 16, right: 16, top: 12),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                DateTime.now().shortenDayRepresent2(),
                style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
              ),
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
                          maxLines: 50, // line limit extendable later
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
