import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/resources.dart';

extension TextStyleExt on TextStyle {
  TextStyle get thin => weight(FontWeight.w100);
  TextStyle get extraLight => weight(FontWeight.w200);
  TextStyle get light => weight(FontWeight.w300);
  TextStyle get regular => weight(FontWeight.w400);
  TextStyle get medium => weight(FontWeight.w500);
  TextStyle get semiBold => weight(FontWeight.w600);
  TextStyle get bold => weight(FontWeight.w700);
  TextStyle get italic => fontStyle(FontStyle.italic);
  TextStyle get normal => fontStyle(FontStyle.normal);

  TextStyle get openColor => textColor(MyColors.open);
  TextStyle get receivedColor => textColor(MyColors.received);
  TextStyle get exportedColor => textColor(MyColors.exported);
  TextStyle get cancelColor => textColor(MyColors.red);
  TextStyle get primaryGray => textColor(MyColors.primaryGray);
  TextStyle get disableControlGray => textColor(MyColors.disableControlGray);
  TextStyle get disableControlPrimary => textColor(MyColors.disableControlPrimary);
  TextStyle get disableControlPrimaryDark => textColor(MyColors.disableControlPrimaryDark);
  TextStyle get nameColor => textColor(MyColors.nameColor);
  TextStyle get nameColor34 => textColor(MyColors.nameColor.withOpacity(0.34));
  TextStyle get nameColorDark => textColor(MyColors.nameColorDark);
  TextStyle get underLine => decoration(TextDecoration.underline);
  TextStyle get primaryWhiteColor => textColor(MyColors.primaryWhite);
  TextStyle get appBarColor => textColor(MyColors.primary);
  TextStyle get primaryBlack => textColor(MyColors.dark_bg_color);
  TextStyle get description => textColor(MyColors.description);
  TextStyle get primaryLight => textColor(MyColors.primaryLight);

  TextStyle get size8 => size(Dimens.typography8);
  TextStyle get size10 => size(Dimens.typography10);
  TextStyle get size12 => size(Dimens.typography12);
  TextStyle get size13 => size(Dimens.typography12);
  TextStyle get size14 => size(Dimens.typography14);
  TextStyle get size15 => size(Dimens.typography14);
  TextStyle get size16 => size(Dimens.typography16);
  TextStyle get size17 => size(Dimens.typography17);
  TextStyle get size18 => size(Dimens.typography18);
  TextStyle get size20 => size(Dimens.typography20);
  TextStyle get size21 => size(Dimens.typography21);
  TextStyle get size24 => size(Dimens.typography24);
  TextStyle get size38 => size(Dimens.typography38);

  TextStyle size(double size) => copyWith(fontSize: size);

  TextStyle textColor(Color v) => copyWith(color: v);

  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  TextStyle fontStyle(FontStyle v) => copyWith(fontStyle: v);

  TextStyle decoration(TextDecoration v) => copyWith(decoration: v);

  TextStyle fontFamilies(String v) => copyWith(fontFamily: v);
}

extension ColorSchemeExt on ColorScheme {
  bool get isDark => brightness == Brightness.dark;

  Color get primaryColor => isDark ? MyColors.primaryDark : MyColors.primary;
}
