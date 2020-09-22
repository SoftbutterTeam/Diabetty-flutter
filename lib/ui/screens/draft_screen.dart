import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrafttScreen extends StatefulWidget {
  static var tag = "/draftscreen";

  @override
  DrafttScreenState createState() => DrafttScreenState();
}

class DrafttScreenState extends State<DrafttScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: header(context, titleText: 'Draft Screen'),
      body: SafeArea(
        child: Container(
          color: app_background,
          child: Container(color: app_background),
        ),
      ),
    );
  }
}
