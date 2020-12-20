import 'dart:math';

import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/constants/journal_constants.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_background.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:provider/provider.dart';

class JournalAddRecord extends StatefulWidget {
  final JournalEntry journalEntry;
  final Journal journal;
  final bool readOnly;
  final int number;

  JournalAddRecord(
      {this.journal, this.journalEntry, this.readOnly, this.number});

  @override
  _JournalAddRecordState createState() => _JournalAddRecordState();
}

class _JournalAddRecordState extends State<JournalAddRecord>
    with JournalActionsMixin {
  Journal journal;
  JournalEntry journalRecord;

  ScrollController scrollController = ScrollController();
  TextEditingController inputController = TextEditingController();
  bool readOnly;
  bool edit;
  int reportUnitIndex;
  String timeString;
  String recordNum;
  int number;
  @override
  void initState() {
    readOnly = widget.readOnly;
    edit = widget.journalEntry != null ? true : false;
    journalRecord = widget.journalEntry ??
        new JournalEntry.generated(journal: widget.journal);
    reportUnitIndex = widget.journal.reportUnitsIndex;
    inputController.text = widget.journalEntry != null
        ? widget.journalEntry.recordEntry.toString()
        : '';
    recordNum = widget?.journalEntry?.recordNo?.toString();
    number = widget.number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DiaryBloc>(context, listen: true);
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height * 0.35,
        ),
        child: Container(
          width: size.width * 0.8,
          padding: EdgeInsets.only(bottom: 15),
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

  IntrinsicHeight _buildTimeField(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.more_horiz,
                        color: Colors.transparent, size: 25),
                  ),
                  Text(
                    (edit) ? 'no. ' + number.toString() : '',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                        onTap: () => (edit)
                            ? showEditRecordActionSheet(context, journalRecord)
                            : null,
                        child: Icon(Icons.more_horiz,
                            color: (edit) ? Colors.black : Colors.transparent,
                            size: 25)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
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
        ),
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
            margin: EdgeInsets.only(bottom: 10, top: 30),
            height: max(size.height * 0.045, 40),
            width: size.width * 0.3,
            child: CupertinoTextField(
              keyboardType: TextInputType.number,
              readOnly: readOnly,
              enableInteractiveSelection: false,
              controller: inputController,
              padding: EdgeInsets.only(top: 10),
              textAlign: TextAlign.center,
              maxLength: 5,
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
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              ((widget.journal == null ||
                          journalRecord.reportUnitsIndex == null)
                      ? 'units'
                      : report_measurements[journalRecord.reportUnitsIndex])
                  .plurarlUnits((journalRecord?.recordEntry?.toInt() ?? 2)),
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

  Widget _buildCancelAndSubmitButtons() {
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
                Navigator.of(context).pop(context);
                //print(initialDate);
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              )),
          CupertinoButton(
              child: Text(readOnly ? '' : edit ? 'save' : 'add',
                  style: TextStyle(
                    color: true ? Colors.orange[800] : Colors.black26,
                  )),
              onPressed: () {
                if (readOnly) {
                  null;
                } else if (inputController.text.isNotEmpty) {
                  journalRecord.recordEntry =
                      double.parse(inputController.text);
                  Provider.of<DiaryBloc>(context, listen: false)
                      .saveJournalEntry(journalRecord);
                  Navigator.of(context).pop(context);
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
