import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MedicationCard extends StatefulWidget {
  final String name;
  final double width;
  final String appearance;

  MedicationCard({
    this.name,
    this.appearance,
    this.width,
  });

  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard>
    with AutomaticKeepAliveClientMixin {
  bool sound = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.9,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ExpansionTile(
          title: text(widget.name,
              textColor: Colors.black,
              fontFamily: fontMedium,
              fontSize: 18.0,
              overflow: TextOverflow.ellipsis),
          subtitle: text("Reminder",
              fontFamily: fontMedium,
              textColor: Colors.black26,
              fontSize: 12.0,
              overflow: TextOverflow.ellipsis),
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset(
              widget.appearance,
              width: 30,
              height: 30,
            ),
          ),
          children: [
            Container(
              width: width,
              height: height * 0.05,
              child: Row(
                children: [
                  Container(
                    width: width * 0.15,
                    height: height * 0.05,
                    color: Colors.white,
                  ),
                  Container(
                    width: width * 0.6,
                    height: height * 0.05,
                    // color: Colors.green,
                  ),
                  Expanded(
                    child: SizedBox(                      
                      child: Padding(
                        padding: EdgeInsets.only(right: 16, top: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  sound = !sound;
                                });
                              },
                              child: SvgPicture.asset(
                                (sound)
                                    ? 'assets/icons/navigation/essentials/alarm-bell.svg'
                                    : 'assets/icons/navigation/essentials/disable-alarm.svg',
                                height: 25,
                                width: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
