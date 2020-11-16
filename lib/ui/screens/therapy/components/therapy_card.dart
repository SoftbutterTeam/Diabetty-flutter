import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TherapyCard extends StatefulWidget {
  final Therapy therapyData;

  TherapyCard({
    this.therapyData,
  });

  @override
  _TherapyCardState createState() => _TherapyCardState();
}

class _TherapyCardState extends State<TherapyCard>
    with AutomaticKeepAliveClientMixin {
  bool sound = false;

  @override
  Widget build2(BuildContext context) {
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
          title: text(widget.therapyData.name,
              textColor: Colors.black,
              fontFamily: fontMedium,
              fontSize: 18.0,
              overflow: TextOverflow.ellipsis),
          // subtitle: text((widget.therapyData.stock?.currentLevel ?? ''),
          //     fontFamily: fontMedium,
          //     textColor: Colors.black26,
          //     fontSize: 12.0,
          //     overflow: TextOverflow.ellipsis),
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset(
              appearance_iconss[
                  widget.therapyData.medicationInfo.appearanceIndex],
              width: 30,
              height: 30,
            ),
          ),
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              width: width,
              height: height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(width: width * 0.01),
                  OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {},
                      child: Text('View Profile')),
                  OutlineButton(
                      splashColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        // EditTherapyModal(widget.therapyData);
                      },
                      child: Text('Edit Profile')),
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
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: size.height * 0.07,
              maxHeight: size.height * 0.08,
              minWidth: size.width * 0.3,
              maxWidth: size.width * 0.5),
          child: Container(
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
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 20),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset(
                      appearance_iconss[
                          widget.therapyData.medicationInfo.appearanceIndex],
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                    height: size.height * 0.05,
                    width: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange[800],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text(widget.therapyData.name,
                        textColor: Colors.black,
                        fontFamily: fontMedium,
                        fontSize: 16.0,
                        overflow: TextOverflow.ellipsis),
                    text('Expires on 22/09/2020',
                        textColor: Colors.black87,
                        fontFamily: fontMedium,
                        fontSize: 12.0,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/icons/navigation/essentials/compass.svg',
                            height: 25,
                            width: 25,
                            color: Colors.orange[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
