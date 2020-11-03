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
          title: text(widget.therapyData.name,
              textColor: Colors.black,
              fontFamily: fontMedium,
              fontSize: 18.0,
              overflow: TextOverflow.ellipsis),
          subtitle: text((widget.therapyData.stock?.currentLevel ?? ''),
              fontFamily: fontMedium,
              textColor: Colors.black26,
              fontSize: 12.0,
              overflow: TextOverflow.ellipsis),
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
  bool get wantKeepAlive => true;
}
