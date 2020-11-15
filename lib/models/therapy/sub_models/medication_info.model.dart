import 'dart:core';

class MedicationInfo {
  String name;
  int strength;
  int appearanceIndex = 0;
  int typeIndex;
  int unitIndex;
  List<int> intakeAdvices;
  Duration restDuration;

  MedicationInfo({
    this.name,
    this.strength,
    this.appearanceIndex = 0,
    this.intakeAdvices,
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
        'intakeAdvices': this.intakeAdvices,
        'unit': this.unitIndex,
      };

  bool loadFromJson(Map<String, dynamic> json) {
    try {
      if (json.containsKey('restDuration') && json['restDuration'] != null) {
        Duration temp = new Duration(seconds: json['restDuration']);
        this.restDuration = temp;
      }
      if (json.containsKey('name')) this.name = json['name'];
      if (json.containsKey('unit')) this.unitIndex = json['unit'];
      if (json.containsKey('strength')) this.strength = json['strength'];
      if (json.containsKey('intakeAdvices'))
        this.intakeAdvices = new List<int>.from(json['intakeAdvices']);
      if (json.containsKey('appearance'))
        this.appearanceIndex = json['appearance'];
      return true;
    } catch (e) {
      //print(e);
      return false;
    }
  }
}
