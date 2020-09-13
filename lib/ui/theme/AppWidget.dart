import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
//import 'package:diabetty/main/model/AppMoel.dart';
//import 'package:diabetty/main/screens/ProkitScreenListing.dart';

import 'AppColors.dart';
import 'AppConstant.dart';

Text headerText(var text) {
  return Text(
    text,
    maxLines: 2,
    style: TextStyle(
        fontFamily: fontBold, fontSize: 22, color: appTextColorPrimary),
  );
}

Text subHeadingText(var text) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: fontBold, fontSize: 17.5, color: appTextColorSecondary),
  );
}

Widget text(var text,
    {var fontSize = textSizeLargeMedium,
    textColor = appTextColorSecondary,
    var fontFamily = fontRegular,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.5}) {
  return Text(text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
          height: 1.5,
          letterSpacing: latterSpacing));
}

changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        useWhiteForeground(color));
  } on Exception catch (e) {
    print(e);
  }
}

showToast(BuildContext aContext, String caption) {
  Scaffold.of(aContext).showSnackBar(
      SnackBar(content: text(caption, textColor: appWhite, isCentered: true)));
}

class TopBar extends StatefulWidget {
  var titleName; // changed from var -> final

  TopBar(var this.titleName);

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: appWhite,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                finish(context);
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Center(
                child: headerText(widget.titleName),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

void finish(context) {
  Navigator.pop(context);
}

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

launchScreen(context, String tag, {Object arguments}) {
  if (arguments == null) {
    Navigator.pushNamed(context, tag);
  } else {
    Navigator.pushNamed(context, tag, arguments: arguments);
  }
}

void launchScreenWithNewTask(context, String tag) {
  Navigator.pushNamedAndRemoveUntil(context, tag, (r) => false);
}

Color hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return Color(val);
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color bgColor = appWhite,
    var showShadow = false}) {
  return BoxDecoration(
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      color: bgColor,
      boxShadow: showShadow
          ? [BoxShadow(color: appShadowColor, blurRadius: 5, spreadRadius: 1)]
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

/*
class ThemeList extends StatefulWidget {
  List<ProTheme> list;
  BuildContext mContext;

  ThemeList(this.list, this.mContext);

  @override
  ThemeListState createState() => ThemeListState();
}

class ThemeListState extends State<ThemeList> {
  List<Color> colors = [appCat1, appCat2, appCat3];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return AnimationLimiter(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.list.length,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: height * 0.5,
              child: GestureDetector(
                onTap: () {
                  if (widget.list[index].sub_kits == null ||
                      widget.list[index].sub_kits.isEmpty) {
                    if (widget.list[index].tag.isNotEmpty) {
                      developer.log('Tag', name: widget.list[index].tag);
                      launchScreen(context, widget.list[index].tag);
                    } else {
                      showToast(widget.mContext, appComingSoon);
                    }
                  } else {
                    launchScreen(context, ProkitScreenListing.tag,
                        arguments: widget.list[index]);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: width / 6,
                        height: width / 6,
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.all(width / 25),
                        child: Image.asset(icons[index], color: appWhite),
                        decoration: boxDecoration(
                            bgColor: colors[index % colors.length], radius: 4),
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: <Widget>[
                            Container(
                              width: width,
                              height: width / 6.2,
                              padding: EdgeInsets.only(left: 16, right: 16),
                              margin: EdgeInsets.only(right: width / 28),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      text(widget.list[index].name,
                                          textColor: appTextColorPrimary,
                                          fontFamily: fontMedium,
                                          fontSize: textSizeMedium),
                                      widget.list[index].title_name != null
                                          ? text(widget.list[index].title_name,
                                              textColor: appTextColorSecondary,
                                              fontFamily: fontRegular,
                                              fontSize: textSizeSmall)
                                          : SizedBox(),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 25,
                                    margin: EdgeInsets.only(right: 8),
                                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    decoration:
                                        widget.list[index].type.isNotEmpty
                                            ? boxDecoration(
                                                bgColor: appDarkRed, radius: 4)
                                            : BoxDecoration(),
                                    child: text(widget.list[index].type,
                                        fontSize: textSizeSmall,
                                        textColor: appWhite),
                                  )
                                ],
                              ),
                              decoration: boxDecoration(
                                  bgColor: appWhite,
                                  radius: 4,
                                  showShadow: true),
                            ),
                            Container(
                              width: width / 14,
                              height: height / 14,
                              child: Icon(Icons.keyboard_arrow_right,
                                  color: appWhite),
                              decoration: BoxDecoration(
                                  color: colors[index % colors.length],
                                  shape: BoxShape.circle),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/
