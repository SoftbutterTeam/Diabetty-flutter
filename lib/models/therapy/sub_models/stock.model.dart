class Stock {
  int _currentLevel;
  int flagLimit;
  bool remind;
  Stock({currentLevel, this.flagLimit, this.remind = true})
      : _currentLevel = currentLevel;

  bool get isActive => remind && _currentLevel != null && flagLimit != null;

  bool get runningLow => (isActive) ? _currentLevel <= flagLimit : false;

  int get currentLevel => (remind == true) ? _currentLevel ?? 0 : _currentLevel;
  set currentLevel(int i) => _currentLevel = i;

  bool get isLowOnStock {
    if (_currentLevel == null || flagLimit == null || !remind) return false;
    return _currentLevel <= flagLimit;
  }

  bool get isOutOfStock {
    if (_currentLevel == null || flagLimit == null || !remind) return false;
    return _currentLevel == 0;
  }

  void takenAmount(int amountTaken) {
    if (_currentLevel == null) return;
    amountTaken = amountTaken.abs();
    (amountTaken > _currentLevel)
        ? _currentLevel = 0
        : _currentLevel -= amountTaken;
  }

  void handleReset() {
    _currentLevel = null;
    flagLimit = null;
  }

  loadFromJson(Map<String, dynamic> json) {
    this._currentLevel = json['currentLevel'];
    this.flagLimit = json['flagLimit'];
    this.remind = json['remind'];
  }

  Map<String, dynamic> toJson() => {
        'currentLevel': this._currentLevel,
        'flagLimit': this.flagLimit,
        'remind': this.remind,
      };

  void refillAdd(int addToStock) {
    (_currentLevel == null)
        ? _currentLevel = addToStock
        : _currentLevel += addToStock;
  }

  void resetAt(int newLevel) {
    _currentLevel = newLevel;
  }

  void remindOn() {
    remind = true;
  }

  void remindOff() {
    remind = false;
  }
}
