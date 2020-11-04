import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
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

  Widget build(BuildContext context) {
    String pick;
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: Colors.lightBlue,
        ),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          Card(
            child: ListTile(
              title: Text("Profile Name"),
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
              ),
              trailing: Icon(Icons.edit, color: Colors.grey),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 5),
            child: Text(
              "Account Settings",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.email, color: Colors.grey),
                  title: Text("Update Email Address"),
                  trailing:
                      Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  onTap: () {
                    // Insert open password code here later
                  },
                ),
                ListTile(
                  leading: Icon(Icons.lock_open, color: Colors.grey),
                  title: Text("Change Password"),
                  trailing:
                      Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  onTap: () {
                    // Insert open password code here later
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications_active, color: Colors.grey),
                  title: Text("Manage Notification Settings"),
                  trailing:
                      Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  onTap: () {
                    navigateToAppearanceSettings(context, pick);
                    // Insert open password code here later
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.photo_size_select_actual, color: Colors.grey),
                  title: Text("Appearance Settings"),
                  trailing:
                      Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  onTap: () {
                    pick = "a";
                    navigateToAppearanceSettings(
                        context, pick); // Insert open password code here later
                  },
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            child: Text(
              "General Settings",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(children: <Widget>[
              ListTile(
                leading: Icon(Icons.feedback, color: Colors.grey),
                title: Text("Submit User Feedback"),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap: () {
                  // Insert open password code here later
                },
              ),
              ListTile(
                leading: Icon(Icons.bug_report, color: Colors.grey),
                title: Text("Report Bug"),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap: () {
                  // Insert open password code here later
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline, color: Colors.grey),
                title: Text("App Version"),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap: () {
                  // Insert open password code here later
                },
              ),
            ]),
          ),
        ])));
  }
}

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
