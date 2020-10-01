
import 'package:diabetty/models/therapy/therapy.model.dart';

class AddTherapyForm {
  String name;
  int strength;
  String units;
  List<String> intakeAdvice;
  String apperanceURL;
  Duration minRest;
  String mode;
  List<ReminderRule> reminderRules;
  AlarmSettings settings;
  int stock;

  AddTherapyForm(
      {this.name,
      this.strength,
      this.units,
      this.intakeAdvice,
      this.apperanceURL,
      this.minRest,
      this.mode,
      this.reminderRules,
      this.settings,
      this.stock});

   
}
