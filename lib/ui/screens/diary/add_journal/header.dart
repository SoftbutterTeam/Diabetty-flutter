import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddJournalHeader extends StatelessWidget {
  final bool isValid;
  const AddJournalHeader({Key key, this.isValid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final diaryManager = Provider.of<DiaryBloc>(context, listen: false);
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.orange[800],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(context),
                color: Colors.transparent,
                disabledTextColor: Colors.grey,
                disabledColor: Colors.transparent,
                padding: EdgeInsets.only(left: 5),
                child: Align(
                  child: Text('Cancel', style: TextStyle(color: Colors.white)),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: subHeadingText("Add Journal", Colors.white)),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {
                  if (isValid) {
                    diaryManager.submitNewJournal(diaryManager.newJournal);
                    Navigator.of(context).pop(context);
                  }
                },
                color: Colors.transparent,
                disabledTextColor: Colors.grey,
                disabledColor: Colors.transparent,
                padding: EdgeInsets.only(right: 5),
                child: Align(
                  child: Text(isValid ? 'Create' : ''),
                  alignment: Alignment.centerRight,
                ),
              ),
            )
          ],
        ));
  }
}
