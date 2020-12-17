import 'dart:ui';

import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/screens/diary/a_journal/journal_add_note.dart';
import 'package:diabetty/ui/screens/diary/a_journal/journal_add_record.modal.dart';
import 'package:diabetty/ui/screens/therapy/components/timerpicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

@optionalTypeArgs
mixin JournalActionsMixin<T extends Widget> {
  @protected
  Journal get journal;

  Future<void> navigateToJournal(context) async {
    journal.journalEntries =
        await Provider.of<DiaryBloc>(context, listen: false)
            .fetchJournalEntries(journal);
    Navigator.pushNamed(context, aJournal, arguments: {'journal': journal});
  }

  void navigateToAddJournalNote(context, {JournalEntry entry}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => JournalAddNote(
          journalEntry: entry,
          journal: journal,
        ),
      ),
    );
  }

  void showAddRecordPopupModal(BuildContext context,
          {JournalEntry journalEntry}) =>
      showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        barrierColor: Colors.black12, //black12 white
        pageBuilder: (context, anim1, anim2) => Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          child: JournalAddRecord(journal: journal, journalEntry: journalEntry),
        ),
        transitionBuilder: _transitionBuilderStyle1(),
        transitionDuration: Duration(milliseconds: 250),
      );

  _transitionBuilderStyle1() =>
      (BuildContext context, Animation<double> anim1, anim2, Widget child) {
        bool isReversed = anim1.status == AnimationStatus.reverse;
        double animValue = isReversed ? 0 : anim1.value;
        var size = MediaQuery.of(context).size;
        return SafeArea(
          child: BackdropFilter(
            filter:
                ImageFilter.blur(sigmaX: 8 * animValue, sigmaY: 8 * animValue),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: size.height * .1),
              child: FadeTransition(
                opacity: anim1,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: GestureDetector(
                        onTapDown: (TapDownDetails tp) =>
                            Navigator.of(context).pop(context),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    child,
                  ],
                ),
              ),
            ),
          ),
        );
      };

  void showEditNotesActionSheet(
      BuildContext context, JournalEntry journalNote) {
    DiaryBloc diaryBloc = Provider.of<DiaryBloc>(context, listen: false);
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: Text("Change Date"),
                  onPressed: () {
                    Navigator.pop(context);
                    showDatePicker(context, (DateTime choosenTime) {
                      journalNote.date = choosenTime;
                      diaryBloc.updateListeners();
                    }, journalNote.date);
                  },
                ),
                if (journalNote.id != null)
                  CupertinoActionSheetAction(
                    isDefaultAction: true,
                    child: Text("Delete"),
                    onPressed: () {
                      Navigator.of(context).pop(context);
                      if (journalNote.id != null)
                        diaryBloc.deletejournalEntry(journalNote);
                      Navigator.of(context).pop(context);
                    },
                  ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Container(color: Colors.white, child: Text('Cancel')),
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
              ),
            ));
  }

  void showDatePicker(BuildContext context, Function function, DateTime date) {
    DateTime choosenTime;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return TimerPicker(
          onConfirm: () {
            function(choosenTime);
            Navigator.pop(context);
          },
          timepicker: CupertinoDatePicker(
            use24hFormat: false,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: date,
            onDateTimeChanged: (dateTimeChange) {
              choosenTime = dateTimeChange;
            },
          ),
        );
      },
    );
  }
}
