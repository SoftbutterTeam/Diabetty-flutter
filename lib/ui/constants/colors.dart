import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const t2_colorPrimary = Color(0XFF5959fc);
const t2_colorPrimaryDark = Color(0XFF7900F5);
const t2_colorPrimaryLight = Color(0XFFF2ECFD);
const t2_colorAccent = Color(0XFF7e05fa);
const t2_textColorPrimary = Color(0XFF212121);
const t2_textColorSecondary = Color(0XFF747474);
const app_background = Color(0XFFf8f8f8);
const t2_view_color = Color(0XFFDADADA);
const t2_white = Color(0XFFFFFFFF);
const t2_icon_color = Color(0XFF747474);
const t2_blue = Color(0XFF1C38D3);
const t2_orange = Color(0XFFFF5722);
const t2_background_bottom_navigation = Color(0XFFE9E7FE);
const t2_background_selected = Color(0XFFF3EDFE);
const t2_green = Color(0XFF5CD551);
const t2_red = Color(0XFFFD4D4B);
const t2_card_background = Color(0XFFFaFaFa);
const t2_bg_bottom_sheet = Color(0XFFE8E6FD);
const t2_instagram_pink = Color(0XFFCC2F97);
const t2_linkedin_pink = Color(0XFF0c78b6);
var t2lightStatusBar = materialColor(0XFFEAEAF9);
var t2White = materialColor(0XFFFFFFFF);
var t2TextColorPrimary = materialColor(0XFF212121);
var shadowColor = shadowGrey;
var shadowOrange = Colors.orange;
var shadowGrey = Colors.grey;

/// Used in iOS 10 for light background fills such as the chat bubble background.
///
/// This is SystemLightGrayColor in the iOS palette.
const Color lightBackgroundGray = Color(0xFFE5E5EA);

/// Used in iOS 12 for very light background fills in tables between cell groups.
///
/// This is SystemExtraLightGrayColor in the iOS palette.
const Color extraLightBackgroundGray = Color(0xFFEFEFF4);

/// Used in iOS 12 for very dark background fills in tables between cell groups
/// in dark mode.
// Value derived from screenshot from the dark themed Apple Watch app.
const Color darkBackgroundGray = Color(0xFF171717);

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor materialColor(colorHax) {
  return MaterialColor(colorHax, color);
}

MaterialColor colorCustom = MaterialColor(0XFF5959fc, color);

const appColorPrimary = Color(0XFF6200EE);
const appColorPrimaryDark = Color(0XFF3700B3);
const appColorAccent = Color(0XFF03DAC5);
const appTextColorPrimary = Color(0XFF212121);
const appTextColorSecondary = Color(0XFF5A5C5E);
const appLayout_background = Color(0XFFf8f8f8);
const appWhite = Color(0XFFFFFFFF);
const appLight_purple = Color(0XFFdee1ff);
const appLight_orange = Color(0XFFffddd5);
const appLight_parrot_green = Color(0XFFb4ef93);
const appIconTintCherry = Color(0XFFffddd5);
const appIconTint_sky_blue = Color(0XFF73d8d4);
const appIconTint_mustard_yellow = Color(0XFFffc980);
const appIconTintDark_purple = Color(0XFF8998ff);
const appTxtTintDark_purple = Color(0XFF515BBE);
const appIconTintDarkCherry = Color(0XFFf2866c);
const appIconTintDark_sky_blue = Color(0XFF73d8d4);
const appDark_parrot_green = Color(0XFF5BC136);
const appDarkRed = Color(0XFFF06263);
const appLightRed = Color(0XFFF89B9D);
const appCat1 = Color(0XFF8998FE);
const appCat2 = Color(0XFFFF9781);
const appCat3 = Color(0XFF73D7D3);
const appShadowColor = Color(0X95E9EBF0);
const appColorPrimaryLight = Color(0XFFF9FAFF);
