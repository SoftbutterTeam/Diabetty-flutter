import 'dart:math';

import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:flutter_svg/svg.dart';

class JournalCard2 extends StatelessWidget with JournalActionsMixin {
  final Journal journal;
  const JournalCard2({Key key, this.journal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextStyle textStyle = TextStyle(
        fontFamily: fontBold,
        fontSize: 18.5,
        color: Colors.deepOrange,
        fontWeight: FontWeight.bold);
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: min(70, size.height * 0.07),
                maxHeight: max(70, size.height * 0.08),
                minWidth: size.width * 0.8,
                maxWidth: size.width * 0.95),
            child: GestureDetector(
              onTap: () => navigateToJournal(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    /* BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, -1),
                ),*/
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(12), //?was 12, also like 10, 11
                  ),
                  //border: Border.all(color: Colors.black    54, width: 0.05),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 20),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Container(
                          child: SvgPicture.asset(
                              'assets/icons/navigation/essentials/diary.svg',
                              height: 25,
                              width: 25,
                              color: Colors.orange[800],
                            ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Container(
                        height: max(6, size.height * 0.02),
                        width: 1.5,
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
                          text(journal?.name?.capitalize() ?? '',
                              textColor: Colors.black,
                              fontFamily: fontMedium,
                              fontSize: 17.0,
                              overflow: TextOverflow.ellipsis),
                          text(
                              journal.updatedAt
                                  .lessShortDateRepresent()
                                  .capitalizeBegins(),
                              textColor: Colors.black45,
                              fontFamily: fontMedium,
                              fontSize: 12.0,
                              overflow: TextOverflow.ellipsis),
                        ]),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/navigation/essentials/next.svg',
                              height: 15,
                              width: 15,
                              color: Colors.orange[800],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
