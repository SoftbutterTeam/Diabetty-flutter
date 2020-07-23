import 'package:flutter/material.dart';

import 'package:diabetttty/components/header.dart';

class DailyPlannerScreen extends StatefulWidget {
  @override
  _DailyPlannerScreenState createState() => _DailyPlannerScreenState();
}

class _DailyPlannerScreenState extends State<DailyPlannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Daily Planner'),
      body: Center(child: Text("Daily Planner")),
    );
  }
}
