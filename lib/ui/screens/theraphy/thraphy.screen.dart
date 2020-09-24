import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/screens/others/auth_screens/login/components/background.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TherapyScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppContext appContext =
        Provider.of<AppContext>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<TherapyManager>(
          create: (_) =>
              TherapyManager(appContext: appContext, isLoading: isLoading),
          child: Consumer<TherapyManager>(
            builder: (_, TherapyManager manager, __) =>
                TherapyScreen._(isLoading: isLoading.value, manager: manager),
          ),
        ),
      ),
    );
  }
}

class TherapyScreen extends StatefulWidget {
  @override
  const TherapyScreen._({Key key, this.isLoading, this.manager})
      : super(key: key);
  final TherapyManager manager;
  final bool isLoading;

  @override
  _TherapyScreenState createState() => _TherapyScreenState();
}

class _TherapyScreenState extends State<TherapyScreen> {
  _buildTherapiesList(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Therapy> therapyList;
    StreamBuilder(
        stream: widget.manager.dataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError)
            therapyList = new List.filled(
                5, new Therapy()); // to produce empty cards i.e. placeholders
          else {
            therapyList = snapshot.data;
          }
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: therapyList.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: size.height * 0.1,
                );
              });

          /// todo place the Card Widgets here using TherapyList(index)
          /// as a parameter.
        });
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
