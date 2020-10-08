import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AddReminderModal2 extends StatefulWidget {
  @override
  _AddReminderModal2State createState() => _AddReminderModal2State();
}

class _AddReminderModal2State extends State<AddReminderModal2> {
  int lastTapped;
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: size.height * 0.3,
        width: size.width * 0.8,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: size.height * 0.045,
              width: size.width,
              color: Colors.red,
              child: WeekdaySelector(
          // We display the last tapped value in the example app
          onChanged: (v) {
            printIntAsDay(v);
            setState(() => lastTapped = v);
          },
          values: [
            true, // Sunday
            false, // Monday
            false, // Tuesday
            false, // Wednesday
            false, // Thursday
            false, // Friday
            true, // Saturday
          ],
        ),
            ),
          ],
        ),
      ),
    );
  }
}
