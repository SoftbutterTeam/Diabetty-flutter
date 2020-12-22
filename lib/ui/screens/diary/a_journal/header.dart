import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/extensions/string_extension.dart';

class JournalHeader extends StatefulWidget {
  final Journal journal;
  final bool isValid;
  const JournalHeader({Key key, this.isValid = true, this.journal})
      : super(key: key);

  @override
  _JournalHeaderState createState() => _JournalHeaderState();
}

class _JournalHeaderState extends State<JournalHeader>
    with JournalActionsMixin {
  Journal journal;

  @override
  void initState() {
    journal = widget.journal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final diaryManager = Provider.of<DiaryBloc>(context, listen: false);
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
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
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    journal?.name?.capitalize(),
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 19.7),
                  )),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {},
                color: Colors.transparent,
                disabledTextColor: Colors.grey,
                disabledColor: Colors.transparent,
                padding: EdgeInsets.only(right: 5),
                child: Align(
                  child: Icon(
                    Icons.more_horiz,
                    size: 25,
                    color: Colors.black87,
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
            )
          ],
        ));
  }
}
