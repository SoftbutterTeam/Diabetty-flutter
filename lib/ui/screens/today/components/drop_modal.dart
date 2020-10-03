import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/today/components/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DropModal extends StatefulWidget {
  final double height;
  final Widget child;

  const DropModal({Key key, this.height = 0.11, this.child}) : super(key: key);

  @override
  _DropModalState createState() => _DropModalState();
}

class _DropModalState extends State<DropModal> {
  DatePickerController _controller;

  DateTime _selectedValue;

  @override
  void initState() {
    _selectedValue = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DayPlanManager dayManager =
        Provider.of<DayPlanManager>(context, listen: false);
    _controller = dayManager.dateController;

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
                  dayManager.pushAnimation.reverse();
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
                      dayManager.pushAnimation.reverse();
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
    final DayPlanManager dayManager =
        Provider.of<DayPlanManager>(context, listen: false);
    var container = Container(
      width: size.width,
      height: size.height * 0.29,
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.18,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: appWhite,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DatePicker(DateTime.now().subtract(Duration(days: 7)),
                      daysCount: 14,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.deepOrange,
                      selectedTextColor: Colors.white,
                      controller: _controller,
                      dateTextStyle: TextStyle(
                        fontFamily: 'Regular',
                        color: Colors.black87,
                        fontSize: 17,
                      ), onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                    });
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );

    return container;
  }
}
