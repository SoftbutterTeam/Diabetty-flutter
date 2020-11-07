import 'dart:wasm';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  Icon arrowRight = Icon(Icons.keyboard_arrow_right);
  Color arrowColour = Colors.grey;
  TextStyle settingsTextStyle = TextStyle(fontSize: 20);

  /*
  @override
  Future navigateToAppearanceSettings(context, pick) async {
    if (pick != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AppearanceSettingsPage()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationSettingsPage()));
    }
  }
*/

  Widget _buildListTile(BuildContext context, Icon leadingIcon,
      String cardTitle, Icon trailingIcon, String navigationString) {
    return ListTile(
      title: Text(cardTitle),
      leading: leadingIcon,
      trailing: trailingIcon,
      onTap: () {
        Navigator.pushNamed(context, navigationString);
      },
    );
  }

  Widget _buildSettingTitleContainer(
      BuildContext context, String containerTitle) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 5),
        child: Text(containerTitle, style: settingsTextStyle));
  }

  Widget _buildProfileCard(BuildContext context) {
    String forename = "Mr. Example";
    return Card(
        child: ListTile(
            title: Text(forename),
            leading: CircleAvatar(backgroundColor: arrowColour),
            trailing: Icon(Icons.edit, color: arrowColour)));
  }

  List<Widget> _buildAccountSettingsCards(BuildContext context) {
    String pick;
    double elevation = 4.0;
    List<String> Titles = [
      "Account Settings",
      "Update Email Address",
      "Change Password",
      "Manage Notification Settings",
      "Appearance Settings"
    ];

    return [
      _buildSettingTitleContainer(context, Titles[0]),
      Card(
        elevation: elevation,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: <Widget>[
            _buildListTile(
                context, Icon(Icons.email), Titles[1], arrowRight, null),
            _buildListTile(
                context, Icon(Icons.lock_open), Titles[2], arrowRight, null),
            _buildListTile(context, Icon(Icons.notifications_active), Titles[3],
                arrowRight, pick),
            _buildListTile(context, Icon(Icons.photo_size_select_actual),
                Titles[4], arrowRight, pick)
            /*trailing: Icon(arrowRight, color: Colors.grey),
            onTap: () {
              pick = "a";
              navigateToAppearanceSettings(
                  context, pick); // Insert open password code here later */
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildGeneralSettingsCards(BuildContext context) {
    List GeneralSettingsNames = [
      "General Settings",
      "Submit User Feedback",
      "Report a Bug",
      "App Version"
    ];

    return [
      _buildSettingTitleContainer(context, GeneralSettingsNames[0]),
      Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: <Widget>[
            _buildListTile(context, Icon(Icons.feedback),
                GeneralSettingsNames[1], arrowRight, null),
            _buildListTile(context, Icon(Icons.bug_report),
                GeneralSettingsNames[2], arrowRight, null),
            _buildListTile(context, Icon(Icons.info_outline),
                GeneralSettingsNames[3], arrowRight, null)
          ],
        ),
      ),
    ];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildProfileCard(context),
          ]
            ..addAll(_buildAccountSettingsCards(context))
            ..addAll(_buildGeneralSettingsCards(context)),
        ),
      ),
    );
  }
}

/*
class AppearanceSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance Settings'),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    NewWidget(),
                    ListTile(
                      leading: Icon(Icons.font_download, color: Colors.grey),
                      title: Text("Font Size"),
                      trailing: Icon(Icons.arrow_drop_down, color: Colors.grey),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.remove_red_eye, color: Colors.grey),
                      title: Text("Colourblind Mode?"),
                      trailing:
                          Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                      onTap: () {
                        // Insert open password code here later
                      },
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

// Condense ListTile code into it's own widget
class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.image, color: Colors.grey),
      title: Text("App Theme"),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.grey),
      onTap: () {},
    );
  }
}

class NotificationSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          const SizedBox(height: 10.0),
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading:
                      Icon(Icons.notification_important, color: Colors.grey),
                  title: Text("Notification Alert Level / Consistency"),
                  trailing: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onTap: () {
                    // Insert open password code here later
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications_active, color: Colors.grey),
                  title: Text("Push Notification Priority?"),
                  trailing: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onTap: () {
                    // Insert open password code here later
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications_off, color: Colors.grey),
                  title: Text("Mute Notification Period?"),
                  trailing: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onTap: () {
                    // Insert open password code here later
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
*/
