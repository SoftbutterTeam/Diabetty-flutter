import 'dart:core';

class MedicationInfo {
  String name;
  int strength;
  int appearanceIndex = 0;
  int typeIndex;
  int unitIndex;
  int intakeAdviceIndex;
  Duration restDuration;

  set setMinRest(Duration x) {
    //// print(x.toString());

    if ((x == null) || (Duration(hours: 0, minutes: 5).compareTo(x) > 0))
      restDuration = null;
    else
      restDuration = x;
    //// print(minRest.toString());
  }

  MedicationInfo({
    this.name,
    this.strength,
    this.appearanceIndex = 0,
    this.intakeAdviceIndex = 0,
    this.restDuration,
    this.unitIndex,
    this.typeIndex,
  });
  MedicationInfo.fromJson(Map<String, dynamic> json) {
    loadFromJson(json);
  }
  Map<String, dynamic> toJson() => {
        'appearance': this.appearanceIndex,
        'restDuration':
            this.restDuration == null ? null : this.restDuration.inSeconds,
        'name': this.name,
        'strength': this.strength,
        'intakeAdvice': this.intakeAdviceIndex,
        'unit': this.unitIndex,
        'type': this.typeIndex,
      };

  bool loadFromJson(Map<String, dynamic> json) {
    try {
      if (json.containsKey('restDuration') && json['restDuration'] != null)
        this.restDuration = new Duration(seconds: json['restDuration']);

      if (json.containsKey('name')) this.name = json['name'];
      if (json.containsKey('unit')) this.unitIndex = json['unit'];
      if (json.containsKey('type')) this.typeIndex = json['type'];
      if (json.containsKey('strength')) this.strength = json['strength']?.abs();
      if (json.containsKey('intakeAdvice'))
        this.intakeAdviceIndex = json['intakeAdvice'];

      if (json.containsKey('appearance'))
        this.appearanceIndex = json['appearance'];
      return true;
    } catch (e) {
      // print('failed to loadfromjson ' + e.toString());
      return false;
    }
  }
}
