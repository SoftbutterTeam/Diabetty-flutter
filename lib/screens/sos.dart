import 'package:flutter/material.dart';

import 'package:diabetttty/components/header.dart';

class SOSScreen extends StatefulWidget {
  @override
  _SOSScreenState createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'SOS'),
      body: Center(child: Text("SOS")),
    );
  }
}
