import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JournalNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: _buildPage(context),
    );
  }

  Container _buildHeader(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color textColor = Colors.orange[800];
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          border: Border(
            bottom: BorderSide(
              color: textColor,
              width: 1.0,
            ),
          )),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back_ios, color: textColor, size: 25),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        // border: Border.all(color: textColor, width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 5, bottom: 5),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "save",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: textColor, fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.orange,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(
            child: TextField(),
          ),
          IntrinsicHeight(
            child: Container(
              child: Text(""),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Column(
        children: [_buildHeader(context), _buildBody(context)],
      ),
    );
  }
}
