import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/screens/diary/components/journal_add_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

@optionalTypeArgs
mixin JournalActionsMixin<T extends Widget> {
  @protected
  Journal get journal;

  void navigateToJournal(context) {
    Navigator.pushNamed(context, aJournal, arguments: {'journal': journal});
  }

  void navigateToAddJournalNote(context, {JournalEntry entry}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => JournalNote(journalEntry: entry),
      ),
    );
  }
}
