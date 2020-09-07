import 'dart:ui';

import 'package:diabetttty/utils/model/Models.dart';
import 'package:diabetttty/theme/T2Colors.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:diabetttty/utils/DataGenerator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetttty/themee/icons.dart';

import 'package:flutter_svg/svg.dart';

class DayPlanner extends StatefulWidget {
  @override
  _DayPlannerState createState() => _DayPlannerState();
}

class _DayPlannerState extends State<DayPlanner>
    with SingleTickerProviderStateMixin {
  List<MedicineCardModel> medicationCard;
  TabController tabController;
  Duration initialtimer = new Duration();
  DateTime newDate = DateTime(2020);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    medicationCard = getFavourites();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void removeCard(index) {
    setState(() {
      medicationCard.remove(index);
    });
  }

  _buildReminderCards(context, index) {
    var width = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
        child: SizedBox(
            height: 180,
            child: Column(
              children: <Widget>[
                Container(
                  child: text(
                    '10:30 - 12.30AM',
                    textColor: t2_colorPrimary,
                    fontFamily: 'Regular',
                    fontSize: textSizeSmall,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 5),
                ),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    SizedBox(
                        height: 75,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 5),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            drugs4_1,
                                            width: 28,
                                            height: 28,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: Column(
                                                //mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  text(
                                                      medicationCard[index]
                                                          .name,
                                                      textColor:
                                                          t2_colorPrimary,
                                                      fontFamily: 'Regular',
                                                      fontSize: textSizeMedium2,
                                                      maxLine: 2),
                                                  text(
                                                      medicationCard[index]
                                                          .duration,
                                                      fontSize: textSizeSmall),
                                                  text("1 of 2",
                                                      fontSize: textSizeSmall2),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                              padding:
                                                  EdgeInsets.only(right: 15),
                                              alignment: Alignment.center,
                                              child: IconButton(
                                                  onPressed: () {
                                                    _onAlert(context, index);
                                                    print("clucked");
                                                  },
                                                  padding: EdgeInsets.all(3),
                                                  // color: Colors.transparent,
                                                  icon: SvgPicture.asset(
                                                    'images/icons/checkbox/tick.svg',
                                                    width: 30,
                                                    color: Colors
                                                        .indigoAccent[100],
                                                    height: 30,
                                                  ))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                        height: 75,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 5),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            drugs4_1,
                                            width: 25,
                                            height: 25,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: Column(
                                                //mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  text(
                                                      medicationCard[index]
                                                          .name,
                                                      textColor:
                                                          t2_colorPrimary,
                                                      fontFamily: 'Regular',
                                                      fontSize: textSizeMedium2,
                                                      maxLine: 2),
                                                  text(
                                                      medicationCard[index]
                                                          .duration,
                                                      fontSize: textSizeSmall),
                                                  text("1 of 2",
                                                      fontSize: textSizeSmall2),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                              padding:
                                                  EdgeInsets.only(right: 15),
                                              alignment: Alignment.center,
                                              child: IconButton(
                                                  onPressed: () {
                                                    print("clucked");
                                                    _onAlert(context, index);
                                                  },
                                                  padding: EdgeInsets.all(3),
                                                  icon: SvgPicture.asset(
                                                    'images/icons/checkbox/filled.svg',
                                                    width: 30,
                                                    //* Great Color to use for it.
                                                    // color: Colors
                                                    //     .lightGreenAccent[700],
                                                    height: 30,
                                                  ))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ))
              ],
            )));
  }

  _showCupertinoTimerPicker() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              text("Postpone for...",
                  textColor: Colors.black,
                  fontSize: 15.0,
                  fontFamily: fontSemibold),
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).copyWith().size.height / 2.5,
              width: MediaQuery.of(context).copyWith().size.width,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newdate) {
                  print(newdate);
                  setState(() {
                    newDate = newdate;
                  });
                },
                use24hFormat: true,
                maximumDate: new DateTime(2030, 12, 30),
                minimumYear: 2020,
                maximumYear: 2030,
                minuteInterval: 1,
                mode: CupertinoDatePickerMode.dateAndTime,
              ),
            )
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }

  _onPostpone() {
    changeStatusColor(Colors.transparent);
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                  ),
                  child: _showCupertinoTimerPicker(),
                ),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).copyWith().size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: CupertinoDialogAction(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: CupertinoColors.destructiveRed),
                            )),
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        flex: 1,
                        child: CupertinoDialogAction(
                          onPressed: () => {
                            Navigator.pop(context),
                            print(newDate),
                          },
                          child: Text(
                            'Confirm',
                            style: TextStyle(color: CupertinoColors.activeBlue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  _onAlert(context, index) {
    changeStatusColor(Colors.transparent);
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black12,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (ctx, anim1, anim2) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              width: 350,
              height: 350,
              child: SizedBox(
                width: 350,
                height: 300,
                child: Card(
                  elevation: 1,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
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
                                        'images/icons/clock/info.svg',
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
                                color: Theme.of(context).primaryColor,
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
                                        'images/icons/clock/pen.svg',
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
                                        'images/icons/clock/trash.svg',
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
                                            SizedBox(width: 5),
                                            text(
                                              medicationCard[index].name,
                                              textColor: t2_colorPrimary,
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
                                                    text(
                                                        medicationCard[index]
                                                            .duration,
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
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    topLeft: Radius.circular(4),
                                  )),
                              height: 92,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
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
                                                print("clucked");
                                              },
                                              padding: EdgeInsets.all(3),
                                              icon: SvgPicture.asset(
                                                'images/icons/X/close.svg',
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                                                print("clucked");
                                              },
                                              padding: EdgeInsets.all(3),
                                              icon: SvgPicture.asset(
                                                'images/icons/checkbox/tick_outline2.svg',
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                                                _onPostpone();
                                              },
                                              padding: EdgeInsets.all(3),
                                              icon: SvgPicture.asset(
                                                'images/icons/clock/refresh.svg',
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
              ))),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          child: child,
          opacity: anim1,
        ),
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.white);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ]),
                child: SafeArea(
                    child: Container(
                        padding: EdgeInsets.only(left: 12),
                        alignment: Alignment.center,
                        child: Column(
                          //  mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[
                            text("Friday", fontFamily: 'Regular'),
                            text('22 August',
                                fontFamily: 'Regular',
                                // isCentered: true,
                                fontSize: textSizeSmall)
                          ],
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ))))),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.35,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: medicationCard.length,
                  itemBuilder: (context, index) {
                    return _buildReminderCards(context, index);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
