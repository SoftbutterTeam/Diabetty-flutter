import 'dart:core';

class MedicationInfo {
  String name;
  String strength;
  String appearance;
  String unit;
  String intakeAdvice;
  Duration restDuration;

  MedicationInfo({
    this.name,
    this.strength,
    this.appearance,
    this.intakeAdvice,
    this.restDuration,
    this.unit,
  });

  MedicationInfo.fromJson(Map<String, dynamic> json)
      : restDuration = json['restDuration'],
        name = json['name'],
        strength = json['strength'],
        intakeAdvice = json['intakeAdvice'];

  Map<String, dynamic> toJson() => {
        'restDuration': this.restDuration,
        'name': this.name,
        'strength': this.strength,
        'intakeAdvice': this.intakeAdvice,
      };

  bool loadFromJson(Map<String, dynamic> json) {
    try {
      if (json.containsKey('restDuration')) {
        Duration temp = new Duration(seconds: json['restDuration']);
        this.restDuration = temp;
      }
      if (json.containsKey('name')) this.name = json['name'];
      if (json.containsKey('unit')) this.unit = json['unit'];
      if (json.containsKey('strength')) this.strength = json['strength'];
      if (json.containsKey('intake_advice'))
        this.intakeAdvice = json['intake_advice'];
      if (json.containsKey('appearance')) this.appearance = json['appearance'];
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void editAttributes({
    String name,
    String strength,
    String appearance,
    String unit,
    String intakeAdvice,
    String restDuration,
  }) {
    setAllAttributes(
        restDuration: (restDuration != null ? restDuration : this.restDuration),
        name: (name != null ? name : this.name),
        strength: (strength != null ? strength : this.strength),
        intakeAdvice: (intakeAdvice != null ? intakeAdvice : this.intakeAdvice),
        unit: (unit != null ? unit : this.unit),
        appearance: (appearance != null ? appearance : this.appearance));
  }

  void setAllAttributes({
    Duration restDuration,
    String name,
    String strength,
    String intakeAdvice,
    String unit,
    String appearance,
  }) {
    this.restDuration = restDuration;
    this.name = name;
    this.strength = strength;
    this.intakeAdvice = intakeAdvice;
    this.unit = unit;
    this.appearance = appearance;
  }
}
