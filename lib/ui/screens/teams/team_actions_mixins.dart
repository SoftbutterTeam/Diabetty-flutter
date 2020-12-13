import 'dart:ui';
import 'package:diabetty/blocs/team_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/screens/teams/invite_modal.dart';
import 'package:diabetty/ui/screens/therapy/components/IntakePopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/timerpicker.dart';
import 'package:diabetty/ui/screens/therapy/therapy_profile_screen2.dart';
import 'package:diabetty/ui/screens/today/components/reminder_info.widget.dart';
import 'package:diabetty/ui/screens/today/edit_dose.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/mixins/reminder_manager_mixin.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:diabetty/routes.dart';

import 'package:diabetty/models/teams/relationship.dart';

@optionalTypeArgs
mixin TeamsActionsMixin<T extends Widget> {
  void invitePopupModal(BuildContext context) => showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        barrierColor: Colors.black12, //black12 white
        pageBuilder: (context, anim1, anim2) => Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 2,
            child: InviteModal()),
        transitionBuilder: _transitionBuilderStyle1(),
        transitionDuration: Duration(milliseconds: 250),
      );

  _transitionBuilderStyle1() =>
      (BuildContext context, Animation<double> anim1, anim2, Widget child) {
        bool isReversed = anim1.status == AnimationStatus.reverse;
        double animValue = isReversed ? 0 : anim1.value;
        var size = MediaQuery.of(context).size;
        return SafeArea(
            child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 8 * animValue, sigmaY: 8 * animValue),
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: size.height * .1),
                    child: FadeTransition(
                      opacity: anim1,
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 10, left: 10),
                            child: GestureDetector(
                              onTapDown: (TapDownDetails tp) =>
                                  Navigator.of(context).pop(context),
                              child: Icon(
                                Icons.cancel,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          child,
                        ],
                      ),
                    ))));
      };

  void showAddTeamActions(BuildContext context) {
    TeamManager teamManager = Provider.of<TeamManager>(context, listen: false);
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: Text("Support a Friend"),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(supportFriend);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text("Invite a Friend"),
                  onPressed: () {
                    teamManager.shareSupportInviteToApp();
                    Navigator.of(context).pop(context);
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Container(color: Colors.white, child: Text('Cancel')),
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
              ),
            ));
  }
}
