import 'dart:math';

import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/animated_scale_button.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/diary/a_journal/header.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:diabetty/ui/screens/diary/a_journal/journal_background.dart';
import 'package:diabetty/ui/screens/diary/components/journal_entry_card.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';

import 'package:diabetty/ui/screens/diary/a_journal/journal_add_record.modal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/src/chart/line_chart/line_chart.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';

class JournalScreen extends StatefulWidget {
  final Journal journal;

  const JournalScreen({Key key, this.journal}) : super(key: key);

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen>
    with JournalActionsMixin, SingleTickerProviderStateMixin {
  Journal journal;
  DiaryBloc manager;
  bool chartMinimized;
  bool draggingIdle;
  double dragSensitivity = 3;
  bool noChart;
  @override
  void initState() {
    draggingIdle = true;

    journal = widget.journal;
    chartMinimized =
        (journal.reportUnitsIndex == 0 || journal.reportUnitsIndex == null)
            ? true
            : true;
    noChart =
        (journal.reportUnitsIndex == 0 || journal.reportUnitsIndex == null);
    // print(journal.reportUnitsIndex);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    manager = Provider.of<DiaryBloc>(context, listen: true);

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
          _buildSwipeFunctions(
            child: Container(
              alignment: Alignment.bottomCenter,
              width: size.width,
              height: chartMinimized
                  ? size.height * 0.000000000000001
                  : size.height * 0.27,
              child: FittedBox(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                fit: chartMinimized ? BoxFit.cover : BoxFit.none,
                child: Container(
                  width: size.width,
                  height: size.height * 0.25,
                  padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: widget.journal.journalEntries != null &&
                          ((widget.journal.journalEntries
                                  .where((element) => !element.isNotesType))
                              .isNotEmpty)
                      ? JournalLineChart(journal: widget.journal)
                      : null,
                ),
              ),
            ),
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
                      blurRadius: 1,
                      offset: Offset(0, -1),
                    ),
                  ],
                  border: Border(
                      top: BorderSide(color: Colors.transparent, width: 1))),
              child: Column(
                children: [
                  if (!noChart &&
                      (widget.journal.journalEntries
                          .where((element) => !element.isNotesType)).isNotEmpty)
                    SizedBox(
                      child: AnimatedScaleButton(
                        onTap: () {
                          // print('clicked');
                          setState(() {
                            chartMinimized = !chartMinimized;
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          child: RotatedBox(
                            quarterTurns: chartMinimized ? 1 : 3,
                            child: SvgPicture.asset(
                              'assets/icons/navigation/essentials/next.svg',
                              height: 18,
                              width: 18,
                              color: Colors.orange[800],
                            ),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Container(
                      width: size.width,
                      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: _buildJournalCards2(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildJournalFooter(size)
        ]);
  }

  AnimatedSize _buildSwipeFunctions({Widget child}) {
    return AnimatedSize(
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 1000),
      vsync: this,
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (draggingIdle) {
              if (details.delta.dy > dragSensitivity) {
                if (chartMinimized) {
                  setState(() {
                    draggingIdle = false;
                    chartMinimized = false;
                  });
                }
              } else if (details.delta.dy < -dragSensitivity) {
                if (!chartMinimized) {
                  setState(() {
                    draggingIdle = false;
                    chartMinimized = true;
                  });
                }
              }
            }
          },
          onPanCancel: () {
            draggingIdle = true;
          },
          onVerticalDragCancel: () {
            draggingIdle = true;
          },
          child: child),
    );
  }

  Widget _buildJournalCards2(BuildContext context) {
    int recordCount = 0;
    int totalRecords = 0;
    this.journal.journalEntries ??= [];
    this.journal.journalEntries.forEach((element) {
      if (!element.isNotesType) totalRecords++;
    });

    int totalNotes = this.journal.journalEntries.length - recordCount;
    int notesCount = 0;
    this.journal.journalEntries.sort((a, b) => b.date.compareTo(a.date));
    return (journal.journalEntries.isNotEmpty)
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 7,
              crossAxisSpacing: 7,
            ),
            itemCount: journal.journalEntries.length,
            itemBuilder: (context, index) {
              if (!journal.journalEntries[index].isNotesType)
                recordCount++;
              else
                notesCount++;
              return JournalEntryCard(
                journal: this.journal,
                journalEntry: this.journal.journalEntries[index],
                index: (!journal.journalEntries[index].isNotesType)
                    ? totalRecords - recordCount + 1
                    : totalNotes - notesCount + 1,
              );
            },
          )
        : SizedBox(
            height: 300,
            child: Container(
              child: null,
            ));
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
              if (journal.reportUnitsIndex != 0 &&
                  journal.reportUnitsIndex != null)
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
              'Check-in',
              style: style,
            ),
          )
        ],
      ),
    );
  }
}

