class AlarmSettings {
  bool silent;
  bool noReminder;
  bool enableCriticalAlerts;
  //TODO enable critical alerts
  AlarmSettings(
      {this.silent = false,
      this.enableCriticalAlerts = false,
      this.noReminder = false});
}
