import 'package:diabetttty/ui/components/index.dart';
import 'package:diabetttty/controllers/Register_Con.dart';
import 'package:diabetttty/system/AppProvider.dart';
import 'package:diabetttty/ui/screens/login.dart';
import 'package:diabetttty/oldfiles/UserForm.dart';
import 'package:diabetttty/ui/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DiabeticUserQuestions extends StatefulWidget {
  @override
  _DiabeticUserQuestionsState createState() => _DiabeticUserQuestionsState();
}

class _DiabeticUserQuestionsState extends State<DiabeticUserQuestions> {
  UserForm userform = UserForm();
  TextEditingController _ageController = TextEditingController();
  var btn2 = false;
  var btn3 = false;
  var btn4 = false;

  var step = 1;

  var appState;

  final _signupKey = GlobalKey<FormState>();

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
                  ageQ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: fontBold,
                      color: t3_textColorPrimary,
                      fontSize: 20.0),
                ).paddingAll(16),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _ageController,
                style: TextStyle(
                    fontSize: textSizeMedium, fontFamily: fontRegular),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
                  hintText: "Age...",
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
                  userform.age = _ageController.text;
                  btn4 = false;
                  btn3 = false;
                  btn2 = true;
                  step = 2;
                });
                print(_ageController.text);
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
                typeQ,
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
            textContent: type1,
            onPressed: () => {
              setState(
                () {
                  userform.type = type1;
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
            textContent: type2,
            onPressed: () => {
              setState(
                () {
                  userform.type = type2;
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
                bloodsugarQ,
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
            textContent: lessThan5,
            onPressed: () => {
              setState(
                () {
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
            textContent: between,
            onPressed: () => {
              setState(
                () {
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
            textContent: more,
            onPressed: () => {
              setState(
                () {
                  btn4 = true;
                  btn3 = true;
                  btn2 = true;
                  step = 4;
                },
              ),
            },
          ).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
      ],
    );

    void submitForm() {
      appState = Provider.of<AppState>(context, listen: false);
      RegisterCon.submitIntroData(appState, userform);
      Navigator.pushNamed(context, diary);
    }

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
                insulinregulationQ,
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
              textContent: testingkit,
              onPressed: () {
                submitForm();
              }).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
              textContent: pump,
              onPressed: () {
                submitForm();
              }).cornerRadiusWithClipRRect(25).paddingAll(16),
        ),
        SizedBox(height: 20),
        TextInputs(hintText: "Another Method..."),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: RoundedButton(
              textContent: 'Submit',
              onPressed: () {
                submitForm();
                print(userform.name); //null
                print(userform.email); //null
                print(userform.type);
                print(userform
                    .accountType); //null  --> on different screens, is ok?
                print(userform.age);
              }).cornerRadiusWithClipRRect(25).paddingAll(16),
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
              step = 1;
            });
          },
        ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 8),
        Container(
          height: 1,
          width: 48,
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
              step = 2;
            });
          },
        ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 8),
        Container(
          height: 1,
          width: 48,
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
              step = 3;
            });
          },
        ).cornerRadiusWithClipRRect(20).paddingOnly(top: 32, left: 8),
        Container(
          height: 1,
          width: 48,
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
      }
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Form(
            key: _signupKey,
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
      ),
    );
  }
}
