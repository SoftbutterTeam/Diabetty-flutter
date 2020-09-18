import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingButton({Key key, this.isLoading, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //double height = 20;
    var size = MediaQuery.of(context).size;
    if (isLoading) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.7,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                  color: kPrimaryColor,
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.white),
                    child: Center(
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator()),
                    ),
                  ))));
    }

    return child;
  }
}
