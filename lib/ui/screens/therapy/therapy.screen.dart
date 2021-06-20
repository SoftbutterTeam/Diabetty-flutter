import 'package:diabetty/blocs/app_context.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/therapy/components/background.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_card.dart';
import 'package:diabetty/ui/screens/therapy/mixins/add_therapy_modals.mixin.dart';
import 'package:diabetty/ui/screens/therapy/therapy_profile_screen2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TherapyScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TherapyManager>(
      builder: (_, TherapyManager manager, __) => TherapyScreen._(
        manager: manager,
      ),
    );
  }
}

class TherapyScreen extends StatefulWidget {
  @override
  const TherapyScreen._({Key key, this.manager}) : super(key: key);
  final TherapyManager manager;

  @override
  _TherapyScreenState createState() => _TherapyScreenState(manager);
}

class _TherapyScreenState extends State<TherapyScreen>
    with AddTherapyModalsMixin {
  TherapyManager manager;
  _TherapyScreenState(this.manager);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 25),
      height: size.height,
      width: size.width,
      child: _buildTherapiesList(context),
    );
  }

  _buildTherapiesList(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: manager.therapyStream,
        builder: (context, snapshot) {
          if (manager.usersTherapies == null ||
              manager.usersTherapies.isEmpty) {
            //print(snapshot.data.toString());
            return Container(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: text("Add your therapies here!"),
                  ),
                  SvgPicture.asset(
                    'assets/images/empty_medicine.svg',
                    height: 250,
                    width: 300,
                  ),
                ],
              ),
            );
          }
          List<Therapy> therapies = manager.usersTherapies;
          therapies.sort((a, b) => a.name.compareTo(b.name));
          return Container(
            child: Scrollbar(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: therapies.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                bool readOnly =
                    Provider.of<AppContext>(context, listen: false).readOnly;
                print(readOnly ? ' READONLYYY' : null);
                var therapy =
                    readOnly ? Provider.of<TherapyManager>(context) : null;
                var dayplan =
                    readOnly ? Provider.of<DayPlanManager>(context) : null;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TherapyProfileScreen2(
                                therapy: therapies[index],
                                therapyManager: therapy,
                                dayManager: dayplan,
                              )),
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: TherapyCard(
                        therapy: therapies[index],
                      )),
                );
              },
            )),
          );
        });
  }
}
