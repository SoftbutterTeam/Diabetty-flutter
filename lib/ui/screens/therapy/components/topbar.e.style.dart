import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  final String leftButtonText;
  final String rightButtonText;
  final Function onLeftTap;
  final Function onRightTap;
  final String centerText;
  final Color color;
  final bool btnEnabled;

  TopBar(
      {this.centerText,
      this.onLeftTap,
      this.leftButtonText,
      this.onRightTap,
      this.rightButtonText,
      this.color,
      this.btnEnabled});

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.orange[900], Colors.orange[600]]),
        ),
        child: Container(
          height: size.height * 0.11,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              _buildCancelButton(context),
              _buildTitle(context),
              _buildNext(context),
            ],
          ),
        ));
  }

  Widget _buildNext(BuildContext context) {
    return Text('next');
  }

  Widget _buildTitle(BuildContext context) {
    return Text('title');
  }

  Widget _buildCancelButton(BuildContext context) {
    return Text('cancel');
  }
}
