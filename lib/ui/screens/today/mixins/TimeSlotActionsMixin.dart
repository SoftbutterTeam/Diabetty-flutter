import 'package:diabetty/models/reminder.model.dart';
import 'package:flutter/material.dart';

@optionalTypeArgs
mixin TimeSlotActionsMixin<T extends Widget> {
  @protected
  List<Reminder> get reminders;
}
