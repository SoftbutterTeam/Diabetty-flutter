class AlarmSettings {
  bool silent;
  bool noReminder;
  bool enableCriticalAlerts;
  //TODO enable critical alerts
  AlarmSettings(
      {this.silent = false,
      this.enableCriticalAlerts = false,
      this.noReminder = false});

  loadFromJson(Map<String, dynamic> json) {
    this.silent = json['silent'];
    this.noReminder = json['noReminder'];
    this.enableCriticalAlerts = json['enableCriticalAlerts'];
  }

  Map<String, dynamic> toJson() => {
        'silent': this.silent,
        'noReminder': this.noReminder,
        'enableCriticalAlerts': this.enableCriticalAlerts,
      };

  handleReset() {
    enableCriticalAlerts = null;
    silent = null;
    noReminder = null;
  }

  handleValidation(silentToggle, noReminderToggle, enableCriticalToggle) {
    if (silentToggle) {
      silent = true;
      noReminder = false;
    }

    if (noReminderToggle) {
      silent = false;
      noReminder = true;
    }

    if (enableCriticalToggle) {
      enableCriticalAlerts = true;
    } else {
      enableCriticalAlerts = false;
    }
  }
}
