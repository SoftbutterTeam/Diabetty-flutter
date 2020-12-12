import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/teams/team_actions_mixins.dart';
import 'package:flutter/material.dart';

class TeamHeader extends StatefulWidget {
  const TeamHeader({Key key}) : super(key: key);

  @override
  _TeamHeaderState createState() => _TeamHeaderState();
}

class _TeamHeaderState extends State<TeamHeader> with TeamsActionsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    onPressed: null,
                    color: Colors.transparent,
                    disabledTextColor: Colors.grey,
                    disabledColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    child: Align(
                      child: Icon(Icons.add, color: Colors.transparent),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: subHeadingText("Team", Colors.white),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      showAddTeamActions(context);
                    },
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
              ],
            ),
          ],
        ));
  }
}
