import 'dart:ui';

import 'package:diabetty/blocs/app_context.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/animated_scale_button.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/cupertino_text_field.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_background.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/customtextfield.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/extensions/index.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  AppContext appContext;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    appContext = Provider.of<AppContext>(context, listen: true);
    if (appContext.user == null) {
      return SizedBox();
    }
    return Scaffold(
      body: Stack(children: [
        _body(context),
        SafeArea(
          child: IntrinsicHeight(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    child: SubPageHeader(
                      saveFunction: null,
                      color: Colors.white,
                      backFunction: () => Navigator.pop(context),
                    ),
                  ))),
        ),
      ]),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            width: size.width,
            height: size.height * 0.28,
            child: Stack(children: [
              Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [Colors.orange[900], Colors.orange[800]])),
                child: null,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: null),
              ),
              Container(
                padding: EdgeInsets.only(top: size.height * 0.05),
                height: double.maxFinite,
                width: double.maxFinite,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.profile_circled,
                      size: 70,
                      color: Colors.white,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: text(
                          (appContext.user.displayName.isEmpty
                                  ? appContext.user.name
                                  : appContext.user.displayName)
                              .capitalize(),
                          fontSize: 14.0,
                          textColor: Colors.white),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      child: text('edit profile', fontSize: 12.0),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                boxShadow: [],
                border: Border(
                    top: BorderSide(color: Colors.transparent, width: 1)),
              ),
              child: Column(
                children: [
                  _buildSections2(context),
                  _buildSections3(context),
                  _buildSections1(context),
                ],
              ),
            ),
          ),
        ]);
  }

  Widget _buildSections1(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          _buildSignOutField(context),
        ],
      ),
    );
  }

  Widget _buildSections2(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          _buildDarkModeField(context),
          _buildLangaugeField(context),
          _buildSettingsField(context),
        ],
      ),
    );
  }

  Widget _buildSections3(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          _buildHelpSupportField(context),
          _buildShareAppField(context),
          _buildFeedbackField(context),
          _buildAboutUsField(context),
        ],
      ),
    );
  }

  Widget _buildSignOutField(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await Provider.of<AuthService>(context, listen: false).signOut();
          Navigator.pop(context);
        },
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    color: Colors.grey[200],
                    width: 1.2,
                    style: BorderStyle.solid),
              ),
            ),
            child: text('Sign Out',
                fontSize: 15.0,
                isCentered: true,
                textColor: CupertinoColors.destructiveRed)));
  }

  Widget _buildDarkModeField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Dark Mode',
    );
  }

  Widget _buildLangaugeField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Langauge Settings',
    );
  }

  Widget _buildSettingsField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Settings',
    );
  }

  Widget _buildHelpSupportField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Help and Support',
    );
  }

  Widget _buildShareAppField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Share App',
    );
  }

  Widget _buildAboutUsField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Abous Us',
    );
  }

  Widget _buildFeedbackField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Feedback',
    );
  }
}
