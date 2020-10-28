import 'package:flutter/material.dart';

class Stock {
  int currentLevel;
  int flagLimit;
  bool remind;
  Stock({this.currentLevel, this.flagLimit, this.remind = true});

  bool get isActive => remind && currentLevel != null && flagLimit != null;

  bool get runningLow => (isActive) ? currentLevel <= flagLimit : false;

  void takenAmount(int amountTaken) {
    if (currentLevel == null) return;
    (amountTaken > currentLevel)
        ? currentLevel = 0
        : currentLevel -= amountTaken;
  }

  void handleReset() {
    currentLevel = null;
    flagLimit = null;
  }

  //TODO THIS SHOULD NOT BE HERE DAN
  void handleValidation(TextEditingController currentLevelController,
      TextEditingController flagLimitController) {
    int currentLevelControllerToInt = int.parse(currentLevelController.text);
    int flagLimitControllerToInt = int.parse(flagLimitController.text);
    currentLevel = currentLevelControllerToInt;
    flagLimit = flagLimitControllerToInt;
  }

  loadFromJson(Map<String, dynamic> json) {
    this.currentLevel = json['currentLevel'];
    this.flagLimit = json['flagLimit'];
    this.remind = json['remind'];
  }

  Map<String, dynamic> toJson() => {
        'currentLevel': this.currentLevel,
        'flagLimit': this.flagLimit,
        'remind': this.remind,
      };

  void refillAdd(int addToStock) {
    (currentLevel == null)
        ? currentLevel = addToStock
        : currentLevel += addToStock;
  }

  void resetAt(int newLevel) {
    currentLevel = newLevel;
  }

  void remindOn() {
    remind = true;
  }

  void remindOff() {
    remind = false;
  }
}