class JournalLineChart extends StatefulWidget {
  const JournalLineChart({
    Key key,
    this.journal,
  }) : super(key: key);

  final Journal journal;

  @override
  _JournalLineChartState createState() => _JournalLineChartState();
}

class _JournalLineChartState extends State<JournalLineChart> {
  JournalEntry first;
  JournalEntry last;
  List<JournalEntry> records;
  double minX;
  double maxX;
  double minY;
  double maxY;
  double intervals;

  int daysLimit = 360;
  List<FlSpot> recordsMapped;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void calculateParameters() {
    records = List.of(widget.journal.journalEntries);
    records.removeWhere((element) => element.isNotesType);
    records.removeWhere((element) => element.date
        .isBefore(DateTime.now().subtract(Duration(days: daysLimit))));
    records.removeWhere((element) => element.date.isAfter(DateTime.now()));
    records.sort((a, b) => b.date.compareTo(a.date));
    first = records.first;
    last = records.last;

    recordsMapped = records
        .map((e) => FlSpot(
            (e.date.isBefore(first.date) && e.date.month > first.date.month)
                ? (e.date.month.toDouble() - 12) +
                    calculateDays(e.date) +
                    (calculateTime(e.date) * calculateDays(e.date) / e.date.day)
                : (e.date.month.toDouble()) +
                    calculateDays(e.date) +
                    (calculateTime(e.date) *
                        calculateDays(e.date) /
                        e.date.day),
            e.recordEntry))
        .toList();

    maxX = records.first.date.month + 1.0;

    minX = max(
        (last.date.isBefore(first.date) && last.date.month > first.date.month)
            ? (last.date.month.toDouble() - 12)
            : (last.date.month.toDouble()),
        maxX - 6);

    List<FlSpot> tRecordsMapped = List.of(recordsMapped);
    tRecordsMapped.sort((a, b) => a.y.compareTo(b.y));

    minY = (tRecordsMapped.first.y * (tRecordsMapped.first.y > 0 ? 0.8 : 1.2))
        .round()
        .toDouble();
    maxY = (tRecordsMapped.last.y * (tRecordsMapped.first.y > 0 ? 1.2 : 0.8))
        .round()
        .toDouble();

    intervals = max(((maxY - minY) ~/ 4).toDouble(), 1);
    // print("${maxY} ${minY} ${maxX} ${minX} ${intervals}");
  }

  double calculateDays(DateTime date) {
    switch (date.month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return date.day / 31;
      case 2:
        return date.day / 27;
      default:
        return date.day / 30;
    }
  }

  double calculateTime(DateTime date) {
    return (date.hour * 60 + date.minute) / (24 * 60);
  }

  @override
  Widget build(BuildContext context) {
    calculateParameters();
    bool isShowingMainData = true;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
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
        ],
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.grey.withOpacity(0.05),
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
          getTextStyles: (value) => TextStyle(
            color: Colors.orange[800],
            fontSize: 13,
          ),
          margin: 10,
          getTitles: (value) {
            switch ((value.toInt() % 12)) {
              case 1:
                return 'jan';
              case 2:
                return 'feb';
              case 3:
                return 'mar';
              case 4:
                return 'apr';
              case 5:
                return 'may';
              case 6:
                return 'jun';
              case 7:
                return 'jul';
              case 8:
                return 'aug';
              case 9:
                return 'sep';
              case 10:
                return 'oct';
              case 11:
                return 'nov';

              case 0:
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
            fontSize: 12,
          ),
          interval: intervals,
          getTitles: (value) {
            // print(value);
            switch (value.toInt()) {
            }
            return value.toInt().toString();
          },
          margin: 10,
          reservedSize: max(20, (maxY.toInt().toString().length * 5.0)),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: Colors.deepOrange[900],
            width: 0.8,
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
      minX: minX,
      maxX: maxX,
      maxY: maxY,
      minY: minY,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    recordsMapped.forEach((element) {
      return; // print('${element.x} ${element.y} ');
    });
    if (records.isEmpty) return [];

    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: recordsMapped,
      isCurved: true,
      //todo
      curveSmoothness: 0.15, //* was 0.15
      colors: [
        Colors.deepOrange[600],
      ],

      barWidth: 1.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: _getDotPainter,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );

    return [
      lineChartBarData1,
    ];
  }

  FlDotPainter _getDotPainter(
      FlSpot spot, double xPercentage, LineChartBarData bar, int index,
      {double size}) {
    return FlDotCirclePainter(
      radius: 3.0,
      color: Colors.deepOrange[600],
      strokeColor: Colors.deepOrange[600],
    );
  }
}
