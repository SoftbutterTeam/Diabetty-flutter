import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Background extends StatelessWidget {
  final Widget header;
  final Widget child;

  const Background({
    Key key,
    @required this.child,
    this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.orange[900], Colors.orange[600]])),
      height: size.height,
      // Here i can use size.width but use double.infinity because both work as a same
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
                child: header ?? TherapyHeader(),
                preferredSize: Size.fromHeight(50)),
            body: Container(
              decoration: BoxDecoration(
                color: appWhite, //Colors.grey[50], appWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0), //was 20
                    topRight: Radius.circular(0)), // was 20
              ),
              child: child,
            )),
      ),
    );
  }
}

// Container(
//                   child: FlatButton(
//                     onPressed: onPressed,
//                     color: Colors.transparent,
//                     disabledTextColor: Colors.grey,
//                     disabledColor: Colors.transparent,
//                     padding: EdgeInsets.zero,
//                     child: Align(
//                       child: Icon(Icons.add, color: Colors.white),
//                       alignment: Alignment.centerRight,
//                     ),
//                   ),
//                 ),

//  Container(
//                   child: FlatButton(
//                     onPressed: onPressed2,
//                     padding: EdgeInsets.zero,
//                     child: Align(
//                       child: CircleAvatar(
//                         backgroundColor: Colors.indigo,
//                         radius: 20.0,
//                       ),
//                       alignment: Alignment.centerLeft,
//                     ),
//                   ),
//                 ),
