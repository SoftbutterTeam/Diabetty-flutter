import 'package:flutter/material.dart';

import 'package:diabetttty/components/header.dart';

class PlanScreen extends StatefulWidget {
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Planner'),
      body: Center(child: Text("Planner Screen")),
    );
  }
}
