import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/medication_info.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/screens/therapy/extensions/datetime_extension.dart';

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
  int stock;
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
    this.reminderRules ??= List();
    this.window ??= Duration(minutes: 20);
    this.name ??= '';
    this.stock ??= 0;
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
      print(name);
      print(strength);
      print(minRest);
      print(stock);
      print(strengthUnitsIndex);
      print(window);
    }
  }

  handleAsPlannedSave() {
    if (mode == 'planned') {
      startDate ??= DateTime.now();
      endDate ??= null;
    }
    print(name);
    print(strength);
    print(minRest);
    print(stock);
    print(strengthUnitsIndex);
    print(apperanceIndex);
    print(intakeAdviceIndex);
    print(unitsIndex);
    print(startDate);
    print(endDate);
    print(window);
  }

  Therapy toTherapy() {
    return Therapy(
        mode: this.mode,
        stock: this.stock,
        name: this.name,
        medicationInfo: MedicationInfo(
          appearance: this.apperanceIndex,
          intakeAdvice: List<String>()..add(intakeAdvice[intakeAdviceIndex]),
          name: this.name,
          strength: this.strength,
          unit: unitTypes[this.unitsIndex],
          restDuration: this.minRest,
        ),
        schedule: (mode == 'planned')
            ? Schedule(
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

  bool isNameValid() => this.name != null && this.name.length > 0;

  bool isStrengthValid() => this.strength != null && this.strength > 0;

  bool isStrengthUnitsValid() =>
      this.strengthUnitsIndex != null && this.strengthUnitsIndex >= 0;

  bool isIntakeAdviceValid() =>
      this.intakeAdviceIndex != null && this.intakeAdviceIndex >= 0;

  bool isAppearanceAdviceValid() =>
      this.apperanceIndex != null && this.apperanceIndex >= 0;

  bool isStockValid() => this.stock != null && this.stock > 0;

  bool isMinRestValid() => this.minRest != null;

  bool isAsNeededFormValid() =>
      isNameValid() &&
      isStrengthValid() &&
      isStrengthUnitsValid() &&
      isIntakeAdviceValid() &&
      isAppearanceAdviceValid() &&
      isStockValid();

  bool isDateValid() => this.startDate != null;

  bool isWindowValid() => this.window != null;
}