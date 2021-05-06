import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/resources.dart';

class UIHelper {
  UIHelper._();

  static const double appLogoAspectRatio = 16 / 9;
  static const double appLogoAspectRatio1 = 20 / 9;
  static const double newsItemAspectRatio = 4 / 3;
  static const double exploredUtilityRatio = 5 / 1;
  static const double communityRatingImageRatio = 5 / 3;
  static const double aspectRatio_16_9 = 16 / 9;
  static const double aspectRatio_20_9 = 20 / 9;
  static const double aspectRatio_5_4 = 5 / 4;
  static const double aspectRatio_4_3 = 4 / 3;
  static const double defaultBorderRadius = Dimens.size12;
  static const double maximumHomeSliverAppBarHeight = 350.0;
  static const int cacheWidth = 1000;
  static const int cacheHeight = 1000;

  /// Fill box
  static const fillBoxConstraint = BoxConstraints.expand();

  static const emptyBox = SizedBox();

  /// Vertical Spacing
  static const verticalBox1 = SizedBox(height: Dimens.size1);
  static const verticalBox2 = SizedBox(height: Dimens.size2);
  static const verticalBox4 = SizedBox(height: Dimens.size4);
  static const verticalBox5 = SizedBox(height: Dimens.size5);
  static const verticalBox8 = SizedBox(height: Dimens.size8);
  static const verticalBox6 = SizedBox(height: Dimens.size6);
  static const verticalBox12 = SizedBox(height: Dimens.size12);
  static const verticalBox16 = SizedBox(height: Dimens.size16);
  static const verticalBox20 = SizedBox(height: Dimens.size20);
  static const verticalBox24 = SizedBox(height: Dimens.size24);
  static const verticalBox28 = SizedBox(height: Dimens.size28);
  static const verticalBox32 = SizedBox(height: Dimens.size32);
  static const verticalBox48 = SizedBox(height: Dimens.size48);
  static const verticalBox64 = SizedBox(height: Dimens.size64);

  /// Horizontal Spacing
  static const horizontalBox5 = SizedBox(width: Dimens.size5);
  static const horizontalBox8 = SizedBox(width: Dimens.size8);
  static const horizontalBox12 = SizedBox(width: Dimens.size12);
  static const horizontalBox16 = SizedBox(width: Dimens.size16);
  static const horizontalBox18 = SizedBox(width: Dimens.size18);
  static const horizontalBox20 = SizedBox(width: Dimens.size20);
  static const horizontalBox24 = SizedBox(width: Dimens.size24);
  static const horizontalBox32 = SizedBox(width: Dimens.size32);

  /// EdgeInsets
  static const edgeInsetsAll8 = EdgeInsets.all(Dimens.size8);
  static const edgeInsetsAll5 = EdgeInsets.all(Dimens.size5);
  static const edgeInsetsAll6 = EdgeInsets.all(Dimens.size6);
  static const edgeInsetsAll12 = EdgeInsets.all(Dimens.size12);
  static const edgeInsetsAll16 = EdgeInsets.all(Dimens.size16);

  /// Vertical EdgeInsets
  static const verticalEdgeInsets2 = EdgeInsets.symmetric(vertical: Dimens.size2);
  static const verticalEdgeInsets4 = EdgeInsets.symmetric(vertical: Dimens.size4);
  static const verticalEdgeInsets8 = EdgeInsets.symmetric(vertical: Dimens.size8);
  static const verticalEdgeInsets12 = EdgeInsets.symmetric(vertical: Dimens.size12);
  static const verticalEdgeInsets16 = EdgeInsets.symmetric(vertical: Dimens.size16);
  static const verticalEdgeInsets24 = EdgeInsets.symmetric(vertical: Dimens.size24);

  /// Horizontal EdgeInsets
  static const horizontalEdgeInsets4 = EdgeInsets.symmetric(horizontal: Dimens.size4);
  static const horizontalEdgeInsets8 = EdgeInsets.symmetric(horizontal: Dimens.size8);
  static const horizontalEdgeInsets12 = EdgeInsets.symmetric(horizontal: Dimens.size12);
  static const horizontalEdgeInsets16 = EdgeInsets.symmetric(horizontal: Dimens.size16);
  static const horizontalEdgeInsets20 = EdgeInsets.symmetric(horizontal: Dimens.size20);
  static const horizontalEdgeInsets32 = EdgeInsets.symmetric(horizontal: Dimens.size32);

  /// Only EdgeInsets
  static const onlyLeftEdgeInsets16 = EdgeInsets.only(left: Dimens.size16);

  /// Padding EdgeInsets
  static const paddingAll2 = const EdgeInsets.all(Dimens.size2);
  static const paddingAll4 = const EdgeInsets.all(Dimens.size4);
  static const paddingAll6 = const EdgeInsets.all(Dimens.size6);
  static const paddingAll8 = const EdgeInsets.all(Dimens.size8);
  static const paddingAll12 = const EdgeInsets.all(Dimens.size12);
  static const paddingAll16 = const EdgeInsets.all(Dimens.size16);
  static const paddingAll24 = const EdgeInsets.all(Dimens.size24);
  static const paddingZero = const EdgeInsets.all(0);
}
