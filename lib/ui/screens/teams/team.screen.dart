import 'dart:math';
import 'package:diabetty/blocs/team_manager.dart';
import 'package:diabetty/blocs/app_context.dart';
import 'package:diabetty/services/team.service.dart';

import 'package:diabetty/ui/common_widgets/ThemeColor.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/toggle_button.dart';
import 'package:diabetty/ui/screens/teams/components/background.dart';
import 'package:diabetty/ui/screens/teams/relations_actions_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/models/teams/relationship.dart';

class TeamScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TeamManager>(
        builder: (_, TeamManager manager, __) => TeamScreen(
              manager: manager,
            ));
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
  bool initialValue = true;
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
    return Container(
      padding: EdgeInsets.only(top: 20),
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
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 4),
            child: _buildBody(context),
          )),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.transparent,
        child: ListView.builder(
          itemCount: manager.usersContracts.length,
          itemBuilder: (context, index) {
            return RelationCard(contract: manager.usersContracts[index]);
          },
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
}

class RelationCard extends StatelessWidget with RelationActionsMixin {
  const RelationCard({
    Key key,
    this.contract,
  }) : super(key: key);

  final Contract contract;

  @override
  Widget build(BuildContext context) {
    AppContext appcontext = Provider.of<AppContext>(context, listen: false);
    if (contract.supporteeId == appcontext.user.uid) {
      if (contract.acceptedAt == null)
        return _buildRequestCard(context);
      else
        return _buildSupporterCard(context);
    } else {
      if (contract.acceptedAt == null)
        return _buildPendingCard(context);
      else
        return _buildSupporteeCard(context);
    }
  }

  Widget _buildPendingCard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return RelationDecor(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 20),
            child: CircleAvatar(backgroundColor: Colors.white, child: null),
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
            children: [
              text(
                  (contract.supportee.displayName.isEmpty
                          ? contract.supportee.name
                          : contract.supportee.displayName)
                      .toLowerCase(),
                  fontSize: 15.0),
              text('pending response...', fontSize: 13.0)
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => unSendContractPopup(context),
                    child: SizedBox(
                        child: Container(
                            padding: EdgeInsets.all(2),
                            color: Colors.transparent,
                            child: Icon(Icons.more_horiz,
                                size: 25, color: Colors.black87))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupporteeCard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => navigateToSupporteeDashboard(context),
      child: RelationDecor(
          child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 20),
            child: CircleAvatar(backgroundColor: Colors.white, child: null),
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
            children: [
              text(
                  (contract.supportee.displayName.isEmpty
                          ? contract.supportee.name
                          : contract.supportee.displayName)
                      .toLowerCase(),
                  fontSize: 15.0),
              text('supportee', fontSize: 13.0),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => stopSupportPopup(context),
                    child: SizedBox(
                        child: Container(
                            padding: EdgeInsets.all(2),
                            color: Colors.transparent,
                            child: Icon(Icons.more_horiz,
                                size: 25, color: Colors.black87))),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildSupporterCard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return RelationDecor(
        child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 20),
          child: CircleAvatar(backgroundColor: Colors.white, child: null),
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
          children: [
            text(
                (contract.supporter.displayName.isEmpty
                        ? contract.supporter.name
                        : contract.supporter.displayName)
                    .toLowerCase(),
                fontSize: 15.0),
            text('supporter', fontSize: 13.0)
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => editOrDeleteContractPopup(context),
                  child: SizedBox(
                      child: Container(
                          padding: EdgeInsets.all(2),
                          color: Colors.transparent,
                          child: Icon(Icons.more_horiz,
                              size: 25, color: Colors.black87))),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildRequestCard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () => acceptOrDeclinePopup(context),
        child: RelationDecor(
            child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, right: 20),
              child: CircleAvatar(backgroundColor: Colors.white, child: null),
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
              children: [
                text(
                    (contract.supporter.displayName.isEmpty
                            ? contract.supporter.name
                            : contract.supporter.displayName)
                        .toLowerCase(),
                    fontSize: 15.0),
                text('new invitation, accept?', fontSize: 13.0)
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: Container(
                          padding: EdgeInsets.all(2),
                          color: Colors.transparent,
                          child: null),
                    )
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}

class RelationDecor extends StatelessWidget {
  const RelationDecor({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        color: Colors.transparent,
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
              child: child),
        ));
  }
}

// Navigator.pushNamed(context, appsettings);
