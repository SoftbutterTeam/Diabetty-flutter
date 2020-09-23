import 'package:diabetty/ui/constants/icons.dart';
import 'package:flutter/widgets.dart';

class Category {
  var name = "";
  Color color;
  var icon = "";
}

class MedicineCardModel {
  var name = "";
  var duration = "";
  var image = "";
}

List<MedicineCardModel> getFavourites() {
  List<MedicineCardModel> list = List<MedicineCardModel>();
  MedicineCardModel model1 = MedicineCardModel();
  model1.name = "Insulin Short-life";
  model1.duration = "Take 2 before a meal at 10am";
  model1.image = 'assets/icons/navigation/clock/medication.jpeg';

  MedicineCardModel model2 = MedicineCardModel();
  model2.name = "Aids Cure";
  model2.duration = "15 min ago";
  model2.image = d_2;

  MedicineCardModel model3 = MedicineCardModel();
  model3.name = "Cancer Cure";
  model3.duration = "an hour ago";
  model3.image = d_3;

  MedicineCardModel model4 = MedicineCardModel();
  model4.name = "Fatness Cure";
  model4.duration = "5 hour ago";
  model4.image = d_4;

  MedicineCardModel model5 = MedicineCardModel();
  model5.name = "Skinny Cure";
  model5.duration = "7 hour ago";
  model5.image = d_5;

  list.add(model1);
  list.add(model2);
  list.add(model3);
  list.add(model4);
  return list;
}
