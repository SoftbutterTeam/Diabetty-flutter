import 'package:diabetttty/theme/T2Colors.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:diabetttty/themee/icons.dart';
import 'package:diabetttty/utils/DataGenerator.dart';
import 'package:diabetttty/utils/model/Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'AddScheduleScreen.dart';

class TherapyScreen2 extends StatefulWidget {
  @override
  _TherapyScreen2State createState() => _TherapyScreen2State();
}

class _TherapyScreen2State extends State<TherapyScreen2> {
  List<MedicineCardModel> medicationCard;
  var titleName = "Therapy Planner";
  var subtitleName = "";
  double containerHeight = 70.0;

  @override
  void initState() {
    super.initState();
    medicationCard = getFavourites();
  }

  _buildTherapyCards(context, index) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        height: height * 0.115,
        width: width * 0.8,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5, right: 5),
                // color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: index == 0 ||
                                index == 1 ||
                                index == 2 ||
                                index == 3 ||
                                index == 4
                            ? t2_red
                            : t2_colorPrimary,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(16.0),
                            topRight: const Radius.circular(16.0)),
                      ),
                      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            index == 0 ||
                                    index == 1 ||
                                    index == 2 ||
                                    index == 3 ||
                                    index == 4
                                ? 'images/icons/clock/hospital.svg'
                                : 'images/icons/clock/life.svg',
                            width: 15,
                            height: 15,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          text(
                              index == 0 ||
                                      index == 1 ||
                                      index == 2 ||
                                      index == 3 ||
                                      index == 4
                                  ? "Medication"
                                  : "Blood Checks",
                              textColor: t2_white,
                              fontSize: textSizeSmall),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.green,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              height: height * 0.08,
                              width: width * 0.7,
                              // color: Colors.black54,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  ClipOval(
                                    child: Image(
                                      height: 30,
                                      width: 30,
                                      image: AssetImage(
                                          'images/icons/clock/medication.jpeg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 16, top: 5),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          text(medicationCard[index].name,
                                              textColor: t2_colorPrimary,
                                              fontFamily: 'Regular',
                                              fontSize: textSizeMedium2,
                                              maxLine: 2),
                                          text(medicationCard[index].duration,
                                              fontSize: textSizeSmall),
                                          text("1 of 2",
                                              fontSize: textSizeSmall2),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            Container(
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildExpandedTherapyScreen(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black12,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (ctx, anim1, anim2) => Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: height / 1.4),
          height: height,
          width: width,
          alignment: Alignment.topCenter,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                height: height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[t3_colorPrimary, t3_colorPrimaryDark]),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                ),
              ),
              Positioned(
                top: 38,
                right: 0,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                child: Center(
                  child: Container(
                    height: height * 0.2,
                    // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddScheduleScreen()));
                          },
                          child: subHeadingText("Add Reminder"),
                        ),
                        FlatButton(
                          onPressed: () {
                            print('hihihi');
                          },
                          child: subHeadingText("Add Reminder"),
                        ),
                        FlatButton(
                          onPressed: () {
                            print('hihihi');
                          },
                          child: subHeadingText("Add Reminder"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    return Scaffold(
      body: Container(
        color: t3_app_background,
        child: Stack(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height) / 3.5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[t3_colorPrimary, t3_colorPrimaryDark]),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0)),
              ),
            ),
            Column(
              children: <Widget>[
                TopBar(
                  titleName: titleName,
                  subtitleName: subtitleName,
                  containerHeight: containerHeight,
                  onCustomButtonPressed: () {
                    // setState(() {
                    //   titleName = "Add Reminder";
                    //   subtitleName = "Other Reminder";
                    //   containerHeight = 130.0;
                    // });
                    _buildExpandedTherapyScreen(context);
                  },
                ),
                SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: medicationCard.length,
                    itemBuilder: (context, index) {
                      return _buildTherapyCards(context, index);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// Card(
//           semanticContainer: true,
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           child: Row(
//             children: <Widget>[
//               Image.asset(
//                   index == 0 || index == 1
//                       ? 'images/icons/clock/medication.jpeg'
//                       : 'images/icons/clock/gradientBGblue.png',
//                   width: width / 3,
//                   height: width / 3,
//                   fit: BoxFit.cover),
//               Container(
//                 height: width / 3.5,
//                 width: width - (width / 3) - 35,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Container(
//                           decoration: BoxDecoration(
//                             color: index == 0 || index == 1  ? t2_red : t2_colorPrimary,
//                             borderRadius: new BorderRadius.only(
//                                 bottomRight: const Radius.circular(16.0),
//                                 topRight: const Radius.circular(16.0)),
//                           ),
//                           padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
//                           child: Row(
//                             children: <Widget>[
//                               SvgPicture.asset(
//                                 index == 0 || index == 1
//                                     ? 'images/icons/clock/hospital.svg'
//                                     : 'images/icons/clock/life.svg',
//                                 width: 15,
//                                 height: 15,
//                                 color: Colors.white,
//                               ),
//                               SizedBox(width: 5),
//                               text(
//                                   index == 0 || index == 1
//                                       ? "Medication"
//                                       : "Blood Checks",
//                                   textColor: t2_white,
//                                   fontSize: textSizeSmall),
//                             ],
//                           ),
//                         ),
//                         GestureDetector(
//                             onTap: () {}, child: Icon(Icons.more_vert))
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           text(medicationCard[index].name,
//                               textColor: t2TextColorPrimary,
//                               fontSize: textSizeNormal,
//                               fontFamily: fontMedium),
//                           SizedBox(height: 4),
//                           text(medicationCard[index].duration,
//                               fontSize: textSizeMedium),
//                           SizedBox(height: 4),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//           elevation: 0,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           margin: EdgeInsets.all(0),
//         ),
