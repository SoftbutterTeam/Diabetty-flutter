import 'package:diabetttty/components/header.dart';
import 'package:diabetttty/theme/AppConstant.dart';
import 'package:diabetttty/theme/Extension.dart';
import 'package:diabetttty/theme/colors.dart';
import 'package:diabetttty/theme/strings.dart';
import 'package:diabetttty/theme/widgets.dart';
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
          color: t3_app_background,
          child: Container(color: t3_app_background),
        ),
      ),
    );
  }
}