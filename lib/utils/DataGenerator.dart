import 'package:diabetttty/ui/theme/icons.dart';
import 'package:diabetttty/utils/model/Models.dart';
import 'package:diabetttty/ui/theme/T3Images.dart';

import 'package:flutter/material.dart';

List<Category> getBottomSheetItems() {
  var list = List<Category>();
  var category1 = Category();
  category1.name = "Settings";
  category1.color = Color(0XFF45c7db);
  category1.icon = t2_settings;
  list.add(category1);
  var category2 = Category();
  category2.name = "Wallet";
  category2.color = Color(0XFF510AD7);
  category2.icon = t3_ic_favourite;
  list.add(category2);
  var category3 = Category();
  category3.name = "Voucher";
  category3.color = Color(0XFFe43649);
  category3.icon = t3_ic_user;
  list.add(category3);
  var category4 = Category();
  category4.name = "Pay Bill";
  category4.color = Color(0XFFf4b428);
  category4.icon = t3_ic_home;
  list.add(category4);

  var category5 = Category();
  category5.name = "Exchange";
  category5.color = Color(0XFF22ce9a);
  category5.icon = t3_notification;
  list.add(category5);

  var category6 = Category();
  category6.name = "Services";
  category6.color = Color(0XFF203afb);
  category6.icon = t3_ic_recipe;
  list.add(category6);

  return list;
}

List<MedicineCardModel> getFavourites() {
  List<MedicineCardModel> list = List<MedicineCardModel>();
  MedicineCardModel model1 = MedicineCardModel();
  model1.name = "Insulin Short-life";
  model1.duration = "Take 2 before a meal at 10am";
  model1.image = d_1;

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
  list.add(model1);
  list.add(model1);
  list.add(model1);
  return list;
}
