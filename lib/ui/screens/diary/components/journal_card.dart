import 'dart:math';

import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/diary/a_journal/journal_action.mixin.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/extensions/string_extension.dart';

class JournalCard extends StatelessWidget with JournalActionsMixin {
  final Journal journal;
  const JournalCard({Key key, this.journal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextStyle textStyle = TextStyle(
        fontFamily: fontBold,
        fontSize: 18.5,
        color: Colors.deepOrange,
        fontWeight: FontWeight.bold);
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
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    journal?.name?.capitalize() ?? '',
                    style: textStyle,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
