import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class DropModal extends StatelessWidget {
  final double height;
  final Widget child;
  const DropModal({Key key, this.height = 0.11, this.child}) : super(key: key);

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
      child: Column(
        children: [
          _buildModal(context, this.child), //* AddModal or AddModal2
          Expanded(
              child: GestureDetector(
                  onPanStart: (value) {
                    Navigator.pop(context);
                  },
                  child: Container(color: Colors.transparent))),
        ],
      ),
    );
  }

  Widget _buildModal(BuildContext context, Widget child) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.29,
      child: Column(
        children: [
          Container(
            height: size.height * this.height,
            child: Stack(
              children: [
                Positioned(
                  top: 35,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: FlatButton(
                      onPressed: null,
                      color: Colors.transparent,
                      disabledTextColor: Colors.grey,
                      disabledColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      child: Align(
                        child: Icon(Icons.add, color: Colors.white),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 35,
                  left: 5,
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: FlatButton(
                      onPressed: null,
                      padding: EdgeInsets.zero,
                      child: Align(
                        child: SvgPicture.asset(
                          'assets/icons/navigation/essentials/012-settings.svg',
                          height: 22,
                          width: 22,
                          color: Colors.white,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.black,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
