import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/today/components/drop_modal.dart';
import 'package:provider/provider.dart';

class TherapyHeader extends StatefulWidget {
  const TherapyHeader({Key key}) : super(key: key);

  @override
  _TherapyHeaderState createState() => _TherapyHeaderState();
}

class _TherapyHeaderState extends State<TherapyHeader> with DateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    onPressed: () => print('yeye'),
                    color: Colors.transparent,
                    disabledTextColor: Colors.grey,
                    disabledColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    child: Align(
                      child: Icon(Icons.add, color: Colors.white),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => print('yeye'),
                  child: Container(
                    alignment: Alignment.center,
                    child: subHeadingText("Therapy", Colors.white),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () {
                      final actionsheet = addTherapyActionSheet(context);
                      showCupertinoModalPopup(
                          context: context, builder: (context) => actionsheet);
                    },
                    color: Colors.transparent,
                    disabledTextColor: Colors.grey,
                    disabledColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  CupertinoActionSheet addTherapyActionSheet(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: text("Medication", fontSize: 18.0, textColor: Colors.indigo),
          onPressed: () {
            final TherapyManager therapyManager =
                Provider.of<TherapyManager>(context, listen: false);
            therapyManager.resetForm();
            print('this far');
            Navigator.pushReplacementNamed(context, addmedication);
          },
        ),
        CupertinoActionSheetAction(
          child: text("Other Types", fontSize: 18.0, textColor: Colors.indigo),
          onPressed: () {},
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Container(color: Colors.white, child: Text('Cancel')),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
