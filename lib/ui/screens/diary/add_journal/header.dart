import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';

class AddJournalHeader extends StatefulWidget {
  const AddJournalHeader({Key key}) : super(key: key);

  @override
  _AddJournalHeaderState createState() => _AddJournalHeaderState();
}

class _AddJournalHeaderState extends State<AddJournalHeader> with DateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                onPressed: () => Navigator.pop(context),
                color: Colors.transparent,
                disabledTextColor: Colors.grey,
                disabledColor: Colors.transparent,
                padding: EdgeInsets.zero,
                child: Align(
                  child: Text('Cancel'),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: subHeadingText("Add Journal", Colors.black87)),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {},
                color: Colors.transparent,
                disabledTextColor: Colors.grey,
                disabledColor: Colors.transparent,
                padding: EdgeInsets.zero,
                child: Align(
                  child: Text('Create'),
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
          ],
        ));
  }
}
