import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/reminder_rule_field.widget.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_background.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_header.dart';
import 'package:diabetty/ui/screens/diary/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_reminder.dart';
import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TherapyProfileScreen2 extends StatefulWidget {
  final Therapy therapy;
  final TherapyManager manager;
  final BuildContext context;
  TherapyProfileScreen2({this.context, this.therapy, this.manager});

  @override
  _TherapyProfileScreen2State createState() => _TherapyProfileScreen2State();
}

class _TherapyProfileScreen2State extends State<TherapyProfileScreen2> {
  Color textColor = Colors.orange[800];

  @override
  Widget build(BuildContext context) {
    return TherapyProfileBackground(
        header: TherapyProfileHeader(), child: _body(context));
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        _buildHeader(size),
        Expanded(
            child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: _buildBody(size))),
        _buildFooter(size),
      ],
    );
  }

  Widget _buildBody(Size size) {
    List<Widget> reminderRulesList = (widget.therapy.schedule == null ||
            widget.therapy.schedule.reminderRules.isEmpty)
        ? List()
        : widget.therapy.schedule.reminderRules
            .map((e) => TherapyProfileReminder(rule: e) as Widget)
            .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: _buildStockField(),
          ),
          Row(
            children: [
              SizedBox(
                width: size.width * 0.03,
              ),
              Text(
                "reminders",
                style: TextStyle(
                  fontSize: textSizeLargeMedium - 3,
                  color: Colors.grey[700],
                ),
              )
            ],
          ),
          if (reminderRulesList.isNotEmpty)
            Container(
              padding: EdgeInsets.only(top: 10),
              child: (reminderRulesList.length < 7)
                  ? ColumnBuilder(
                      itemCount: reminderRulesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return reminderRulesList[index];
                      },
                    )
                  : 'yeye',
            ),
          if (reminderRulesList.isEmpty)
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'No reminders here man, move on pls',
                style: TextStyle(
                  fontSize: textSizeLargeMedium,
                  color: Colors.grey[700],
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: _buildWindowField(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: _buildMinRestField(),
          ),
        ],
      ),
    );
  }

  Widget _buildStockField() {
    return CustomTextField(
      stackIcons: _icons(
          color: (widget.therapy.stock == null ||
                  widget.therapy.stock.currentLevel == null ||
                  widget.therapy.stock.isOutOfStock)
              ? Colors.red
              : Colors.green),
      onTap: () {},
      placeholder: _getStockMessage(),
      placeholderText: 'Stock',
    );
  }

  Widget _buildWindowField() {
    return CustomTextField(
      stackIcons: _icons(
          color: (widget.therapy.schedule == null ||
                  widget.therapy.schedule.window == null)
              ? Colors.red
              : Colors.green),
      onTap: () {},
      placeholder: _getWindowMessage(),
      placeholderText: 'Window',
      placeholderTextStyle: TextStyle(
        fontSize: textSizeLargeMedium - 4,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildMinRestField() {
    return CustomTextField(
      stackIcons: _icons(
          color: (widget.therapy.medicationInfo == null ||
                  widget.therapy.medicationInfo.restDuration == null)
              ? Colors.red
              : Colors.green),
      onTap: () {},
      placeholder: _getMinRestMessage(),
      placeholderText: 'Minimum Rest Duration',
      placeholderTextStyle: TextStyle(
        fontSize: textSizeLargeMedium - 4,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildFooter(Size size) {
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height * 0.15),
        child: IntrinsicHeight(
            child: Container(
          padding: EdgeInsets.only(top: 15),
          width: size.width,
          decoration: BoxDecoration(
              color: appWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0),
                  spreadRadius: 0.5,
                  blurRadius: 1.5,
                  offset: Offset(0, -1),
                ),
              ],
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(200, 100, 100, 0.2),
                  width: 0.7,
                ),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.08,
                width: size.width * 0.16,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: textColor, width: 1)),
              ),
              Container(
                height: size.height * 0.08,
                width: size.width * 0.16,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: textColor, width: 1)),
              ),
              Container(
                height: size.height * 0.08,
                width: size.width * 0.16,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: textColor, width: 1)),
              ),
            ],
          ),
        )));
  }

  Container _buildHeader(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.20,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: appWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 0.5),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(1),
              spreadRadius: 3,
              blurRadius: 0,
              offset: Offset(0, -1),
            ),
          ],
          border: Border(
            bottom: BorderSide(
              color: Colors.transparent, // Color.fromRGBO(200, 100, 100, 0.4),
              width: 0.7,
            ),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.05,
                  width: size.width * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    appearance_iconss[
                        widget.therapy.medicationInfo.appearanceIndex],
                    width: 10,
                    height: 10,
                  ),
                ),
                SizedBox(width: size.width * 0.05),
                Text(widget.therapy.name,
                    style: TextStyle(
                        fontSize: 22.0,
                        color: textColor,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'last taken',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "3 hours ago",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "next",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "in 6 hours",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getWindowMessage() {
    return (widget.therapy.schedule == null ||
            widget.therapy.schedule.window == null)
        ? Text(
            'none',
            style: TextStyle(
              fontSize: textSizeLargeMedium - 4,
              color: Colors.grey[700],
            ),
          )
        : Text(
            prettyDuration(widget.therapy.schedule.window, abbreviated: false),
            style: TextStyle(
              fontSize: textSizeLargeMedium - 4,
              color: Colors.grey[700],
            ),
          );
  }

  _getMinRestMessage() {
    return (widget.therapy.medicationInfo == null ||
            widget.therapy.medicationInfo.restDuration == null)
        ? Text(
            'none',
            style: TextStyle(
              fontSize: textSizeLargeMedium - 4,
              color: Colors.grey[700],
            ),
          )
        : Text(
            prettyDuration(widget.therapy.medicationInfo.restDuration,
                abbreviated: false),
            style: TextStyle(
              fontSize: textSizeLargeMedium - 4,
              color: Colors.grey[700],
            ),
          );
  }

  _getStockMessage() {
    if (widget.therapy.stock == null ||
        widget.therapy.stock.currentLevel == null) {
      return Text(
        '',
        style: TextStyle(
          fontSize: textSizeLargeMedium - 4,
          color: Colors.grey[700],
        ),
      );
    } else if (widget.therapy.stock.isOutOfStock) {
      return Text(
        'Out of Stock',
        style: TextStyle(
          fontSize: textSizeLargeMedium - 4,
          color: Colors.grey[700],
        ),
      );
    } else if (widget.therapy.stock.isLowOnStock) {
      return Text(
        'Low on Stock',
        style: TextStyle(
          fontSize: textSizeLargeMedium - 4,
          color: Colors.grey[700],
        ),
      );
    } else {
      return Text(
        widget.therapy.stock.currentLevel.toString() + ' in Stock',
        style: TextStyle(
          fontSize: textSizeLargeMedium - 4,
          color: Colors.grey[700],
        ),
      );
    }
  }

  Stack _icons({MaterialColor color}) {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: true ? 0 : 1,
          duration: Duration(milliseconds: 1000),
          child: Icon(
            CupertinoIcons.circle_filled,
            color: Colors.black,
            size: 23,
          ),
        ),
        AnimatedOpacity(
          opacity: true ? 1 : 0,
          duration: Duration(milliseconds: 1000),
          child: Icon(
            CupertinoIcons.circle_filled,
            color: color,
            size: 23,
          ),
        )
      ],
    );
  }
}
