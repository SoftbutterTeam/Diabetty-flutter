import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/therapy/edit_therapy_screen.dart';
import 'package:flutter/material.dart';

class TherapyProfileHeader extends StatefulWidget {
  final Therapy therapy;
  TherapyProfileHeader({this.therapy});

  @override
  _TherapyProfileHeaderState createState() => _TherapyProfileHeaderState();
}

class _TherapyProfileHeaderState extends State<TherapyProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.orange[800],
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
                padding: EdgeInsets.only(left: 5),
                child: Align(
                  child:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 15),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: subHeadingText("", Colors.black87)),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditTherapyScreen(therapy: widget.therapy)),
                  );
                },
                color: Colors.transparent,
                disabledTextColor: Colors.grey,
                disabledColor: Colors.transparent,
                padding: EdgeInsets.only(right: 5),
                child: Align(
                  child: Text("edit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400)),
                  alignment: Alignment.centerRight,
                ),
              ),
            )
          ],
        ));
  }
}
