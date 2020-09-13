import 'package:diabetttty/ui/components/header.dart';
import 'package:diabetttty/ui/theme/AppConstant.dart';
import 'package:diabetttty/ui/theme/Extension.dart';
import 'package:diabetttty/ui/theme/T2Colors.dart';
import 'package:diabetttty/ui/theme/colors.dart';
import 'package:diabetttty/ui/theme/strings.dart';
import 'package:diabetttty/ui/theme/widgets.dart';
import '../../theme/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
/*
class ReminderCard extends StatefulWidget {
  int reminderId;
  ReminderCard({int reminderId, int abc}) {
    this.reminderId = reminderId;
    this.reminderId = abc;
  }
  @override
  _ReminderCardState createState() => _ReminderCardState(this.reminderId);
}

class _ReminderCardState extends State<ReminderCard> {
  _ReminderCardState(reminderId) : this.reminderId = reminderId;

  int reminderId;
  bool exampleState;

  @override
  void initState() {
    super.initState();
    exampleState = true;
  }

  Container reminderCard() {
    var width = MediaQuery.of(context).size.width;
    return (Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: IntrinsicHeight(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                width: 10,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                            d_1,
                            width: width / 5,
                            height: width / 4.2,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  text('name',
                                      textColor: t2_colorPrimary,
                                      fontFamily: fontBold,
                                      fontSize: textSizeMedium,
                                      maxLine: 2),
                                  text('timw', fontSize: textSizeMedium),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      text("Something", fontSize: textSizeMedium, maxLine: 2),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return reminderCard();
  }
}
*/
