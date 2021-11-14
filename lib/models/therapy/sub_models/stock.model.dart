class Stock {
  int _currentLevel;
  int flagLimit;
  Stock({currentLevel, this.flagLimit}) : _currentLevel = currentLevel;

  bool get isActive =>
      isReminding && _currentLevel != null && flagLimit != null;

  bool get runningLow => (isActive) ? _currentLevel <= flagLimit : false;

  int get currentLevel =>
      (isReminding == true) ? _currentLevel ?? 0 : _currentLevel;
  set currentLevel(int i) => _currentLevel = i;

  bool get isReminding => flagLimit != null;

  bool get isLowOnStock {
    if (_currentLevel == null || flagLimit == null || !isReminding)
      return false;
    return _currentLevel <= flagLimit;
  }

  bool get isOutOfStock {
    if (_currentLevel == null || flagLimit == null || !isReminding)
      return false;
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
  }

  Map<String, dynamic> toJson() => {
        'currentLevel': this._currentLevel,
        'flagLimit': this.flagLimit,
      };

  void refillAdd(int addToStock) {
    (_currentLevel == null)
        ? _currentLevel = addToStock
        : _currentLevel += addToStock;
  }

  void resetAt(int newLevel) {
    _currentLevel = newLevel;
  }
}
