import 'package:diabetttty/utils/model/Models.dart';
import 'package:diabetttty/theme/T2Colors.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:diabetttty/utils/DataGenerator.dart';
import 'package:flutter/material.dart';
import 'package:diabetttty/themee/icons.dart';
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
      ),
    );
  }

  @override
  Widget build1(BuildContext context) {
    changeStatusColor(Colors.white);
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: Container(
                height: 200,
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
                        child: Column(children: [
                          Stack(
                            children: <Widget>[
                              Center(
                                child: text("", fontFamily: 'Regular'),
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: SvgPicture.asset(
                                      'images/icons/essentials/016-add.svg',
                                      width: 24,
                                      height: 24,
                                      color: Colors.indigo)),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.center,
                            child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  child: text("Add Medication",
                                      fontFamily: 'Regular'),
                                  width: width,
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.center,
                            child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  child: text("Other Reminders",
                                      fontFamily: 'Regular'),
                                  width: width,
                                )),
                          ),
                        ]))))),
        body: Column(
          children: <Widget>[
            // SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    changeStatusColor(Colors.white);
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
                        padding: EdgeInsets.only(left: 15, right: 15),
                        alignment: Alignment.center,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: text("Therapy Planner",
                                  fontFamily: 'Regular'),
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 5),
                                child: SvgPicture.asset(
                                  'images/icons/essentials/012-settings.svg',
                                  width: 24,
                                  height: 24,
                                  color: Colors.indigo,
                                )),
                            Container(
                                padding: EdgeInsets.only(top: 5),
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset(
                                    'images/icons/essentials/016-add.svg',
                                    width: 24,
                                    height: 24,
                                    color: Colors.indigo)),
                          ],
                        ))))),
        body: Column(
          children: <Widget>[
            // SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
