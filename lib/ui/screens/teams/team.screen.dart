import 'dart:math';
import 'package:diabetty/blocs/team_manager.dart';
import 'package:diabetty/ui/common_widgets/ThemeColor.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/toggle_button.dart';
import 'package:diabetty/ui/screens/teams/components/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class TeamScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TeamScreen();
  }
}

class TeamScreen extends StatefulWidget {
  final TeamManager manager;
  const TeamScreen({Key key, this.manager}) : super(key: key);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  TeamManager manager;

  @override
  void initState() {
    manager = widget.manager;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double firstSectionHeight = 0.25;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, -1),
            ),
          ],
          border: Border(top: BorderSide(color: Colors.transparent, width: 1))),
      child: Column(
        children: [
          Container(child: _buildPageIndicator(context)),
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(top: 4),
                  child: PageView(
                    children: [
                      _buildBody(context),
                      Container(color: Colors.blue)
                    ],
                  ))),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildRelationshipCard(context);
        },
      ),
    );
  }

  Widget _buildRelationshipCard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: min(70, size.height * 0.07),
              maxHeight: max(70, size.height * 0.08),
              minWidth: size.width * 0.8,
              maxWidth: size.width * 0.95),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                /* BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1, 
                  blurRadius: 4, 
                  offset: Offset(0, -1), 
                ),*/
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(12), //?was 12, also like 10, 11
              ),
              //border: Border.all(color: Colors.black54, width: 0.05),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 20),
                  child:
                      CircleAvatar(backgroundColor: Colors.white, child: null),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                    height: max(6, size.height * 0.02),
                    width: 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange[800],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/navigation/essentials/next.svg',
                          height: 15,
                          width: 15,
                          color: Colors.orange[800],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  ThemeColor lightMode = ThemeColor(
    gradient: [
      const Color(0xDDFF0080),
      const Color(0xDDFF8C00),
    ],
    backgroundColor: const Color(0xFFFFFFFF),
    textColor: const Color(0xFF000000),
    toggleButtonColor: const Color(0xFFFFFFFF),
    toggleBackgroundColor: const Color(0xFFe7e7e8),
    shadow: const [
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(0, 0),
      ),
    ],
  );

  Widget _buildPageIndicator(context) {
    return Container(
        height: 60,
        alignment: Alignment.center,
        child: AnimatedToggle(
          values: ['Light', 'Dark'],
          textColor: lightMode.textColor,
          backgroundColor: lightMode.toggleBackgroundColor,
          buttonColor: lightMode.toggleButtonColor,
          shadows: lightMode.shadow,
          onToggleCallback: (index) {
            setState(() {});
          },
        ));
  }
}

// Navigator.pushNamed(context, appsettings);
