import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/today/mixins/ReminderActionsMixin.dart';
import 'package:flutter/material.dart';

class TherapyProfileScreen extends StatefulWidget {
  final BuildContext context;
  final Reminder reminder;
  TherapyProfileScreen({this.context, this.reminder});

  @override
  _TherapyProfileScreenState createState() => _TherapyProfileScreenState();
}

class _TherapyProfileScreenState extends State<TherapyProfileScreen>
    with ReminderActionsMixin {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildHeader(size, context),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 80),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.only(top: 60),
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      text('widget.reminder.name',
                          textColor: Colors.black,
                          fontFamily: fontMedium,
                          fontSize: textSizeNormal),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            text('Active Reminders',
                                fontSize: textSizeLargeMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.indigo,
                  radius: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildHeader(Size size, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25),
      alignment: Alignment.topCenter,
      height: size.height * 0.15,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.orange[900], Colors.orange[600]])),
      child: Container(
        alignment: Alignment.center,
        height: size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            text("Therapy Profile",
                textColor: Colors.white,
                fontSize: textSizeNormal,
                fontFamily: fontMedium),
            IconButton(
              onPressed: () {
                print('heheh');
              },
              icon: Icon(
                Icons.more_horiz,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
