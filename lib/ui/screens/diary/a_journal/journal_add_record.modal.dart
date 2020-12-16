import 'dart:math';

import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/constants/journal_constants.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_background.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:provider/provider.dart';

class JournalAddRecord extends StatefulWidget {
  final JournalEntry journalEntry;
  final Journal journal;

  JournalAddRecord({this.journal, this.journalEntry});

  @override
  _JournalAddRecordState createState() => _JournalAddRecordState();
}

class _JournalAddRecordState extends State<JournalAddRecord> {
  JournalEntry journalRecord;

  ScrollController scrollController = ScrollController();
  TextEditingController inputController = TextEditingController();

  bool edit;
  int reportUnitIndex;
  String timeString;
  String recordNum;
  @override
  void initState() {
    edit = widget.journalEntry != null ? true : false;
    journalRecord = widget.journalEntry ??
        new JournalEntry.generated(journal: widget.journal);
    reportUnitIndex = widget.journal.reportUnitsIndex;
    super.initState();
    recordNum = widget.journalEntry?.recordNo?.toString();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height * 0.35,
        ),
        child: Container(
          width: size.width * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeField(context),
              _buildInputField(context),
              _buildCancelAndSubmitButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildTimeField(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 15),
      height: size.height * 0.045,
      width: size.width * 0.7,
      child: Column(
        children: [
          Text(
            (edit) ? recordNum : '',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Text(
             journalRecord.date.shortenDateRepresent(),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // CupertinoTextField(
  //       textAlign: TextAlign.center,
  //       enableInteractiveSelection: false,
  //       onTap: () {
  //         // _showTimePicker();
  //       },
  //       placeholder: (edit)
  //           ? recordNum + ' ' + journalRecord.date.shortenDateRepresent()
  //           : journalRecord.date.shortenDateRepresent(),
  //       placeholderStyle: (timeString == 'Time')
  //           ? TextStyle(
  //               fontSize: 16,
  //               color: Colors.grey[700],
  //             )
  //           : TextStyle(
  //               fontSize: 16,
  //               color: Colors.black,
  //             ),
  //       readOnly: true,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         //  Color(0xfff7f7f7)
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),

  Widget _buildInputField(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            height: max(size.height * 0.045, 40),
            width: size.width * 0.5,
            child: CupertinoTextField(
              keyboardType: TextInputType.number,
              enableInteractiveSelection: false,
              controller: inputController,
              padding: EdgeInsets.only(top: 10),
              textAlign: TextAlign.center,
              maxLength: 3,
              maxLengthEnforced: true,
              decoration: BoxDecoration(
                color: Color(0xfff7f7f7),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              report_measurements[(widget.journal == null ||
                      widget.journal.reportUnitsIndex == null)
                  ? 0
                  : widget.journal.reportUnitsIndex],
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelAndSubmitButtons() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
              child: Text('cancel',
                  style: TextStyle(
                    color: CupertinoColors.destructiveRed,
                  )),
              onPressed: () {
                Navigator.of(context).pop(context);
                //print(initialDate);
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              )),
          CupertinoButton(
              child: Text(edit ? 'save' : 'add',
                  style: TextStyle(
                    color: true ? Colors.indigo : Colors.black26,
                  )),
              onPressed: () {
                if (true) {
                  Provider.of<DiaryBloc>(context, listen: false)
                      .saveJournalEntry(journalRecord);
                  //_handleSubmit();
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
