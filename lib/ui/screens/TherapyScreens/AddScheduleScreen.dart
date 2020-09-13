import 'package:diabetttty/ui/theme/AppColors.dart';
import 'package:diabetttty/ui/theme/AppConstant.dart';
import 'package:diabetttty/ui/theme/AppWidget.dart';
import 'package:diabetttty/ui/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

class AddScheduleScreen extends StatefulWidget {
  static var tag = "/draftscreen";

  @override
  AddScheduleScreenState createState() => AddScheduleScreenState();
}

class AddScheduleScreenState extends State<AddScheduleScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _firstScreen();
  }

  Scaffold _firstScreen() {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: SafeArea(
            child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ]),
                child: SafeArea(
                    child: Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        alignment: Alignment.center,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 1),
                              child: text("Add Medication",
                                  //  fontFamily: 'SfPro',
                                  fontSize: textSizeMedium),
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 5),
                                alignment: Alignment.centerLeft,
                                child: FlatButton(
                                  onPressed: () {},
                                  color: Colors.transparent,
                                  disabledTextColor: Colors.grey,
                                  disabledColor: Colors.transparent,
                                  padding: EdgeInsets.zero,
                                  child: Align(
                                    child: text('Cancel',
                                        fontSize: textSizeMedium2,
                                        //fontFamily: 'Regular',
                                        textColor: Colors.blue[900]),
                                    alignment: Alignment.centerLeft,
                                  ),
                                )),
                            Container(
                                padding: EdgeInsets.only(top: 5),
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                  onPressed: () {},
                                  color: Colors.transparent,
                                  disabledTextColor: Colors.grey,
                                  disabledColor: Colors.transparent,
                                  padding: EdgeInsets.zero,
                                  child: Align(
                                    child: text('Next',
                                        fontSize: textSizeMedium2,
                                        //fontFamily: 'Regular',
                                        textColor: Colors.blue[900]),
                                    alignment: Alignment.centerRight,
                                  ),
                                )),
                          ],
                        )))),
          )),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: text('Med Info'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: CupertinoTextField(
                      decoration: BoxDecoration(
                        color: appWhite,
                        border: Border.all(
                            color: Colors.black54,
                            width: 0.1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      prefix: Container(
                          padding: EdgeInsets.only(left: 17),
                          child: Icon(
                            CupertinoIcons.heart,
                            size: 23,
                          )),
                      placeholder: 'Medication Name...',
                      maxLines: 1,
                      maxLength: 30,
                      padding: EdgeInsets.only(
                          left: 16, top: 9.5, bottom: 9.5, right: 10),
                      style: TextStyle(
                          fontSize: textSizeLargeMedium - 1.5,
                          fontFamily: 'Regular')),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Icon(
                          CupertinoIcons.heart,
                          size: 23,
                        )),
                    suffix: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(children: [
                          Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 2),
                              child: text('none', fontSize: textSizeMedium2)),
                          Icon(
                            CupertinoIcons.right_chevron,
                            size: 20,
                          )
                        ])),
                    placeholder: 'Set Strength',
                    readOnly: true,
                    maxLines: 1,
                    maxLength: 30,
                    padding:
                        EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
                    placeholderStyle: TextStyle(
                      fontSize: textSizeLargeMedium - 3,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Icon(
                          CupertinoIcons.heart,
                          size: 23,
                        )),
                    suffix: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(children: [
                          Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 2),
                              child: text('none', fontSize: textSizeMedium2)),
                          Icon(
                            CupertinoIcons.right_chevron,
                            size: 20,
                          )
                        ])),
                    placeholder: 'Appearance',
                    readOnly: true,
                    maxLines: 1,
                    maxLength: 30,
                    padding:
                        EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
                    placeholderStyle: TextStyle(
                      fontSize: textSizeLargeMedium - 3,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Icon(
                          CupertinoIcons.heart,
                          size: 23,
                        )),
                    suffix: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(children: [
                          Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 2),
                              child: text('none', fontSize: textSizeMedium2)),
                          Icon(
                            CupertinoIcons.right_chevron,
                            size: 20,
                          )
                        ])),
                    placeholder: 'Intake Advice',
                    readOnly: true,
                    maxLines: 1,
                    maxLength: 30,
                    padding:
                        EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
                    placeholderStyle: TextStyle(
                      fontSize: textSizeLargeMedium - 3,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                  ),
                  child: text('extra details for more assistance features',
                      fontSize: textSizeSmall),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Icon(
                          CupertinoIcons.heart,
                          size: 23,
                        )),
                    suffix: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(children: [
                          Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 2),
                              child: text('none', fontSize: textSizeMedium2)),
                          Icon(
                            CupertinoIcons.right_chevron,
                            size: 20,
                          )
                        ])),
                    placeholder: 'Minimum Rest Duration',
                    readOnly: true,
                    maxLines: 1,
                    maxLength: 30,
                    padding:
                        EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
                    placeholderStyle: TextStyle(
                      fontSize: textSizeLargeMedium - 3,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: appWhite,
                      border: Border.all(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefix: Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Icon(
                          CupertinoIcons.heart,
                          size: 23,
                        )),
                    suffix: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(children: [
                          Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 2),
                              child: text('none', fontSize: textSizeMedium2)),
                          Icon(
                            CupertinoIcons.right_chevron,
                            size: 20,
                          )
                        ])),
                    placeholder: 'Max per Day',
                    readOnly: true,
                    maxLines: 1,
                    maxLength: 30,
                    padding:
                        EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
                    placeholderStyle: TextStyle(
                      fontSize: textSizeLargeMedium - 3,
                      color: Colors.grey[700],
                    ),
                  ),
                )*/
              ],
            ),
          )
        ],
      ),
    );
  }
}
