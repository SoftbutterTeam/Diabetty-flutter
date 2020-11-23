import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_background.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_header.dart';
import 'package:flutter/material.dart';

class SnoozeOptionScreen extends StatefulWidget {
  @override
  _SnoozeOptionScreenState createState() => _SnoozeOptionScreenState();
}

class _SnoozeOptionScreenState extends State<SnoozeOptionScreen> {
  bool tenMin = false;
  bool fifteenMin = false;

  @override
  Widget build(BuildContext context) {
    return TherapyProfileBackground(
        header: TherapyProfileHeader(), child: _body(context));
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        _buildHeader(size),
        Expanded(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: _buildBody(size),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(Size size) {
    return Column(
      children: [
        Text('hi'),
      ],
    );
  }

  Container _buildHeader(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.20,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: appWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 0.5),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(1),
              spreadRadius: 3,
              blurRadius: 0,
              offset: Offset(0, -1),
            ),
          ],
          border: Border(
            bottom: BorderSide(
              color: Colors.transparent, // Color.fromRGBO(200, 100, 100, 0.4),
              width: 0.7,
            ),
          )),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    tenMin = true;
                    fifteenMin = false;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 50),
                  height: size.height * 0.03,
                  width: size.width * 0.06,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (tenMin) ? Colors.white : Colors.orange[800],
                      border: Border.all(
                        color: Colors.orange[800],
                        width: 5,
                      )),
                ),
              ),
              SizedBox(width: size.width * 0.04),
              Text('10 minutes')
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    tenMin = false;
                    fifteenMin = true;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 50),
                  height: size.height * 0.03,
                  width: size.width * 0.06,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (fifteenMin) ? Colors.white : Colors.orange[800],
                      border: Border.all(
                        color: Colors.orange[800],
                        width: 5,
                      )),
                ),
              ),
              SizedBox(width: size.width * 0.04),
              Text('15 minutes')
            ],
          ),
        ],
      ),
    );
  }
}
