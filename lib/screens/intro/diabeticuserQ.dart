import 'package:diabetttty/components/index.dart';
import 'package:diabetttty/screens/intro_questions/finalPage.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

class DiabeticUserQuestions extends StatefulWidget {
  @override
  _DiabeticUserQuestionsState createState() => _DiabeticUserQuestionsState();
}

class _DiabeticUserQuestionsState extends State<DiabeticUserQuestions> {
  var btn2 = false;
  var btn3 = false;
  var btn4 = false;
  var btn5 = false;

  var agree = false;

  var step = 1;

  Widget build(BuildContext context) {
    changeStatusColor(Theme.of(context).scaffoldBackgroundColor);

    final age = Column(
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
                  'Please enter your age?',
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
                  hintText: "Please Enter Your Age",
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
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
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
                  btn5 = false;
                  btn4 = false;
                  btn3 = false;
                  btn2 = true;
                  step = 2;
                });
              }).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
      ],
    );

    final type = Column(
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
              Text(
                'Are you Type 1 or Type 2 diabetic?',
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
            textContent: 'Type 1',
            onPressed: () => {
              setState(
                () {
                  btn5 = false;
                  btn4 = false;
                  btn3 = true;
                  btn2 = true;
                  step = 3;
                },
              )
            },
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
            textContent: 'Type 2',
            onPressed: () => {
              setState(
                () {
                  btn5 = false;
                  btn4 = false;
                  btn3 = true;
                  btn2 = true;
                  step = 3;
                },
              )
            },
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
      ],
    );

    final bloodsugar = Column(
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
                'How often do you have to take blood sugar checks on a daily basis?',
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
            textContent: 'Less than 5 times',
            onPressed: () => {
              setState(
                () {
                  btn5 = false;
                  btn4 = true;
                  btn3 = true;
                  btn2 = true;
                  step = 4;
                },
              )
            },
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
            textContent: 'Between 5-10 times',
            onPressed: () => {
              setState(
                () {
                  btn5 = false;
                  btn4 = true;
                  btn3 = true;
                  btn2 = true;
                  step = 4;
                },
              )
            },
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
            textContent: 'Between 11-15 times',
            onPressed: () => {
              setState(
                () {
                  btn5 = false;
                  btn4 = true;
                  btn3 = true;
                  btn2 = true;
                  step = 4;
                },
              )
            },
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
      ],
    );

    final insulinregulation = Column(
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
                'What method of insulin regulation do you currently use?',
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
            textContent: 'Finger-Prick Blood Testing Kit',
            onPressed: () => {
              setState(
                () {
                  btn5 = true;
                  btn4 = true;
                  btn3 = true;
                  btn2 = true;
                  step = 5;
                },
              )
            },
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
            textContent: 'Diabetic Pump',
            onPressed: () => {
              setState(
                () {
                  btn5 = true;
                  btn4 = true;
                  btn3 = true;
                  btn2 = true;
                  step = 5;
                },
              )
            },
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
        SizedBox(height: 20),
        LoginEditTextStyle("Another Method", null , isPassword: false),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
            textContent: 'Submit',
            onPressed: () => {
              setState(
                () {
                  btn5 = true;
                  btn4 = true;
                  btn3 = true;
                  btn2 = true;
                  step = 5;
                },
              )
            },
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
      ],
    );

    final generalhealth = Column(
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
              Text(
                'How would you describe your general health condition?',
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
                  textContent: 'Healthy',
                  onPressed: () =>
                      Navigator.push(context, ScaleRoute(page: FinalPage())))
              .cornerRadiusWithClipRRect(25)
              .paddingAll(16),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
                  textContent: 'Some underlying Health conditions',
                  onPressed: () =>
                      Navigator.push(context, ScaleRoute(page: FinalPage())))
              .cornerRadiusWithClipRRect(25)
              .paddingAll(16),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
                  textContent: 'Unwell',
                  onPressed: () =>
                      Navigator.push(context, ScaleRoute(page: FinalPage())))
              .cornerRadiusWithClipRRect(25)
              .paddingAll(16),
        ),
        SizedBox(height: 20),
        LoginEditTextStyle("Another Method", null , isPassword: false),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
                  textContent: 'Submit',
                  onPressed: () =>
                      Navigator.push(context, ScaleRoute(page: FinalPage())))
              .cornerRadiusWithClipRRect(25)
              .paddingAll(16),
        ),
      ],
    );

    final stepView = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        MaterialButton(
          child: Text("1").withStyle(fontSize: 18, color: whiteColor),
          color: Theme.of(context).primaryColor,
          minWidth: 50,
          height: 50,
          onPressed: () {
            setState(() {
              btn2 = false;
              btn3 = false;
              btn4 = false;
              btn5 = false;
              step = 1;
            });
          },
        ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 8),
        Container(
          height: 1,
          width: 20,
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
              btn3 = false;
              btn2 = true;
              btn4 = false;
              btn5 = false;
              step = 2;
            });
          },
        ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 8),
        Container(
          height: 1,
          width: 20,
          color: Colors.black12,
        ).paddingOnly(top: 32, left: 8),
        MaterialButton(
          child: Text("3").withStyle(
              fontSize: 18,
              color: btn3 ? whiteColor : Theme.of(context).primaryColor),
          color: btn3 ? Theme.of(context).primaryColor : whiteColor,
          minWidth: 50,
          height: 50,
          onPressed: () {
            setState(() {
              btn2 = true;
              btn3 = true;
              btn4 = false;
              btn5 = false;
              step = 3;
            });
          },
        ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 8),
        Container(
          height: 1,
          width: 20,
          color: Colors.black12,
        ).paddingOnly(top: 32, left: 8),
        MaterialButton(
          child: Text("4").withStyle(
              fontSize: 18,
              color: btn4 ? whiteColor : Theme.of(context).primaryColor),
          color: btn4 ? Theme.of(context).primaryColor : whiteColor,
          minWidth: 50,
          height: 50,
          onPressed: () {
            setState(() {
              btn2 = true;
              btn3 = true;
              btn4 = true;
              btn5 = false;
              step = 3;
            });
          },
        ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 8),
        Container(
          height: 1,
          width: 20,
          color: Colors.black12,
        ).paddingOnly(top: 32, left: 8),
        MaterialButton(
          child: Text("5").withStyle(
              fontSize: 18,
              color: btn5 ? whiteColor : Theme.of(context).primaryColor),
          color: btn5 ? Theme.of(context).primaryColor : whiteColor,
          minWidth: 50,
          height: 50,
          onPressed: () {
            setState(() {
              btn2 = true;
              btn3 = true;
              btn4 = true;
              btn5 = true;
              step = 3;
            });
          },
        ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 8),
      ],
    );

    Widget selectedWidget() {
      if (step == 1) {
        return age;
      } else if (step == 2) {
        return type;
      } else if (step == 3) {
        return bloodsugar;
      } else if (step == 4) {
        return insulinregulation;
      } else {
        return generalhealth;
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
