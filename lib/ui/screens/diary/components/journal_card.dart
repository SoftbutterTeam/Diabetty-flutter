import 'package:flutter/material.dart';

class JournalCard extends StatelessWidget {
  const JournalCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: size.height * 0.12,
              maxHeight: size.height * 0.16,
              minWidth: size.width * 0.8,
              maxWidth: size.width * 0.9),
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
          ),
        ));
  }
}
