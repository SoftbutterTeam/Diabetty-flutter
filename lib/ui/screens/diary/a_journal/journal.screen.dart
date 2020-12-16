import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/diary/a_journal/header.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:diabetty/ui/screens/diary/a_journal/journal_background.dart';
import 'package:diabetty/ui/screens/diary/components/journal_card.dart';
import 'package:diabetty/ui/screens/diary/components/journal_entry_card.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:diabetty/ui/screens/diary/a_journal/journal_add_record.modal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/src/chart/line_chart/line_chart.dart';

import 'package:provider/provider.dart';

class JournalScreen extends StatefulWidget {
  final Journal journal;

  const JournalScreen({Key key, this.journal}) : super(key: key);

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen>
    with JournalActionsMixin {
  Journal journal;
  DiaryBloc manager;

  @override
  void initState() {
    journal = widget.journal;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    manager = Provider.of<DiaryBloc>(context, listen: false);

    return JournalBackground(
      header: JournalHeader(journal: journal),
      child: StreamBuilder(
          stream: manager.getJournalEntriesStream(journal),
          builder: (context, snapshot) {
            return _body(context);
          }),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: size.width,
            height: size.height * 0.25,
            child: _buildJournalLineChart(context),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, -1),
                    ),
                  ],
                  border: Border(
                      top: BorderSide(color: Colors.transparent, width: 1))),
              child: Container(
                width: size.width,
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: _buildJournalCards(context),
              ),
            ),
          ),
          _buildJournalFooter(size)
        ]);
  }

  Widget _buildJournalCards2(BuildContext context) {
    return (journal.journalEntries.isNotEmpty)
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: journal.journalEntries.length,
            itemBuilder: (context, index) {
              return JournalEntryCard(
                journal: this.journal,
                journalEntry: this.journal.journalEntries[index],
                index: index,
              );
            },
          )
        : SizedBox(
            height: 300,
            child: Container(
              child: null,
            ));
  }

  Widget _buildJournalLineChart(BuildContext context) {
    bool isShowingMainData = true;
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              // Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      sampleData1(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Colors.deepOrange,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'sept';
              case 7:
                return 'oct';
              case 12:
                return 'dec';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 2,
      curveSmoothness: 0.1,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      curveSmoothness: 0.2,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
    ];
  }

  Widget _buildJournalCards(BuildContext context) {
    return (journal.journalEntries.isNotEmpty)
        ? ListView.builder(
            itemCount: journal.journalEntries.length,
            itemBuilder: (context, index) {
              return JournalEntryCard(
                journal: this.journal,
                journalEntry: this.journal.journalEntries[index],
              );
            },
          )
        : SizedBox(
            height: 300,
            child: Container(
              child: null,
            ),
          );
  }

  GestureDetector _buildAddNoteColumn(
      Size size, BoxDecoration decorationStyle, TextStyle style) {
    return GestureDetector(
      onTap: () {
        navigateToAddJournalNote(context);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: size.height * 0.08,
              width: size.width * 0.16,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.orange[100]),
              child: Center(
                child: Icon(
                  Icons.note_add,
                  color: Colors.orange[800],
                  size: 35,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Center(
                child: Text(
              'Note',
              style: style,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildJournalFooter(Size size) {
    final decorationStyle = BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.black87));

    final style = TextStyle(
      color: Colors.orange[800],
      fontFamily: 'Regular',
      fontSize: 15.0,
    );

    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height * 0.15),
        child: IntrinsicHeight(
            child: Container(
          padding: EdgeInsets.only(top: 15),
          width: size.width,
          decoration: BoxDecoration(
              color: appWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0),
                  spreadRadius: 0.5,
                  blurRadius: 1.5,
                  offset: Offset(0, -1),
                ),
              ],
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(200, 100, 100, 0.2),
                  width: 0.7,
                ),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  flex: 1,
                  child: _buildAddNoteColumn(size, decorationStyle, style)),
              Flexible(
                flex: 1,
                child:
                    _buildAddJournalEntryColumn(size, decorationStyle, style),
              )
            ],
          ),
        )));
  }

  Widget _buildAddJournalEntryColumn(
      Size size, BoxDecoration decorationStyle, TextStyle style) {
    return GestureDetector(
      onTap: () {
        showAddRecordPopupModal(context);
      },
      child: Column(
        children: [
          Container(
            height: size.height * 0.08,
            width: size.width * 0.16,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.orange[100]),
            child: Center(
              child: Icon(
                Icons.library_add,
                color: Colors.orange[800],
                size: 35,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Center(
            child: Text(
              'Record',
              style: style,
            ),
          )
        ],
      ),
    );
  }
}
