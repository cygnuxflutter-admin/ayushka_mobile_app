import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get fillDeeppurple300 => BoxDecoration(
        color: ColorConstant.deepPurple300,
      );
  static BoxDecoration get fillIndigo20001 => BoxDecoration(
        color: ColorConstant.indigo20001,
      );
  static BoxDecoration get fillDeeporange200 => BoxDecoration(
        color: ColorConstant.deepOrange200,
      );
  static BoxDecoration get fillBlack90066 => BoxDecoration(
        color: ColorConstant.black90066,
      );
  static BoxDecoration get fillBlue50 => BoxDecoration(
        color: ColorConstant.blue50,
      );
  static BoxDecoration get outlineBlack9003f => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9003f,
            spreadRadius: getHorizontalSize(2),
            blurRadius: getHorizontalSize(2),
            offset: Offset(0, 2),
          ),
        ],
      );
  static BoxDecoration get txtFillRedA200 => BoxDecoration(
        color: ColorConstant.redA200,
      );
  static BoxDecoration get fillIndigo200 => BoxDecoration(
        color: ColorConstant.indigo200,
      );
  static BoxDecoration get outlineGray500 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.gray500,
          width: getHorizontalSize(2),
        ),
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get txtFillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
}

class BorderRadiusStyle {
  static BorderRadius circleBorder22 = BorderRadius.circular(
    getHorizontalSize(22),
  );

  static BorderRadius roundedBorder15 = BorderRadius.circular(
    getHorizontalSize(15),
  );

  static BorderRadius roundedBorder10 = BorderRadius.circular(
    getHorizontalSize(
      10,
    ),
  );

  static BorderRadius roundedBorder30 = BorderRadius.circular(
    getHorizontalSize(30),
  );

  static BorderRadius txtCircleBorder20 = BorderRadius.circular(
    getHorizontalSize(20),
  );

  static BorderRadius txtRoundedBorder16 = BorderRadius.circular(
    getHorizontalSize(16),
  );
}


double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;