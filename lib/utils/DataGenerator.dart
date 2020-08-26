import 'package:diabetttty/model/Models.dart';
import 'package:diabetttty/theme/AppImages.dart';
import 'package:diabetttty/theme/T3Images.dart';
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