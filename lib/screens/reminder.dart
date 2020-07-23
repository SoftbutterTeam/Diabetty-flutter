import 'package:flutter/material.dart';

import 'package:diabetttty/components/header.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Reminder'),
      body: Center(child: Text("Reminder Screen")),
    );
  }
}
