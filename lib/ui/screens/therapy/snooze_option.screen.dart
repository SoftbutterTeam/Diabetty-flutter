import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_background.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SnoozeOptionScreen extends StatefulWidget {
  @override
  _SnoozeOptionScreenState createState() => _SnoozeOptionScreenState();
}

class _SnoozeOptionScreenState extends State<SnoozeOptionScreen> {
  bool toggle = false;
  int selectedRepeatRadioTile;
  int selectedMinuteRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRepeatRadioTile = 0;
    selectedMinuteRadioTile = 0;
  }

  @override
  Widget build(BuildContext context) {
    return TherapyProfileBackground(
        header: TherapyProfileHeader(), child: _body(context));
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        // _buildHeader(size),
        Expanded(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: _buildBody(size),
          ),
        ),
      ],
    );
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRepeatRadioTile = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedMinuteRadioTile = val;
    });
  }

  Widget _buildBody(Size size) {
    return Column(
      children: [
        _buildToggle(size),
        SizedBox(height: size.height * 0.04),
        HeadingText(size: size, title: "interval"),
        IgnorePointer(
            ignoring: (toggle) ? false : true,
            child: _buildMinuteContainer(size)),
        SizedBox(height: size.height * 0.04),
        HeadingText(size: size, title: "repeat"),
        IgnorePointer(
          ignoring: (toggle) ? false : true,
          child: _buildRepeatContainer(size),
        ),
      ],
    );
  }

  BoxDecoration decoration = BoxDecoration(
      color: Colors.grey[50],
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 0.5),
        ),
        BoxShadow(
          color: Colors.white.withOpacity(1),
          spreadRadius: 3,
          blurRadius: 0,
          offset: Offset(0, -1),
        ),
      ],
      border: Border.all(
        color: Colors.black26,
        width: 0.2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)));

  Container _buildToggle(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: size.width,
      height: size.height * 0.07,
      decoration: decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              (toggle) ? "on" : "off",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: CupertinoSwitch(
              activeColor: Colors.orange[800],
              value: toggle,
              onChanged: (value) => {toggle = value, setState(() {})},
            ),
          ),
        ],
      ),
    );
  }

  Container _buildRepeatContainer(Size size) {
    return Container(
        //TODO insert constraint box
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.symmetric(vertical: 10),
        width: size.width,
        height: size.height * 0.22,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 0.5),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(1),
                spreadRadius: 3,
                blurRadius: 0,
                offset: Offset(0, -1),
              ),
            ],
            border: Border.all(
              color: Colors.black26,
              width: 0.2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RadioListTile(
              activeColor: Colors.orange[800],
              title: Text("3 times"),
              value: 3,
              groupValue: selectedRepeatRadioTile,
              onChanged: (value) => {
                setSelectedRadio(value),
                print(value),
              },
              selected: (selectedRepeatRadioTile == 3) ? true : false,
            ),
            _divider(size),
            RadioListTile(
              activeColor: Colors.orange[800],
              title: Text("5 times"),
              value: 5,
              groupValue: selectedRepeatRadioTile,
              onChanged: (value) => {
                setSelectedRadio(value),
                print(value),
              },
              selected: (selectedRepeatRadioTile == 5) ? true : false,
            ),
            _divider(size),
            RadioListTile(
              activeColor: Colors.orange[800],
              title: Text("Forever"),
              value: 100,
              groupValue: selectedRepeatRadioTile,
              onChanged: (value) => {
                setSelectedRadio(value),
                print(value),
              },
              selected: (selectedRepeatRadioTile == 100) ? true : false,
            ),
          ],
        ));
  }

  Container _buildMinuteContainer(Size size) {
    return Container(
        //TODO insert constraint box
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.symmetric(vertical: 10),
        width: size.width,
        height: size.height * 0.30,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 0.5),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(1),
                spreadRadius: 3,
                blurRadius: 0,
                offset: Offset(0, -1),
              ),
            ],
            border: Border.all(
              color: Colors.black26,
              width: 0.2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RadioListTile(
              activeColor: Colors.orange[800],
              title: Text("5 minutes"),
              value: 5,
              groupValue: selectedMinuteRadioTile,
              onChanged: (value) => {
                setSelectedRadioTile(value),
                print(value),
              },
              selected: (selectedMinuteRadioTile == 5) ? true : false,
            ),
            _divider(size),
            RadioListTile(
              activeColor: Colors.orange[800],
              title: Text("10 minutes"),
              value: 10,
              groupValue: selectedMinuteRadioTile,
              onChanged: (value) => {
                setSelectedRadioTile(value),
                print(value),
              },
              selected: (selectedMinuteRadioTile == 10) ? true : false,
            ),
            _divider(size),
            RadioListTile(
              activeColor: Colors.orange[800],
              title: Text("15 minutes"),
              value: 15,
              groupValue: selectedMinuteRadioTile,
              onChanged: (value) => {
                setSelectedRadioTile(value),
                print(value),
              },
              selected: (selectedMinuteRadioTile == 15) ? true : false,
            ),
            _divider(size),
            RadioListTile(
              activeColor: Colors.orange[800],
              title: Text("30 minutes"),
              value: 30,
              groupValue: selectedMinuteRadioTile,
              onChanged: (value) => {
                setSelectedRadioTile(value),
                print(value),
              },
              selected: (selectedMinuteRadioTile == 30) ? true : false,
            ),
          ],
        ));
  }

  Container _divider(Size size) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 1,
      width: size.width * 0.7,
      color: Colors.black26,
    );
  }
}

class HeadingText extends StatelessWidget {
  String title;
  Size size;

  HeadingText({
    this.title,
    this.size,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: size.width * 0.1),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
