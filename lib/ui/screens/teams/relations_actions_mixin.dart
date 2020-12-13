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
import 'package:diabetty/services/team.service.dart';

import 'package:diabetty/models/teams/relationship.dart';

@optionalTypeArgs
mixin RelationActionsMixin<T extends Widget> {
  @protected
  Contract get contract;

  void acceptOrDeclinePopup(BuildContext context) {
    TeamManager teamManager = Provider.of<TeamManager>(context, listen: false);
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: Text("Accept"),
                  onPressed: () {
                    teamManager.acceptContract(contract);
                    Navigator.of(context).pop(context);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text("Decline"),
                  onPressed: () {
                    Navigator.of(context).pop(context);

                    areYouSurePopup(
                        context, () => teamManager.deleteContract(contract));
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

  void unSendContractPopup(BuildContext context) {
    TeamManager teamManager = Provider.of<TeamManager>(context, listen: false);
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: Text("Unsend"),
                  onPressed: () {
                    Navigator.of(context).pop(context);
                    areYouSurePopup(
                        context, () => teamManager.deleteContract(contract));
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

  void deleteContractPopup(BuildContext context) {
    TeamManager teamManager = Provider.of<TeamManager>(context, listen: false);
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: Text("Delete"),
                  onPressed: () {
                    Navigator.of(context).pop(context);

                    areYouSurePopup(
                        context, () => teamManager.deleteContract(contract));
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

  void editOrDeleteContractPopup(BuildContext context) {
    TeamManager teamManager = Provider.of<TeamManager>(context, listen: false);
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: Text("Edit Permissions"),
                  onPressed: () {
                    // teamManager.deleteContract(contract);
                    Navigator.of(context).pop(context);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text("Remove"),
                  onPressed: () {
                    Navigator.of(context).pop(context);

                    areYouSurePopup(
                        context, () => teamManager.deleteContract(contract));
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

  void stopSupportPopup(BuildContext context) {
    TeamManager teamManager = Provider.of<TeamManager>(context, listen: false);
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: Text("Stop Supporting"),
                  onPressed: () {
                    Navigator.of(context).pop(context);

                    areYouSurePopup(context, () {
                      teamManager.deleteContract(contract);
                    });
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

  void areYouSurePopup(BuildContext context, Function func) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              message: Text('Are you sure?'),
              actions: [
                CupertinoActionSheetAction(
                  child: Text("Yes"),
                  onPressed: () {
                    func.call();
                    Navigator.of(context).pop(context);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text("No"),
                  onPressed: () {
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
