import 'dart:core';

class MedicationInfo {
  String name;
  int strength;
  int appearanceIndex;
  int typeIndex;
  int unitIndex;
  List<String> intakeAdvice;
  //! intake advice index too? so list<int>
  //! maybe not even  a list anymore too
  //Turned into a list -- CAMEROWN!!!!@@@@@@@@@
  Duration restDuration;

  MedicationInfo({
    this.name,
    this.strength,
    this.appearanceIndex,
    this.intakeAdvice,
    this.restDuration,
    this.unitIndex,
    this.typeIndex,
  });

  MedicationInfo.fromJson(Map<String, dynamic> json)
      : restDuration = json['restDuration'],
        name = json['name'],
        strength = json['strength'],
        intakeAdvice = json['intakeAdvice'];

  Map<String, dynamic> toJson() => {
        'restDuration': this.restDuration.inSeconds,
        'name': this.name,
        'strength': this.strength,
        'intakeAdvice': this.intakeAdvice,
        'unit': this.unitIndex,
      };

  bool loadFromJson(Map<String, dynamic> json) {
    try {
      if (json.containsKey('restDuration')) {
        Duration temp = new Duration(seconds: json['restDuration']);
        this.restDuration = temp;
      }
      if (json.containsKey('name')) this.name = json['name'];
      if (json.containsKey('unit')) this.unitIndex = json['unit'];
      if (json.containsKey('strength')) this.strength = json['strength'];
      if (json.containsKey('intakeAdvice'))
        this.intakeAdvice = json['intakeAdvice'];
      if (json.containsKey('appearance'))
        this.appearanceIndex = json['appearance'];
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void editAttributes({
    String name,
    String strength,
    int appearance,
    String unit,
    List<String> intakeAdvice,
    String restDuration,
  }) {
    setAllAttributes(
        restDuration: (restDuration != null ? restDuration : this.restDuration),
        name: (name != null ? name : this.name),
        strength: (strength != null ? strength : this.strength),
        intakeAdvice: (intakeAdvice != null ? intakeAdvice : this.intakeAdvice),
        unit: (unit != null ? unit : this.unitIndex),
        appearance: (appearance != null ? appearance : this.appearanceIndex));
  }

  void setAllAttributes({
    Duration restDuration,
    String name,
    int strength,
    List<String> intakeAdvice,
    int unit,
    int appearance,
  }) {
    this.restDuration = restDuration;
    this.name = name;
    this.strength = strength;
    this.intakeAdvice = intakeAdvice;
    this.unitIndex = unit;
    this.appearanceIndex = appearance;
  }

  dummyData() {
    this.appearanceIndex = 0;
    this.intakeAdvice = [
      "take it as much as possible",
      "take it as much as possible"
    ];
    this.name = "literal poison";
    Duration duration = new Duration(seconds: 1000);
    this.restDuration = duration;
    this.strength = 200;
    this.unitIndex = 0;
  }
}
