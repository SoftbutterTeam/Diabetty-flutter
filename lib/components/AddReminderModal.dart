import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AddReminderModal extends StatefulWidget {
  @override
  _AddReminderModalState createState() => _AddReminderModalState();
}

class _AddReminderModalState extends State<AddReminderModal> {
  var monday;
  var tuesday;
  var wednesday;
  var thursday;
  var friday;
  var saturday;
  var sunday;

  @override
  void initState() {
    super.initState();
    monday = false;
    tuesday = false;
    wednesday = false;
    thursday = false;
    friday = false;
    saturday = false;
    sunday = false;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return CupertinoAlertDialog(
      title: new Text("Add Reminder"),
      content: Container(
        margin: EdgeInsets.only(top: 10),
        height: height * 0.4,
        width: width,
        child: Column(
          children: <Widget>[
            Container(
              width: width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          monday = !monday;
                        });
                        print("monday == " + monday.toString());

                        if (monday == true) {
                          print('turureinfinwef');
                        } else if (monday == false) {
                          print('plswork');
                        }
                      },
                      child: Container(
                        child: Text("M").withStyle(
                            fontSize: 15,
                            color: monday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                        color: monday ? Colors.red : Colors.green,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 5,
                      color: Colors.black12,
                    ).paddingOnly(top: 32, left: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          monday = !monday;
                          print(monday);
                        });
                      },
                      child: Container(
                        child: Text("M").withStyle(
                            fontSize: 15,
                            color: monday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                        color: monday
                            ? Theme.of(context).primaryColor
                            : whiteColor,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 5,
                      color: Colors.black12,
                    ).paddingOnly(top: 32, left: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          monday = !monday;
                          print(monday);
                        });
                      },
                      child: Container(
                        child: Text("M").withStyle(
                            fontSize: 15,
                            color: monday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                        color: monday
                            ? Theme.of(context).primaryColor
                            : whiteColor,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 5,
                      color: Colors.black12,
                    ).paddingOnly(top: 32, left: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          monday = !monday;
                          print(monday);
                        });
                      },
                      child: Container(
                        child: Text("M").withStyle(
                            fontSize: 15,
                            color: monday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                        color: monday
                            ? Theme.of(context).primaryColor
                            : whiteColor,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 5,
                      color: Colors.black12,
                    ).paddingOnly(top: 32, left: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          monday = !monday;
                          print(monday);
                        });
                      },
                      child: Container(
                        child: Text("M").withStyle(
                            fontSize: 15,
                            color: monday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                        color: monday
                            ? Theme.of(context).primaryColor
                            : whiteColor,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 5,
                      color: Colors.black12,
                    ).paddingOnly(top: 32, left: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          monday = !monday;
                          print(monday);
                        });
                      },
                      child: Container(
                        child: Text("M").withStyle(
                            fontSize: 15,
                            color: monday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                        color: monday
                            ? Theme.of(context).primaryColor
                            : whiteColor,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 5,
                      color: Colors.black12,
                    ).paddingOnly(top: 32, left: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          monday = !monday;
                          print(monday);
                        });
                      },
                      child: Container(
                        child: Text("M").withStyle(
                            fontSize: 15,
                            color: monday
                                ? whiteColor
                                : Theme.of(context).primaryColor),
                        color: monday
                            ? Theme.of(context).primaryColor
                            : whiteColor,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
