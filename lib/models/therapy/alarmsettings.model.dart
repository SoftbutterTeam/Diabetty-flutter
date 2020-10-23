class AlarmSettings {
  bool silent;
  bool noReminder;
  bool enableCriticalAlerts;
  //TODO enable critical alerts
  AlarmSettings(
      {this.silent = false,
      this.enableCriticalAlerts = false,
      this.noReminder = false});

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
