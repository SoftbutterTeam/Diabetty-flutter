class AlarmSettings {
  bool silent;
  bool notifications;
  bool lateReminders;

  AlarmSettings(
      {this.silent = false,
      this.notifications = true,
      this.lateReminders = true});

  loadFromJson(Map<String, dynamic> json) {
    this.silent = json['silent'] ?? false;
    this.notifications = json['notifications'] ?? true;
    this.lateReminders = json['late'] ?? true;
  }

  Map<String, dynamic> toJson() => {
        'silent': this.silent,
        'notifications': this.notifications,
        'late': this.lateReminders,
      };
}
