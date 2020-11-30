import 'dart:math';

import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:flutter/material.dart';

class JournalEntryCard extends StatelessWidget with JournalActionsMixin {
  final JournalEntry journalEntry;
  final Journal journal;
  const JournalEntryCard({Key key, this.journal, this.journalEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Text(journalEntry?.recordEntry.toString() ?? ''),
              ),
            ),
          ),
        ));
  }
}
