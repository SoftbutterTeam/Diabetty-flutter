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
      appBar: header(context, titleText: 'Draft Screen'),
      body: SafeArea(
        child: Container(
          color: t3_app_background,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                width: 180,
                alignment: Alignment.center,
                child: ring(example_text),
              ),
              Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: t3_textColorPrimary,
                      onPressed: () {
                        back(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Center(
                        child: text(t3_lbl_bottom_navigation,
                            fontFamily: fontBold,
                            textColor: t3_textColorPrimary,
                            fontSize: 22.0),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
