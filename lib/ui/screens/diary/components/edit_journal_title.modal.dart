import 'dart:math';

import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
// import 'package:diabetty/ui/common_widgets/misc_widgets/cupertino_text_field.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditJournalTitle extends StatefulWidget {
  final Journal journal;

  EditJournalTitle({this.journal});

  @override
  _EditJournalTitleState createState() => _EditJournalTitleState();
}

class _EditJournalTitleState extends State<EditJournalTitle>
    with JournalActionsMixin {
  Journal journal;
  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputController.text = widget.journal != null ? widget.journal.name : '';
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DiaryBloc>(context, listen: true);
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height * 0.30,
        ),
        child: Container(
          width: size.width * 0.8,
          padding: EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextInfoField(context),
              _buildInputField(context),
              _buildCancelAndSaveButtons(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTextInfoField(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height * 0.052,
        ),
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 10),
          width: size.width * 0.7,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  'Edit Journal Name',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 30),
            height: max(size.height * 0.045, 40),
            width: size.width * 0.5,
            child: CupertinoTextField(
              controller: inputController,
              keyboardType: TextInputType.text,
              enableInteractiveSelection: false,
              padding: EdgeInsets.only(top: 10),
              textAlign: TextAlign.center,
              maxLength: 22,
              maxLengthEnforced: true,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.orange[800],
                    width: 0.5,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelAndSaveButtons() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
              child: Text('cancel',
                  style: TextStyle(
                    color: CupertinoColors.destructiveRed,
                  )),
              onPressed: () {
                Navigator.pop(context);
                //print(initialDate);
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              )),
          CupertinoButton(
              child: Text('save',
                  style: TextStyle(
                    color: Colors.orange[800],
                  )),
              onPressed: () {
                if (inputController.text.isNotEmpty) {
                  widget.journal.name = inputController.text;
                  Navigator.pop(context);
                  var manager = Provider.of<DiaryBloc>(context, listen: false);
                  manager.updateListeners();
                }
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              ))
        ],
      ),
    );
  }
}
