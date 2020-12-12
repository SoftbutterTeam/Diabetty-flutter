import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/teams/team_actions_mixins.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:diabetty/blocs/app_context.dart';

class InviteModal extends StatefulWidget {
  const InviteModal({
    Key key,
  }) : super(key: key);

  @override
  _InviteModalState createState() => _InviteModalState();
}

class _InviteModalState extends State<InviteModal> with TeamsActionsMixin {
  MaterialColor colorToFade;
  double opacity;

  @override
  void initState() {
    appContext = Provider.of<AppContext>(context, listen: false);
    super.initState();
  }

  double curve = 15;

  AppContext appContext;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.only(bottom: 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: _buildContent(context, size),
      ),
    );
  }

  Widget _buildContent(BuildContext context, size) {
    var size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 200),
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: text('Invite a friend to support support you',
                  isCentered: true),
            ),
            Container(
              alignment: Alignment.center,
              child: Icon(Icons.share),
            ),
          ],
        ));
  }
}
