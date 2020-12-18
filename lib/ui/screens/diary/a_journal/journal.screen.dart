import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/animated_scale_button.dart';
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
    print(journal.reportUnitsIndex);
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
          _buildSwipeFunctions(
            child: SizedBox(
              width: size.width,
              height: chartMinimized
                  ? size.height * 0.00000000000001
                  : size.height * 0.25,
              child: FittedBox(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                fit: BoxFit.none,
                child: Container(
                  width: size.width,
                  height: size.height * 0.25,
                  padding: EdgeInsets.only(top: 10),
                  child: JournalLineChart(journal: widget.journal),
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
                  if (!noChart)
                    SizedBox(
                      child: AnimatedScaleButton(
                        onTap: () {
                          print('clicked');
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
    int notesCount = 0;
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
                    ? recordCount
                    : notesCount,
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
              'Record',
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isShowingMainData = true;
    return AspectRatio(
      aspectRatio: 1.4,
      child: Container(
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
            color: Colors.deepOrange[900],
            fontSize: 13,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'jan';
              case 7:
                return 'feb';
              case 12:
                return 'mar';
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
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '100';
              case 2:
                return '200';
              case 3:
                return '300';
              case 4:
                return '400';
            }
            return '';
          },
          margin: 8,
          reservedSize: 20,
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
        FlSpot(2, 1.2),
        FlSpot(3, 2.8),
        FlSpot(4, 1.2),
        FlSpot(5, 1.2),
        FlSpot(6, 1.2),
        FlSpot(7, 1.2),
        FlSpot(8, 1.2),
        FlSpot(9, 1.2),
        FlSpot(10, 2.8),
        FlSpot(11, 1.2),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      curveSmoothness: 0.15,
      colors: [
        Colors.deepOrange[600],
      ],
      barWidth: 1.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );

    return [
      lineChartBarData1,
    ];
  }
}
