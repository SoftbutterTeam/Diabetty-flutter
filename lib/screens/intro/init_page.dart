import 'package:diabetttty/components/index.dart';
import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class InitialQuestionPage extends StatefulWidget {
  @override
  _InitialQuestionPageState createState() => _InitialQuestionPageState();
}

class _InitialQuestionPageState extends State<InitialQuestionPage> {
  @override
  Widget build(BuildContext context) {
    changeStatusColor(Theme.of(context).scaffoldBackgroundColor);

    final welcome = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Welcome to Diabuddy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: fontBold,
                      color: t3_textColorPrimary,
                      fontSize: 20.0),
                ).paddingAll(16),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Please select which user type you wish to associate your account with.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: fontBold,
                      color: t3_textColorPrimary,
                      fontSize: 20.0),
                ).paddingAll(16),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
                  textContent: 'Diabetic User',
                  onPressed: () =>
                      Navigator.pushNamed(context, diabeticuserquestion))
              .cornerRadiusWithClipRRect(25)
              .paddingAll(16),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
                  textContent: 'Buddy User',
                  onPressed: () =>
                      Navigator.pushNamed(context, buddyuserquestion))
              .cornerRadiusWithClipRRect(25)
              .paddingAll(16),
        ),
      ],
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              welcome
            ],
          ).paddingOnly(top: 16),
        ),
      ),
    );
  }
}
