import 'dart:math';

import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/screens/therapy/mixins/edit_therapy_modals.mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TakeModal extends StatefulWidget {
  final Therapy therapy;
  final TherapyManager therapyBloc;

  TakeModal({this.therapy, this.therapyBloc});

  @override
  _TakeModalState createState() => _TakeModalState();
}

class _TakeModalState extends State<TakeModal> with EditTherapyModalsMixin {
  Therapy therapy;
  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height * 0.30,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildText(),
              _buildInputField(context),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: Center(
        child: Text(
          'How many ' +
              unitTypes[widget.therapy.medicationInfo.unitIndex] +
              ' are you taking?',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 50),
            height: max(size.height * 0.045, 40),
            width: size.width * 0.3,
            child: CupertinoTextField(
              keyboardType: TextInputType.number,
              enableInteractiveSelection: false,
              controller: inputController,
              padding: EdgeInsets.only(top: 10),
              textAlign: TextAlign.center,
              maxLength: 3,
              maxLengthEnforced: true,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.orange[800],
                    width: 0.5,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
              child: Text('cancel',
                  style: TextStyle(
                    color: CupertinoColors.destructiveRed,
                  )),
              onPressed: () {
                Navigator.pop(context);
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              )),
          CupertinoButton(
              child: Text('take', style: TextStyle(color: Colors.orange[800])),
              onPressed: () {
                if (inputController.text.isNotEmpty) {
                  Navigator.pop(context);
                  Provider.of<DayPlanManager>(context, listen: false)
                      .takeMedication(widget.therapy, DateTime.now(),
                          dose: int.parse(inputController.text));
                }
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              ))
        ],
      ),
    );
  }
}
