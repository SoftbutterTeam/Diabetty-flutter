import 'package:diabetttty/components/index.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BuddyUserQuestions extends StatefulWidget {
  @override
  _BuddyUserQuestionsState createState() => _BuddyUserQuestionsState();
}

class _BuddyUserQuestionsState extends State<BuddyUserQuestions> {
  var btn1 = true;
  var btn2 = false;

  var step = 1;

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Theme.of(context).scaffoldBackgroundColor);

    final code = Column(
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
                  codeQ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: fontBold,
                      color: t3_textColorPrimary,
                      fontSize: 20.0),
                ).paddingAll(16),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(
                    fontSize: textSizeMedium, fontFamily: fontRegular),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
                  hintText: "Please enter your referral code...",
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
              textContent: 'Submit',
              onPressed: () {
                setState(() {
                  btn2 = true;
                  step = 2;
                });
              }).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
      ],
    );

    final notifications = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                notificationQ,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: fontBold,
                    color: t3_textColorPrimary,
                    fontSize: 20.0),
              ).paddingAll(16),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
            textContent: all,
            onPressed: () => Navigator.pushNamed(context, diary),
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
            textContent: important,
            onPressed: () => Navigator.pushNamed(context, diary),
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
            textContent: emergency,
            onPressed: () => Navigator.pushNamed(context, diary),
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
      ],
    );

    final stepView =
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      MaterialButton(
        child: Text("1").withStyle(fontSize: 18, color: whiteColor),
        color: Theme.of(context).primaryColor,
        minWidth: 50,
        height: 50,
        onPressed: () {
          setState(() {
            btn2 = false;
            step = 1;
          });
        },
      ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 20),
      Container(
        height: 1,
        width: 250,
        color: Colors.black12,
      ).paddingOnly(top: 32, left: 8),
      MaterialButton(
        child: Text("2").withStyle(
            fontSize: 18,
            color: btn2 ? whiteColor : Theme.of(context).primaryColor),
        color: btn2 ? Theme.of(context).primaryColor : whiteColor,
        minWidth: 50,
        height: 50,
        onPressed: () {
          setState(() {
            btn2 = true;
            step = 2;
          });
        },
      ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 8),
    ]);

    Widget selectedWidget() {
      if (step == 1) {
        return code;
      } else {
        return notifications;
      }
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              stepView,
              selectedWidget()
            ],
          ).paddingOnly(top: 16),
        ),
      ),
    );
  }
}
