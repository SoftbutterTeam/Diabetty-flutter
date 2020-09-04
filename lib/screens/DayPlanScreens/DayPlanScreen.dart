import 'package:diabetttty/utils/model/Models.dart';
import 'package:diabetttty/theme/T2Colors.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:diabetttty/utils/DataGenerator.dart';
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

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.white);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
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
                            alignment: Alignment.centerLeft,
                            child:
                                text("Friday 22nd", fontFamily: 'Regular'))))),
            body: TabBarView(children: <Widget>[
              Column(
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
              SingleChildScrollView(
                child: Center(
                  child: Container(
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: Text("Blood Checks")),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
