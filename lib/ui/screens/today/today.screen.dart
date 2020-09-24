import 'dart:ui';

import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/constants/models.dart';
import 'package:diabetty/ui/screens/today/medication_profile.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';

import 'package:flutter_svg/svg.dart';
import 'package:focused_menu/modals.dart';

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
  String postToggle = "List";

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
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MedicationProfile())),
                                        child: Row(
                                          children: <Widget>[
                                            ClipOval(
                                              child: Image(
                                                height: 30,
                                                width: 30,
                                                image: AssetImage(
                                                    'assets/icons/navigation/clock/medication.jpeg'),
                                                fit: BoxFit.cover,
                                              ),
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
                                                        fontSize:
                                                            textSizeMedium2,
                                                        maxLine: 2),
                                                    text(
                                                        medicationCard[index]
                                                            .duration,
                                                        fontSize:
                                                            textSizeSmall),
                                                    text("1 of 2",
                                                        fontSize:
                                                            textSizeSmall2),
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
                                                      'assets/icons/navigation/checkbox/tick.svg',
                                                      width: 30,
                                                      color: Colors
                                                          .indigoAccent[100],
                                                      height: 30,
                                                    ))),
                                          ],
                                        ),
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
                                                    'assets/icons/navigation/checkbox/filled.svg',
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
          padding: const EdgeInsets.fromLTRB(40, 15, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              text("Postpone until...",
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
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(top: 24),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                color: Color(0XFFF6F7FA),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
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

  ListTile _createTile(
      BuildContext context, String name, String time, Function action) {
    return ListTile(
      title: Text(name),
      subtitle: Text(time),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  _action1() {
    print('action1');
  }

  _action2() {
    print('action2');
  }

  _action3() {
    print('action3');
  }

  _showTaken() {
    var height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: height * 0.32,
            padding: EdgeInsets.only(top: 24),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                color: Color(0XFFF6F7FA),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      text("When did you take your meds? ",
                          fontSize: 12.0, fontFamily: fontRegular),
                    ],
                  ),
                ),
                _createTile(context, "On Time", "10:00am", _action1),
                _createTile(context, "Now", "${DateTime.now()}", _action2),
                _createTile(context, "Pick Exact Time", "", _action3),
              ],
            ),
          );
        });
  }

  _onAlert(context, index) {
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
                                              medicationCard[index].name,
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
                                  color: CupertinoColors.activeBlue,
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
                                                'assets/icons/navigation/X/close.svg',
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
                                              onPressed: () {
                                                _showTaken();
                                              },
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
                                              onPressed: () {
                                                _onPostpone();
                                              },
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

  _handleChange() {
    if (postToggle == "List") {
      print("list");
      print(postToggle);
      setState(() {
        postToggle = "Grid";
      });
    } else if (postToggle == "Grid") {
      print("grid");
      print(postToggle);
      setState(() {
        postToggle = "List";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
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
              padding: EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        text("Friday", fontFamily: 'Regular'),
                        text('22 August',
                            fontFamily: 'Regular',
                            // isCentered: true,
                            fontSize: textSizeSmall),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _handleChange(),
                    child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(top: 5),
                        child: SvgPicture.asset(
                          (postToggle == "Grid")
                              ? 'assets/icons/navigation/clock/grid.svg'
                              : 'assets/icons/navigation/clock/list.svg',
                          width: 24,
                          height: 24,
                          color: Colors.indigo,
                        )),
                  ),

                  // onTap: () => _showFilterMenu(),
                  FocusedMenuHolder(
                    onPressed: () {},
                    menuWidth: MediaQuery.of(context).size.width * 0.3,
                    blurSize: 5.0,
                    menuItemExtent: 45,
                    menuBoxDecoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    duration: Duration(milliseconds: 100),
                    animateMenuItems: true,
                    blurBackgroundColor: Colors.black54,
                    menuOffset: 20,
                    menuItems: <FocusedMenuItem>[
                      FocusedMenuItem(title: Text("All"), onPressed: () {}),
                      FocusedMenuItem(title: Text("Missed"), onPressed: () {}),
                      FocusedMenuItem(
                          title: Text("Scheduled"), onPressed: () {}),
                      FocusedMenuItem(
                          title: Text(
                            "Deleted",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          onPressed: () {}),
                    ],
                    child: Container(
                      padding: EdgeInsets.only(top: 5, right: 10),
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                          'assets/icons/navigation/clock/filter.svg',
                          width: 24,
                          height: 24,
                          color: Colors.indigo),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
    );
  }
}
