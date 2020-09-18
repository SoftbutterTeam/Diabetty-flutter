import 'package:diabetttty/theme/index.dart';
import 'package:flutter/material.dart';

class TwoPanels extends StatefulWidget {
  final AnimationController controller;

  TwoPanels({this.controller});
  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> {
  static const header_height = 200.0;

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    var height2 = MediaQuery.of(context).size.height;
    final height = constraints.biggest.height;
    final backPanelHeight = height - (height2 * 0.6);
    final frontPanelHeight = -header_height;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.linear),
    );
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Container(
      child: Stack(
        children: <Widget>[
          // BACKPANEL
          Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).primaryColor,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlineButton(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: subHeadingText('Add Medication'),
                        onPressed: () {},
                      ),
                                           OutlineButton(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: subHeadingText('Add Medication'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // FRONTPANEL
          PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    color: Theme.of(context).primaryColor,
                    height: 0.0,
                    child: Center(
                      child: headerText(''),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('Front Panel'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
