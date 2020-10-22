import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/alarmsettings.model.dart';
import 'package:diabetty/models/therapy/medication_info.model.dart';
import 'package:diabetty/models/therapy/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/schedule.model.dart';
import 'package:diabetty/models/therapy/stock.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/screens/therapy/extensions/datetime_extension.dart';
import 'package:flutter/material.dart';

class AddTherapyForm {
  String name;
  int strength;
  int strengthUnitsIndex;
  int unitsIndex;
  int intakeAdviceIndex;
  int apperanceIndex;
  Duration minRest;
  String mode;
  List<ReminderRule> reminderRules = List();
  AlarmSettings settings;
  Stock stock;
  DateTime startDate;
  DateTime endDate;
  Duration window;
  set setWindow(Duration x) {
    if (Duration(hours: 0, minutes: 5).compareTo(x) > 0)
      window = Duration(minutes: 5);
    else
      window = x;
  }

  set setMinRest(Duration x) {
    print(x.toString());

    if ((x == null) || (Duration(hours: 0, minutes: 5).compareTo(x) > 0))
      window = null;
    else
      minRest = x;
    print(minRest.toString());
  }
  //? could add validation for more setters for more security

  AddTherapyForm(
      {this.name,
      this.strength,
      this.unitsIndex,
      this.strengthUnitsIndex,
      this.intakeAdviceIndex,
      this.apperanceIndex,
      this.minRest,
      this.mode,
      this.settings,
      this.stock,
      this.startDate,
      this.endDate,
      this.window,
      this.reminderRules}) {
    this.stock ??= Stock();
    this.settings ??= AlarmSettings();
    this.reminderRules ??= List();
    this.window ??= Duration(minutes: 20);
    this.name ??= '';
    this.intakeAdviceIndex ??= 0;
    this.startDate ??= DateTime.now();
    this.endDate ??= null;
    this.unitsIndex ??= 0;
    this.strengthUnitsIndex ??= 0;
    this.mode = modeOptions[0];
    this.apperanceIndex = 0;
  }

  handleAsNeededSave() {
    if (mode == 'needed') {
      window = null;
      startDate = null;
      endDate = null;
      settings.enableCriticalAlerts = false;
      settings.noReminder = false;
      settings.silent = false;
    }
  }

  handleAsPlannedSave() {
    if (mode == 'planned' && reminderRules.length >= 1) {
      startDate ??= DateTime.now();
      endDate ??= null;
    } 
  }

  Therapy toTherapy() {
    return Therapy(
        mode: this.mode,
        name: this.name,
        medicationInfo: MedicationInfo(
          appearanceIndex: this.apperanceIndex,
          intakeAdvice: List<String>()..add(intakeAdvice[intakeAdviceIndex]),
          name: this.name,
          strength: this.strength,
          unitIndex: this.unitsIndex,
          restDuration: this.minRest,
        ),
        stock: Stock(
          currentLevel: stock.currentLevel,
          flagLimit: stock.flagLimit,
          remind: stock.remind,
        ),
        schedule: (mode == 'planned')
            ? Schedule(
                alarmSettings: AlarmSettings(
                  noReminder: settings.noReminder,
                  silent: settings.silent,
                  enableCriticalAlerts: settings.enableCriticalAlerts,
                ),
                reminders: this.reminderRules,
                startDate: this.startDate ?? DateTime.now(),
                endDate: (this.endDate == null ||
                        DateTime(this.endDate.year, this.endDate.month,
                                this.endDate.day)
                            .isSameDayAs(this.startDate ?? DateTime.now()))
                    ? null
                    : this.endDate)
            : null);
  }

  bool isVisible() => (this.mode == 'planned');

  bool isPlannedValid() => this.mode =='planned' && this.reminderRules.length >= 1 && this.name != null;

  bool isAsNeededValid() => this.mode == 'needed' && this.name != null;

  bool isNameValid() => this.name != null && this.name.length > 0;

  bool isStrengthValid() => this.strength != null && this.strength > 0;

  bool isStrengthUnitsValid() =>
      this.strengthUnitsIndex != null && this.strengthUnitsIndex >= 0;

  bool isIntakeAdviceValid() =>
      this.intakeAdviceIndex != null && this.intakeAdviceIndex >= 0;

  bool isAppearanceAdviceValid() =>
      this.apperanceIndex != null && this.apperanceIndex >= 0;


  bool isMinRestValid() => this.minRest != null;

  bool isDateValid() => this.startDate != null;

  bool isAlarmSettingsValid() =>
      settings.noReminder != null &&
      settings.enableCriticalAlerts != null &&
      settings.silent != null;

  bool isWindowValid() => this.window != null;
}
