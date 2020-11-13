import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/routes.dart';
import 'package:flutter/material.dart';

@optionalTypeArgs
mixin JournalActionsMixin<T extends Widget> {
  @protected
  Journal get journal;

  void navigateToJournal(context) {
    Navigator.pushNamed(context, aJournal, arguments: {'journal': journal});
  }
}
