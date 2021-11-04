import 'dart:ui';

import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/customtextfield.dart';
import 'package:diabetty/extensions/index.dart';

class SettingsScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen();
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        if (false) SizedBox() else _body(context),
        SafeArea(
          child: IntrinsicHeight(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    child: SubPageHeader(
                      saveFunction: null,
                      iconColor: Colors.white,
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
            height: size.height * 0.2,
            child: Stack(children: [
              Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [Colors.orange[900], Colors.orange[800]],
                  ),
                ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.profile_circled,
                      size: 40,
                      color: Colors.white,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: text(('').capitalize(),
                          fontSize: 14.0, textColor: Colors.white),
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
              child: SafeArea(
                child: Stack(
                  children: [
                    _buildSections1(context),
                    Column(
                      children: [
                        _buildSections2(context),
                        _buildSections3(context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]);
  }

  Widget _buildSections1(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildMessageField(context),
          text('Diabetty v.1.5.1', fontSize: 10.0, textColor: Colors.black54),
        ],
      ),
    );
  }

  Widget _buildSections2(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          //   _buildDarkModeField(context),
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
          _buildShareAppField(context),
          _buildFeedbackField(context),
          _buildHelpSupportField(context),
        ],
      ),
    );
  }

  Widget _buildMessageField(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: text(
          '❤️ Thanks for being apart of Diabetty ❤️',
          fontSize: 13.5,
          textColor: Colors.black87,
          isCentered: true,
        ));
  }

  Widget _buildDarkModeField(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
                color: Colors.grey[200], width: 1.2, style: BorderStyle.solid),
          ),
        ),
        child: text(
          'Notification Settings',
          fontSize: 14.0,
          textColor: Colors.grey[700],
          isCentered: true,
        ));
  }

  Widget _buildLangaugeField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Notification Settings',
    );
  }

  Widget _buildSettingsField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Clear Memory',
    );
  }

  Widget _buildHelpSupportField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Contact us',
    );
  }

  Widget _buildShareAppField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Share App',
    );
  }

  Widget _buildFeedbackField(BuildContext context) {
    return CustomTextField(
      onTap: () {},
      placeholderText: 'Feedback',
    );
  }
}
