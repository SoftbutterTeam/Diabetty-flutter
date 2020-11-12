import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/diary/add_journal/add_journal_background.dart';
import 'package:diabetty/ui/screens/diary/add_journal/header.dart';
import 'package:diabetty/ui/screens/diary/components/journal_card.dart';
import 'package:diabetty/ui/screens/therapy/components/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddJournalScreen extends StatefulWidget {
  @override
  _AddJournalScreenState createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return AddJournalBackground(
        header: AddJournalHeader(),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical, child: _body(context)),
        ));
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: size.width * 0.9,
          margin: EdgeInsets.only(top: 5, left: 5, right: 5),
          height: size.height * 0.25,
          alignment: Alignment.center,
          child: IntrinsicHeight(child: JournalCard()),
        ),
        _buildMe
        
        Container(
          width: size.width,
          margin: EdgeInsets.only(top: 5, left: 5, right: 5),
          child: SizedBox(
            child: FlatButton(
              onPressed: () {},
              child: null,
            ),
          ),
        ),
      ],
    );
  }

  InputTextField _buildJournalNameField() {
    return InputTextField(
      stackIcons: _stackedHeartIcons(therapyForm.isNameValid()),
      controller: new TextEditingController(),
      placeholder: "Journal's Name...",
      initalName: therapyForm.name,
      onChanged: (val) {
        therapyForm.name = val;
        setState(() {});
      },
    );
  }

  Stack _stackedHeartIcons(bool cond) {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: cond ? 0 : 1,
          duration: Duration(milliseconds: 1000),
          child: Icon(
            CupertinoIcons.heart,
            color: Colors.black,
            size: 23,
          ),
        ),
        AnimatedOpacity(
          opacity: cond ? 1 : 0,
          duration: Duration(milliseconds: 1000),
          child: Icon(
            CupertinoIcons.heart_solid,
            color: Colors.red,
            size: 23,
          ),
        )
      ],
    );
  }
}
