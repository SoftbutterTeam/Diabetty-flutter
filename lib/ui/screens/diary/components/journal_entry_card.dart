import 'dart:math';

import 'package:diabetty/constants/journal_constants.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:flutter/material.dart';

class JournalEntryCard extends StatefulWidget with JournalActionsMixin {
  final JournalEntry journalEntry;
  final Journal journal;
  int index;
  JournalEntryCard({Key key, this.journal, this.journalEntry, this.index})
      : super(key: key);

  @override
  _JournalEntryCardState createState() => _JournalEntryCardState();
}

class _JournalEntryCardState extends State<JournalEntryCard> {
  int number;

  @override
  void initState() {
    super.initState();
    widget?.journalEntry?.recordNo = widget.index + 1;
    number = widget?.journalEntry?.recordNo;
  }

  @override
  Widget build2(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: 60,
              maxHeight: max(60, size.height * 0.14),
              minWidth: size.width * 0.8,
              maxWidth: size.width * 0.9),
          child: IntrinsicHeight(
            child: Container(
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
                borderRadius: BorderRadius.all(Radius.circular(13)),
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(widget.journalEntry?.recordEntry.toString() ?? ''),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (widget.journalEntry.isNotesType)
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 60,
                maxHeight: max(60, size.height * 0.14),
                minWidth: size.width * 0.8,
                maxWidth: size.width * 0.9),
            child: IntrinsicHeight(
              child: Container(
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
                  border: Border.all(
                    color: Colors.black26,
                    width: 0.1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            // "Notes " + number.toString(),
                            widget?.journalEntry?.title ??
                                "Notes " + number.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        height: 1,
                        width: size.width * 0.1,
                        color: Colors.orange[800],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 2, right: 2),
                          child: Container(
                            height: size.height * 0.07,
                            child: Text(
                              widget?.journalEntry?.notes,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              (widget.journalEntry?.date
                                      ?.shortenDateRepresent() ??
                                  ''),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            Icon(Icons.ac_unit, color: Colors.transparent),
                            Container(
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange[100],
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.orange[800],
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          //TODO note thing
          );
    else
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 60,
                maxHeight: max(60, size.height * 0.14),
                minWidth: size.width * 0.8,
                maxWidth: size.width * 0.9),
            child: IntrinsicHeight(
              child: Container(
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
                  border: Border.all(
                    color: Colors.black26,
                    width: 0.1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "Record " + number.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        height: 1,
                        width: size.width * 0.1,
                        color: Colors.orange[800],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(
                            (widget.journalEntry?.recordEntry.toString() ??
                                    '') +
                                ' ' +
                                report_measurements[(widget.journal == null ||
                                        widget.journal.reportUnitsIndex == null)
                                    ? 0
                                    : widget.journal.reportUnitsIndex],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            (widget.journalEntry?.date
                                    ?.shortenDateRepresent() ??
                                ''),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.0, bottom: 10),
                            child: Container(
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange[100],
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.orange[800],
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
  }
}
