import 'dart:math';

import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/screens/diary/a_journal/journal_action.mixin.dart';
import 'package:flutter/material.dart';

class JournalCard extends StatelessWidget with JournalActionsMixin {
  final Journal journal;
  const JournalCard({Key key, this.journal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: 80,
              maxHeight: max(80, size.height * 0.16),
              minWidth: size.width * 0.8,
              maxWidth: size.width * 0.9),
          child: GestureDetector(
            onTap: () => navigateToJournal(context),
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
                  child: Text(journal?.name ?? ''),
                ),
              ),
            ),
          ),
        ));
  }
}
