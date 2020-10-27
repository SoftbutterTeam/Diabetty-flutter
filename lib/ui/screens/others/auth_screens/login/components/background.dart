import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Colors.orange[900],
        Colors.orange[200],
        Colors.orange[600]
      ])),
      height: size.height,

      // Here i can use size.width but use double.infinity because both work as a same
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.11,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: child,
            )),
          ],
        ),
      ),
    );
  }
}
