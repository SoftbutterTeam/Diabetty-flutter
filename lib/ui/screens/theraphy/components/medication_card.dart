import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MedicationCard extends StatefulWidget {
  final String name;

  final Widget appearance;

  MedicationCard({
    this.name,
    this.appearance,
  });

  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ExpansionTile(
        title: text(widget.name,
            textColor: Colors.black, fontFamily: fontMedium, fontSize: 18.0),
        subtitle: text("Reminder",
            fontFamily: fontMedium, textColor: Colors.black26, fontSize: 12.0),
        leading: CircleAvatar(
          backgroundColor: Colors.orange.withOpacity(0.2),
        ),
        children: [
          Container(
            height: height * 0.05,
          )
        ],
      ),
    );
  }
}
