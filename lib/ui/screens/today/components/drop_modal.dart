import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/today/components/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DropModal extends StatefulWidget {
  final double height;
  final Widget child;
  final DayPlanManager manager;

  const DropModal({Key key, this.height = 0.11, this.child, this.manager})
      : super(key: key);

  @override
  _DropModalState createState() => _DropModalState();
}

class _DropModalState extends State<DropModal>
    with AutomaticKeepAliveClientMixin {
  DatePickerController _controller;

  DateTime _selectedValue;

  @override
  void initState() {
    final manager = widget.manager;
    _selectedValue = manager.currentDateStamp;
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;

    _controller = widget.manager.dateController;

    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: GestureDetector(
                onTap: () {
                  widget.manager.pushAnimation.reverse();
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  height: size.height,
                  width: size.width,
                ))),
        body: Column(
          children: [
            _buildModal(context, this.widget.child),
            Expanded(
                child: GestureDetector(
                    onPanStart: (value) {
                      widget.manager.pushAnimation.reverse();
                      Navigator.pop(context);
                    },
                    child: Container(color: Colors.transparent))),
          ],
        ),
      ),
    );
  }

  Widget _buildModal(BuildContext context, Widget child) {
    Size size = MediaQuery.of(context).size;

    var container = Container(
      padding: EdgeInsets.only(top: 12),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: appWhite,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DatePicker(
              DateTime.now()
                  .subtract(Duration(days: 13 + DateTime.now().weekday)),
              dayManager: widget.manager,
              daysCount: 28,
              initialSelectedDate: widget.manager.currentDateStamp,
              selectionColor: Colors.deepOrange,
              selectedTextColor: Colors.white,
              controller: _controller,
              width: size.width / 7.8,
              locale: 'en_gb',
              dateTextStyle: TextStyle(
                fontFamily: 'Regular',
                color: Colors.black87,
                fontSize: 17,
              ), onDateChange: (date) {
            widget.manager.currentDateStamp = date;
            widget.manager.dayScreenSetState?.call();
          }),
          FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                widget.manager.currentDateStamp = DateTime.now();
                //  _controller.animateToDate(
                //     dayManager.currentDateStamp.subtract(Duration(days: 2)));
                //// print(_selectedValue);

                setState(() {});
                widget.manager.dayScreenSetState?.call();
                widget.manager.dateAnimateFunction?.call();
              },
              child: Text('Today'))
        ],
      ),
    );

    return container;
  }

  DateTime parseDate(DateTime date) {
    return DateTime.parse(DateFormat('mm-dd-yyyy').format(date));
  }
}
