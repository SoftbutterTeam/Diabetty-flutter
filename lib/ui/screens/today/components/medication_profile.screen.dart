import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/profile_clipper.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/constants/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MedicationProfile extends StatefulWidget {
  @override
  _MedicationProfileState createState() => _MedicationProfileState();
}

class _MedicationProfileState extends State<MedicationProfile> {
  List<MedicineCardModel> medicationCard;
  String postToggle = "list";

  @override
  void initState() {
    super.initState();
    medicationCard = getFavourites();
  }

  _buildGridReminders(context, index) {
    return Column(
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
        Container(
          height: 115,
          width: 135,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 125,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(2, 2, 0, 0),
                              child: text(medicationCard[index].name,
                                  textColor: t2_colorPrimary,
                                  fontFamily: 'Regular',
                                  fontSize: textSizeMedium2,
                                  maxLine: 2),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: text(medicationCard[index].duration,
                                fontSize: 10.0, maxLine: 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 45,
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      text("1 of 2",
                          fontSize: textSizeSmall, textColor: Colors.black),
                      SizedBox(width: 15),
                      IconButton(
                        onPressed: () {
                          //print("clucked");
                        },
                        padding: EdgeInsets.all(3),
                        icon: SvgPicture.asset(
                          'assets/icons/navigation/checkbox/tick.svg',
                          width: 45,
                          color: Colors.indigoAccent[100],
                          height: 45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
                                    onTap: () {},
                                    child: Row(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          drugs4_1,
                                          width: 28,
                                          height: 28,
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                text(medicationCard[index].name,
                                                    textColor: t2_colorPrimary,
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
                                            padding: EdgeInsets.only(right: 15),
                                            alignment: Alignment.center,
                                            child: IconButton(
                                                onPressed: () {
                                                  // _onAlert(context, index);
                                                  //print("clucked");
                                                },
                                                padding: EdgeInsets.all(3),
                                                icon: SvgPicture.asset(
                                                  'assets/icons/navigation/checkbox/tick.svg',
                                                  width: 30,
                                                  color:
                                                      Colors.indigoAccent[100],
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
                                        padding: EdgeInsets.only(left: 16),
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
                                    Container(
                                      padding: EdgeInsets.only(right: 15),
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        onPressed: () {
                                          //print("clucked");
                                          // _onAlert(context, index);
                                        },
                                        padding: EdgeInsets.all(3),
                                        icon: SvgPicture.asset(
                                          'assets/icons/navigation/checkbox/filled.svg',
                                          width: 30,
                                          //* Great Color to use for it.
                                          // color: Colors
                                          //     .lightGreenAccent[700],
                                          height: 30,
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
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  setPostOrientation(String postToggle) {
    setState(() {
      this.postToggle = postToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipPath(
                  clipper: ProfileClipper(),
                  child: Image(
                    height: 300,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/icons/navigation/clock/gradientBGblue.png'),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 1),
                            blurRadius: 5),
                      ],
                    ),
                    child: ClipOval(
                      child: Image(
                        height: 120,
                        width: 120,
                        image: AssetImage(
                            'assets/icons/navigation/clock/medication.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: IconButton(
                    icon: (postToggle == 'list')
                        ? Icon(Icons.grid_on)
                        : Icon(Icons.list),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () {
                      (postToggle == 'list')
                          ? setPostOrientation('grid')
                          : setPostOrientation('list');
                      //print(postToggle);
                    },
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  text("Insulin Short-Life",
                      textColor: t2_colorPrimary,
                      fontFamily: fontBold,
                      fontSize: textSizeLargeMedium,
                      maxLine: 2),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.98,
                child: (postToggle == "list")
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: medicationCard.length,
                        itemBuilder: (context, index) {
                          return _buildReminderCards(context, index);
                        })
                    : GridView.builder(
                        itemCount: medicationCard.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 0.5,
                            crossAxisSpacing: 0.5),
                        itemBuilder: (context, index) {
                          return _buildGridReminders(context, index);
                        })),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
              height: MediaQuery.of(context).size.height * 0.11,
              width: MediaQuery.of(context).size.width * 0.98,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            //print('Skipped');
                          },
                          padding: EdgeInsets.all(3),
                          icon: SvgPicture.asset(
                            'assets/icons/navigation/clock/refresh (1).svg',
                            width: 30,
                            height: 30,
                            color: t2_colorPrimary,
                          ),
                        ),
                        text("Update Stock",
                            isCentered: true,
                            textColor: t2_colorPrimary,
                            fontFamily: fontSemibold,
                            fontSize: 15.0,
                            maxLine: 2),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            //print('Skipped');
                          },
                          padding: EdgeInsets.all(3),
                          icon: SvgPicture.asset(
                            'assets/icons/navigation/clock/plus.svg',
                            width: 30,
                            height: 30,
                            color: t2_colorPrimary,
                          ),
                        ),
                        text("Add Dosage",
                            isCentered: true,
                            textColor: t2_colorPrimary,
                            fontFamily: fontSemibold,
                            fontSize: 15.0,
                            maxLine: 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
