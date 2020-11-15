
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_stock_dialog.dart';
import 'package:flutter/material.dart';

@optionalTypeArgs
mixin EditTherapyModalsMixin<T extends StatefulWidget> on State<T> {
  Therapy get therapyForm => therapyForm;

  showEditStockDialog(BuildContext context, TherapyManager manager) {
    showDialog(
        context: context,
        builder: (context) =>
            EditStockDialog(therapyForm: therapyForm, manager: manager));
  }
}