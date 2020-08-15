import 'package:diabetttty/components/index.dart';
import 'package:diabetttty/controllers/Register_Con.dart';
import 'package:diabetttty/models/AppState.dart';

import 'package:diabetttty/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;

import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  bool _obscureText = true;
  TabController tabController;
  bool isLoggedIn;
  var agree = true;
  var appState;
  @override
  void initState() {
    super.initState();
    appState = Provider.of<AppState>(context, listen: false);
    isLoggedIn = appState.isLoggedIn;
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print("login page building....");

    changeStatusColor(Colors.white);
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                color: Colors.white,
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.58,
                        child: new TabBar(
                          indicatorColor: Theme.of(context).primaryColor,
                          tabs: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: t3_textColorPrimary,
                                    fontFamily: fontBold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                'Sign-Up',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: t3_textColorPrimary,
                                    fontFamily: fontBold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                //LoginSafeArea(
                Center(
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 4)),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: width / 7),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextInputs(
                            isEmail: true,
                            hintText: "Email",
                            validator: (String value) {
                              if (!validator.isEmail(value)) {
                                return "Please enter a valid Email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextInputs(
                            hintText: "Password",
                            isPassword: true,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40, right: 40),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  child: Icon(
                                    agree
                                        ? Icons.check_box_outline_blank
                                        : Icons.check_box,
                                    size: 25,
                                    color: Theme.of(context).primaryColor,
                                  ).paddingOnly(top: 8, left: 16),
                                  onTap: () {
                                    setState(() {
                                      agree = !agree;
                                    });
                                  },
                                ),
                                SizedBox(width: 8),
                                InkWell(
                                  child: Text(
                                    "Remember me",
                                    style: primaryTextStyle(
                                        size: 18,
                                        color: Theme.of(context).primaryColor),
                                  ).paddingTop(8),
                                  onTap: () {
                                    setState(() {
                                      agree = !agree;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 200,
                              alignment: Alignment.center,
                              child: RoundedButton(
                                onPressed: () {},
                                textContent: "Enter",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 200,
                              alignment: Alignment.center,
                              child: RoundedButton(
                                onPressed: () {
                                  RegisterCon.registerAsGuest(
                                      appState, "Friend");
                                  //Navigator.pop(context);
                                  Navigator.pushNamed(context, initialquestion);
                                },
                                textContent: "Continue as Guest",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 4)),
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: width / 8.5),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextInputs(
                              hintText: "Full name",
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Enter your full name";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextInputs(
                              isEmail: true,
                              hintText: "Email",
                              validator: (String value) {
                                if (!validator.isEmail(value)) {
                                  return "Please enter a valid Email";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextInputs(
                              hintText: "Password",
                              validator: (String value) {
                                if (value.length < 6) {
                                  return "At least 6 characters needed";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextInputs(
                              hintText: "Re-Enter Password",
                              validator: (String value) {
                                if (value.length < 6) {
                                  return "At least 6 characters needed";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              width: 120,
                              alignment: Alignment.center,
                              child: RoundedButton(
                                onPressed: () {
                                  if (true) {
                                    //TODO Save User Account information and Profile info
                                    Navigator.pushNamed(
                                        context, initialquestion);
                                  }
                                },
                                textContent: "Join",
                              ),
                            ),
                            SizedBox(height: 20),
                            text("By Pressing 'Join' you agree to our"),
                            SizedBox(height: 4),
                            GestureDetector(
                              child: Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                  fontSize: textSizeLargeMedium,
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
