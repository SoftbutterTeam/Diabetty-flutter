import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/theraphy/add.medication.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../routes.dart';

class AddModal2 extends StatelessWidget {
  const AddModal2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,

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
                      onPressed: null,
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
                      onPressed: null,
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
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.18,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: appWhite,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      final TherapyManager therapyManager =
                          Provider.of<TherapyManager>(context, listen: false);
                      therapyManager.resetForm();

                      Navigator.pushReplacementNamed(context, addmedication);
                    },
                    child: Text(
                      "Medication",
                      style: TextStyle(
                          color: Colors.green[850],
                          fontSize: 20,
                          fontFamily: "Regular"),
                    ),
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
