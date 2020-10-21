class Stock {
  int currentLevel;
  int flagLimit;
  bool remind;
  Stock({this.currentLevel, this.flagLimit, this.remind = true});

  bool get isActive => remind && currentLevel != null && flagLimit != null;

  bool get runningLow => (isActive) ? currentLevel <= flagLimit : false;

  void takenAmount(int amountTaken) {
    (currentLevel == null || amountTaken > currentLevel)
        ? currentLevel = 0
        : currentLevel -= amountTaken;
  }

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
