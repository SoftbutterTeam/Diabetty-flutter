import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/today/components/drop_modal.dart';
import 'package:provider/provider.dart';

class DiaryHeader extends StatefulWidget {
  const DiaryHeader({Key key}) : super(key: key);

  @override
  _DiaryHeaderState createState() => _DiaryHeaderState();
}

class _DiaryHeaderState extends State<DiaryHeader> with DateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: subHeadingText("Diary", Colors.white),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.pushNamed(context, addJournal),
                color: Colors.transparent,
                disabledTextColor: Colors.grey,
                disabledColor: Colors.transparent,
                padding: EdgeInsets.zero,
                child: Align(
                  child: Icon(Icons.add, color: Colors.white),
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
          ],
        ));
  }
}
