import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/today/components/date_picker.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StrengthDropModal extends StatefulWidget {
  final Widget child;

  const StrengthDropModal({Key key, this.child}) : super(key: key);

  @override
  _StrengthDropModalState createState() => _StrengthDropModalState();
}

class _StrengthDropModalState extends State<StrengthDropModal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DatePicker(DateTime.now().subtract(Duration(days: 7)),
                      daysCount: 14,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.deepOrange,
                      selectedTextColor: Colors.white,
                      locale: 'en_gb',
                      dateTextStyle: TextStyle(
                        fontFamily: 'Regular',
                        color: Colors.black87,
                        fontSize: 17,
                      ), onDateChange: (date) {
                    // New date selected

                    print(date);
                  }),
                  FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Text('Today'))
                ],
              ),
            ),
          )
        ],
      ),
    );

    return container;
  }

  DateTime parseDate(DateTime date) {
    return DateTime.parse(DateFormat('mm-dd-yyyy').format(date));
  }
}
