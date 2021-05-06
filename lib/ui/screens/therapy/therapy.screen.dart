import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/services/authentication/auth_service/firebase_auth_service.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/therapy/components/add_modal.v2.dart';
import 'package:diabetty/ui/screens/therapy/components/background.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_card.dart';
import 'package:diabetty/ui/screens/therapy/mixins/add_therapy_modals.mixin.dart';
import 'package:diabetty/ui/screens/therapy/therapy_profile.screen.dart';
import 'package:diabetty/ui/screens/therapy/therapy_profile_screen2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TherapyScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer < TherapyManager > (
      builder: (_, TherapyManager manager, __) => TherapyScreen._(
        manager: manager,
      ),
    );
  }
}

class TherapyScreen extends StatefulWidget {
  @override
  const TherapyScreen._({
    Key key,
    this.manager
  }): super(key: key);
  final TherapyManager manager;

  @override
  _TherapyScreenState createState() => _TherapyScreenState(manager);
}

class _TherapyScreenState extends State < TherapyScreen >
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
        initialData: manager.usersTherapies,
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data.isEmpty) {
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
        ), );
          }
          List < Therapy > therapies = snapshot.data;
          therapies.sort((a, b) => a.name.compareTo(b.name));
          return Container(
            child: Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: therapies.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TherapyProfileScreen2(
                            therapy: therapies[index],
                          )),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: TherapyCard(
                        therapy: therapies[index],
                      ),
                    ));
                }),
            ),
          );
        });
    }
  }