import 'package:diabetttty/components/index.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:flutter/material.dart';

class AddMedication extends StatefulWidget {
  @override
  _AddMedicationState createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  bool visibility = false;
  bool toggleValue = false;

  var count = 1;
  var selectedValue = "mg";

  var _nameCont = TextEditingController();
  var _measurementCont = TextEditingController();
  

  final _addMedicationKey = GlobalKey<FormState>();

  void _changed() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final name = AddTextInput(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: _nameCont,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
        _addMedicationKey.currentState.save();
      },
      hinttext: "Name",
    );

    final measurement = AddTextInput(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: _measurementCont,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
        _addMedicationKey.currentState.save();
      },
      hinttext: "Measurement",
    );

    final units = Container(
      width: width * 0.3,
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
      ),
      child: DropdownButton<String>(
        underline: SizedBox(),
        isExpanded: true,
        items: <String>["mg", "g", "kg"].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: text(value,
                textColor: t3_textColorPrimary,
                fontSize: textSizeMedium,
                fontFamily: fontRegular),
          );
        }).toList(),
        //hint:Text(selectedValue),
        value: selectedValue,
        onChanged: (newVal) {
          setState(() {
            selectedValue = newVal;
          });
        },
      ),
    );

    final quantity = Visibility(
      visible: visibility,
      child: Container(
        height: width * 0.08,
        alignment: Alignment.center,
        width: width * 0.23,
        decoration: boxDecoration(color: Theme.of(context).primaryColor, radius: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: width * 0.08,
              height: width * 0.08,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4.0),
                      topLeft: Radius.circular(4.0))),
              child: IconButton(
                icon: Icon(Icons.remove, color: Colors.white, size: 10),
                onPressed: () {
                  setState(() {
                    if (count == 1 || count < 1) {
                      count = 1;
                    } else {
                      count = count - 1;
                    }
                  });
                },
              ),
            ),
            text("$count"),
            Container(
              width: width * 0.08,
              height: width * 0.08,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(4.0),
                      topRight: Radius.circular(4.0))),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white, size: 10),
                onPressed: () {
                  setState(() {
                    count = count + 1;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      replacement: GestureDetector(
        onTap: () {
          _changed();
        },
        child: Container(
          width: width * 0.22,
          height: width * 0.08,
          decoration: boxDecoration(color: Colors.black26, radius: 4.0),
          alignment: Alignment.center,
          child: text("Quantity", isCentered: true),
        ),
      ),
    );

    final toggle = Switch(
      value: toggleValue,
      onChanged: (value) {
        setState(() {
          toggleValue = value;
        });
      },
      activeTrackColor: Color(0xFF494FFB),
      activeColor: Color(0xFFDADADA),
    );

    final addbutton = RoundedButton(
      textContent: "Add",
      onPressed: () {
        print(_nameCont.text);
        print(_measurementCont.text);
        print(selectedValue);
        print(count);
      },
    );

    final reset = RoundedButton(
      textContent: "Reset",
      onPressed: () {
        _addMedicationKey.currentState.reset();
        _nameCont.clear();
        _measurementCont.clear();
        setState(() {
          count = 1;
          toggleValue = false;
        });
      },
    );

    final body = Wrap(
      runSpacing: 25,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: name,
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(child: measurement, flex: 7),
              SizedBox(
                width: 16,
              ),
              Flexible(child: units, flex: 3),
            ],
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Flexible(
                        flex: 3,
                        child: Container(
                          width: width * 0.2,
                          child: text((toggleValue) ? "On call  " : "Scheduled",
                              textColor: t3_textColorPrimary, fontSize: 16.0),
                        )),
                    SizedBox(width: 5),
                    Flexible(child: toggle, flex: 1),
                  ],
                ),
              ),
              quantity
            ],
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: addbutton,
              ),
              SizedBox(width: 16),
              Expanded(
                child: reset,
              ),
            ],
          ),
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: text("Add Medication",
            textColor: Colors.black, fontFamily: fontRegular),
      ),
      body: Form(
        key: _addMedicationKey,
        child: Container(
            width: double.infinity,
            child: SingleChildScrollView(child: body),
            margin: EdgeInsets.all(16)),
      ),
    );
  }
}
