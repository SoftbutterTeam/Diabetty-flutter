import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddModal extends StatelessWidget {
  const AddModal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,

      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(50),
          color: appWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange[900],
            Colors.orange[200],
            Colors.orange[600]
          ])),
      height: size.height * 0.29,

      // Here i can use size.width but use double.infinity because both work as a same
      child: Column(
        children: [
          Container(
            height: size.height * 0.11,
            child: Stack(
              children: [
                Positioned(
                  top: 35,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: FlatButton(
                      onPressed: () {},
                      color: Colors.transparent,
                      disabledTextColor: Colors.grey,
                      disabledColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      child: Align(
                        child: Icon(Icons.add, color: Colors.white),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 35,
                  left: 5,
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      child: Align(
                        child: SvgPicture.asset(
                          'assets/icons/navigation/essentials/012-settings.svg',
                          height: 22,
                          width: 22,
                          color: Colors.white,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 30),
                      child: subHeadingText("Add to Plan", Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.18,
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Medication",
                    style: TextStyle(
                        color: Colors.green[850],
                        fontSize: 20,
                        fontFamily: "Regular"),
                  ),
                  subHeadingText("Other Type", Colors.grey[850]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
