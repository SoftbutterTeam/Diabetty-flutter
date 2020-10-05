import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicationCard extends StatefulWidget {
  final String name;

  final Widget appearance;

  MedicationCard({
    this.name,
    this.appearance,
  });

  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.1,
      width: width * 0.9,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: width * 0.2,
              height: height * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // widget.appearance
                  Container(
                    height: height * 0.0625,
                    width: width * 0.125,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange.withOpacity(0.2),
                      // color: CupertinoColors.activeBlue,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Row(
                      children: <Widget>[
                        text(widget.name,
                            textColor: Colors.black,
                            fontFamily: fontMedium,
                            fontSize: 18.0),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 4, left: 2),
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         width: 50,
                  //         height: 3,
                  //         decoration: BoxDecoration(
                  //           color: Colors.orange,
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Stack(
              children: [
                Positioned(
                  top: 15,
                  left: 1,
                  child: Container(
                    width: width * 0.012,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [Colors.orange[900], Colors.orange[600]])),
                  ),
                ),
                Container(
                  height: height,
                  color: Colors.orange.withOpacity(0.1),
                  width: width * 0.234,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(Icons.info, color: Colors.black),
                          ),
                          Icon(Icons.close, color: Colors.black)
                        ],
                      ),
                    ],
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
