import 'package:diabetttty/components/index.dart';
import 'package:diabetttty/model/Models.dart';
import 'package:diabetttty/theme/Extension.dart';
import 'package:diabetttty/theme/T2Colors.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:diabetttty/themee/icons.dart';
import 'package:diabetttty/utils/DataGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class TherapyPlanner extends StatefulWidget {
  @override
  _TherapyPlannerState createState() => _TherapyPlannerState();
}

class _TherapyPlannerState extends State<TherapyPlanner>
    with SingleTickerProviderStateMixin {
  List<MedicineCardModel> medicationCard;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    medicationCard = getMedicalCards();
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

  _buildMedicalCards(context, index) {
    var width = MediaQuery.of(context).size.width;
    return Slidable(
      key: ValueKey(index),
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              IconSlideAction(
                caption: '',
                color: Colors.transparent,
                icon: Icons.edit,
                closeOnTap: true,
                foregroundColor: Colors.transparent,
                onTap: () {},
              ),
              RotatedBox(
                quarterTurns: -1,
                child: text("Edit",
                    textColor: Colors.white,
                    isCentered: true,
                    latterSpacing: 5.0,
                    fontFamily: fontSemibold),
              )
            ],
            alignment: Alignment.center,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.green,
          ),
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
          alignment: Alignment.center,
        )
      ],
      secondaryActions: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              IconSlideAction(
                caption: '',
                color: Colors.transparent,
                icon: Icons.edit,
                closeOnTap: true,
                foregroundColor: Colors.transparent,
                onTap: () {
                  removeCard(index);
                  print("Removed hopefully");
                },
              ),
              RotatedBox(
                quarterTurns: -1,
                child: GestureDetector(
                  child: text("Remove",
                      textColor: Colors.white,
                      isCentered: true,
                      latterSpacing: 5.0,
                      fontFamily: fontSemibold),
                  onTap: () {
                    print("Removeeed this bitch");
                  },
                ),
              )
            ],
            alignment: Alignment.center,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.red,
          ),
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          alignment: Alignment.center,
        ),
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
      ),
      child: Container(
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
                            SvgPicture.asset(
                              d_1,
                              width: width / 7,
                              height: width / 5,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    text(medicationCard[index].name,
                                        textColor: t2_colorPrimary,
                                        fontFamily: fontBold,
                                        fontSize: textSizeMedium,
                                        maxLine: 2),
                                    text(medicationCard[index].duration,
                                        fontSize: textSizeMedium),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(
                                  d_1,
                                  width: 22,
                                  height: 22,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildBloodCheckCards(context, index) {
    var width = MediaQuery.of(context).size.width;
    return Slidable(
      key: ValueKey(index),
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              IconSlideAction(
                caption: '',
                color: Colors.transparent,
                icon: Icons.edit,
                closeOnTap: true,
                foregroundColor: Colors.transparent,
                onTap: () {},
              ),
              RotatedBox(
                quarterTurns: -1,
                child: text("Edit",
                    textColor: Colors.white,
                    isCentered: true,
                    latterSpacing: 5.0,
                    fontFamily: fontSemibold),
              )
            ],
            alignment: Alignment.center,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.green,
          ),
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
          alignment: Alignment.center,
        )
      ],
      secondaryActions: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              IconSlideAction(
                caption: '',
                color: Colors.transparent,
                icon: Icons.edit,
                closeOnTap: true,
                foregroundColor: Colors.transparent,
                onTap: () {
                  removeCard(index);
                  print("Removed hopefully");
                },
              ),
              RotatedBox(
                quarterTurns: -1,
                child: GestureDetector(
                  child: text("Delete",
                      textColor: Colors.white,
                      isCentered: true,
                      latterSpacing: 2.0,
                      fontFamily: fontSemibold),
                  onTap: () {
                    print("Removeeed this bitch");
                  },
                ),
              )
            ],
            alignment: Alignment.center,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.red,
          ),
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          alignment: Alignment.center,
        ),
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
      ),
      child: Container(
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
                  color: Colors.red,
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
                            //     SvgPicture.asset(
                            //       d_1,
                            //       width: width / 7,
                            //       height: width / 5,
                            //     ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    text(medicationCard[index].name,
                                        textColor: Colors.red,
                                        fontFamily: fontBold,
                                        fontSize: textSizeMedium,
                                        maxLine: 2),
                                    text(medicationCard[index].duration,
                                        fontSize: textSizeMedium),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          decoration: boxDecoration(
                                              showShadow: false,
                                              radius: 26,
                                              color: Colors.black),
                                          width: width * 0.10,
                                          height: width * 0.10,
                                          padding: EdgeInsets.all(8),
                                          child: SvgPicture.asset(
                                            notification,
                                            width: 20,
                                            height: 20,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        width: width,
                        child: new TabBar(
                          indicatorColor: Theme.of(context).primaryColor,
                          tabs: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                "Medication",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: t3_textColorPrimary,
                                    fontFamily: fontBold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                'Blood Checks',
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
            body: TabBarView(children: <Widget>[
              Column(
                children: <Widget>[
                  // SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: medicationCard.length,
                        itemBuilder: (context, index) {
                          return _buildMedicalCards(context, index);
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: width * 0.95,
                      child: RoundedButton(
                        textContent: "Add",
                        onPressed: () {
                          Navigator.pushNamed(context, addmedication);
                        },
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  // SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: medicationCard.length,
                        itemBuilder: (context, index) {
                          return _buildBloodCheckCards(context, index);
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: width * 0.95,
                      child: RoundedButton(
                        textContent: "Add",
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
