import 'dart:ui';

import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@optionalTypeArgs
mixin ReminderActionsMixin<T extends Widget> {
  @protected
  Reminder get reminder;

  void showTakeModalPopup(BuildContext context) => showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          //  title: const Text('When did you it?'),
          message: const Text('When did you take it?'),

          actions: <Widget>[
            CupertinoActionSheetAction(onPressed: () {}, child: Text('Now')),
            CupertinoActionSheetAction(
                onPressed: () {}, child: Text('On Time')),
            CupertinoActionSheetAction(
                onPressed: () {}, child: Text('Choose a Time')),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Container(color: Colors.white, child: Text('Cancel')),
          ),
        ),
      );

  void showReminderPopupModal(BuildContext context) => showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        barrierColor: Colors.white12, //black12 white
        pageBuilder: (context, anim1, anim2) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _reminderModal(context)),
        transitionBuilder: _transitionBuilderStyle1(),
        transitionDuration: Duration(milliseconds: 200),
      );

  _transitionBuilderStyle1() =>
      (context, anim1, anim2, child) => BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
          child: Container(
            alignment: Alignment.center,
            child: FadeTransition(
              child: child,
              opacity: anim1,
            ),
          ));
}

Widget _reminderModal(BuildContext context) {
  return GestureDetector(
    onPanDown: (val) => Navigator.pop(context),
    child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: SizedBox(
          width: 350,
          height: 300,
          child: Card(
            elevation: 1,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: GestureDetector(
              onTap: () {},
              onPanStart: (value) {},
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: CupertinoColors.activeBlue,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(4))),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                      child: IconButton(
                                    padding: EdgeInsets.all(3),
                                    icon: SvgPicture.asset(
                                      'assets/icons/navigation/clock/info.svg',
                                      width: 25,
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                    // or Icons(Icon.info)
                                    color: Colors.white,
                                    onPressed: () {
                                      print('clicked');
                                    },
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: CupertinoColors.activeBlue,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                      child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: SvgPicture.asset(
                                      'assets/icons/navigation/clock/pen.svg',
                                      width: 25,
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      print('clicked');
                                    },
                                  )),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 30,
                                  width: 30,
                                  margin: EdgeInsets.only(right: 10),
                                  child: Center(
                                      child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: SvgPicture.asset(
                                      'assets/icons/navigation/clock/trash.svg',
                                      width: 25,
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      print('clicked');
                                    },
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: 150,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 65,
                                      width: 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                color: Colors.red),
                                          ),
                                          SizedBox(width: 15),
                                          text(
                                            'name',
                                            textColor:
                                                CupertinoColors.activeBlue,
                                            fontFamily: 'Bold',
                                            fontSize: textSizeMedium2,
                                            maxLine: 2,
                                            isCentered: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height: 45,
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.schedule,
                                              color: Colors.black,
                                              size: 22,
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 0, 0, 0),
                                              child: Row(
                                                children: <Widget>[
                                                  text('more details',
                                                      textColor: Colors.black,
                                                      fontSize: 12.0,
                                                      isCentered: true),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: CupertinoColors.activeBlue,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  topLeft: Radius.circular(4),
                                )),
                            height: 92,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: CupertinoColors.activeBlue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      height: 75,
                                      width: 60,
                                      child: Column(
                                        children: <Widget>[
                                          IconButton(
                                            onPressed: () {
                                              print('Skipped');
                                            },
                                            padding: EdgeInsets.all(3),
                                            icon: SvgPicture.asset(
                                              'assets/icons/navigation/x/close.svg',
                                              width: 30,
                                              height: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          text(
                                            "Skip",
                                            textColor: Colors.white,
                                            fontFamily: fontSemibold,
                                            fontSize: 12.0,
                                            maxLine: 2,
                                            isCentered: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: CupertinoColors.activeBlue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      height: 75,
                                      width: 60,
                                      child: Column(
                                        children: <Widget>[
                                          IconButton(
                                            onPressed: () {},
                                            padding: EdgeInsets.all(3),
                                            icon: SvgPicture.asset(
                                              'assets/icons/navigation/checkbox/tick_outline2.svg',
                                              width: 30,
                                              height: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          text(
                                            "Take",
                                            textColor: Colors.white,
                                            fontFamily: fontSemibold,
                                            fontSize: 12.0,
                                            maxLine: 2,
                                            isCentered: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: CupertinoColors.activeBlue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      height: 75,
                                      width: 60,
                                      child: Column(
                                        children: <Widget>[
                                          IconButton(
                                            onPressed: () {},
                                            padding: EdgeInsets.all(3),
                                            icon: SvgPicture.asset(
                                              'assets/icons/navigation/clock/time.svg',
                                              width: 30,
                                              height: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          text(
                                            "Postpone",
                                            textColor: Colors.white,
                                            fontFamily: fontSemibold,
                                            fontSize: 12.0,
                                            maxLine: 2,
                                            isCentered: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
  );
}
