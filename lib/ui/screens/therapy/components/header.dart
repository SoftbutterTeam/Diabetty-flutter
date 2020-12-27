import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/blocs/app_context.dart';
import 'package:diabetty/ui/screens/today/components/drop_modal.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/extensions/index.dart';

class TherapyHeader extends StatefulWidget {
  const TherapyHeader({Key key}) : super(key: key);

  @override
  _TherapyHeaderState createState() => _TherapyHeaderState();
}

class _TherapyHeaderState extends State<TherapyHeader> with DateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppContext appContext = Provider.of<AppContext>(context, listen: false);
    bool readOnly = appContext.readOnly;

    String name = (((appContext.user.displayName == null ||
                appContext.user.displayName.isEmpty
            ? appContext.user.name
            : appContext.user.displayName) ??
        ''));
    name = name.isEmpty ? "friend" : name;
    name += "'s";

    name = name
        .substring(0, name.length > 10 ? 10 : name.length)
        .capitalizeBegins();

    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (appContext.authService == null)
                  _buildBackButton(context)
                else
                  _buildSettingsButton(context),
                GestureDetector(
                  onTap: () => null,
                  child: Container(
                    alignment: Alignment.center,
                    child: subHeadingText(
                        (appContext.authService == null ? name + ' ' : '') +
                            "Therapy",
                        Colors.white),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: (appContext.authService != null)
                        ? () {
                            final TherapyManager therapyManager =
                                Provider.of<TherapyManager>(context,
                                    listen: false);
                            therapyManager.resetForm();
                            Navigator.pushNamed(context, addmedication);
                          }
                        : null,
                    color: Colors.transparent,
                    disabledTextColor: Colors.grey,
                    disabledColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    child: Opacity(
                      opacity: appContext.authService != null ? 1 : 0,
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildSettingsButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: FlatButton(
        onPressed: () => Navigator.pushNamed(context, appsettings),
        color: Colors.transparent,
        disabledTextColor: Colors.grey,
        disabledColor: Colors.transparent,
        padding: EdgeInsets.zero,
        child: Align(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 3),
            child: Icon(
              CupertinoIcons.profile_circled,
              size: 30,
              color: Colors.white,
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerLeft,
      child: FlatButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pushReplacementNamed(context, team);
        },
        color: Colors.transparent,
        disabledTextColor: Colors.grey,
        disabledColor: Colors.transparent,
        padding: EdgeInsets.only(left: 0),
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios, color: Colors.white, size: 17),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(
                  CupertinoIcons.profile_circled,
                  size: 30,
                  color: Colors.white,
                ),
              )
            ],
          ),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }

  CupertinoActionSheet addTherapyActionSheet(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: text("Medication", fontSize: 18.0, textColor: Colors.indigo),
          onPressed: () {
            final TherapyManager therapyManager =
                Provider.of<TherapyManager>(context, listen: false);
            therapyManager.resetForm();
            Navigator.pushReplacementNamed(context, addmedication);
          },
        ),
        CupertinoActionSheetAction(
          child: text("Other Types", fontSize: 18.0, textColor: Colors.indigo),
          onPressed: () {},
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Container(color: Colors.white, child: Text('Cancel')),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
