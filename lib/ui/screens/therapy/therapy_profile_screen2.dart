import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_background.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TherapyProfileScreen2 extends StatefulWidget {
  final Therapy therapy;
  final TherapyManager manager;
  final BuildContext context;
  TherapyProfileScreen2({this.context, this.therapy, this.manager});

  @override
  _TherapyProfileScreen2State createState() => _TherapyProfileScreen2State();
}

class _TherapyProfileScreen2State extends State<TherapyProfileScreen2> {
  final Color textColor = Colors.orange[800];

  @override
  Widget build(BuildContext context) {
    return TherapyProfileBackground(
        header: TherapyProfileHeader(),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical, child: _body(context)));
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        _buildHeader(size),
        SizedBox(height: size.height * 0.6),
        Container(
          padding: EdgeInsets.only(top: 10),
          height: size.height * 0.2,
          width: size.width,
          decoration: BoxDecoration(
              color: appWhite,
              border: Border(
                top: BorderSide(
                  color: textColor,
                  width: 1.0,
                ),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.08,
                width: size.width * 0.16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: textColor,
                ),
              ),
              Container(
                height: size.height * 0.08,
                width: size.width * 0.16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: textColor,
                ),
              ),
              Container(
                height: size.height * 0.08,
                width: size.width * 0.16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildHeader(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.15,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: appWhite,
          border: Border(
            bottom: BorderSide(
              color: textColor,
              width: 1.0,
            ),
          )),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 50),
            child: Row(
              children: [
                Container(
                  height: size.height * 0.05,
                  width: size.width * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    appearance_iconss[
                        widget.therapy.medicationInfo.appearanceIndex],
                    width: 10,
                    height: 10,
                  ),
                ),
                SizedBox(width: size.width * 0.05),
                Text(widget.therapy.name,
                    style: TextStyle(
                        fontSize: 22.0,
                        color: textColor,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'last taken',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "3 hours ago",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "next",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "in 6 hours",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
