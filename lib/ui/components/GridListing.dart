import 'package:diabetttty/ui/theme/AppConstant.dart';
import 'package:diabetttty/ui/theme/AppWidget.dart';
import 'package:diabetttty/utils/model/Models.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GridListing extends StatelessWidget {
  List<Category> bottomModalList;
  var isScrollable = false;

  GridListing(this.bottomModalList, this.isScrollable);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        scrollDirection: Axis.vertical,
        physics:
            isScrollable ? ScrollPhysics() : NeverScrollableScrollPhysics(),
        itemCount: bottomModalList.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => print(bottomModalList[index].name),
            child: Container(
              alignment: Alignment.center,
              decoration: boxDecoration(
                  radius: 10, showShadow: true, bgColor: Color(0XFFFFFFFF)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: width / 7.5,
                    width: width / 7.5,
                    margin: EdgeInsets.only(bottom: 4, top: 8),
                    padding: EdgeInsets.all(width / 30),
                    decoration: boxDecoration(
                        bgColor: bottomModalList[index].color, radius: 10),
                    child: SvgPicture.asset(
                      bottomModalList[index].icon,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                  text(bottomModalList[index].name, fontSize: textSizeMedium)
                ],
              ),
            ),
          );
        });
  }
}
