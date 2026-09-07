// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.text,
    this.prefixWidget,
    this.suffixWidget,
    this.textStyle,
  });

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  VoidCallback? onTap;

  double? width;

  double? height;

  String? text;

  TextStyle? textStyle;

  Widget? prefixWidget;

  Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: onTap,
        style: _buildTextButtonStyle(),
        child: _buildButtonWithOrWithoutIcon(),
      ),
    );
  }

  _buildButtonWithOrWithoutIcon() {
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixWidget ?? SizedBox(),
          Text(text ?? "", textAlign: TextAlign.center, style: textStyle),
          suffixWidget ?? SizedBox(),
        ],
      );
    } else {
      return Text(text ?? "", textAlign: TextAlign.center, style: textStyle);
    }
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(width ?? double.maxFinite, height ?? getVerticalSize(40)),
      padding: _setPadding(),
      backgroundColor: _setColor(),
      shape: RoundedRectangleBorder(borderRadius: _setBorderRadius()),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingAll13:
        return getPadding(all: 13);
      default:
        return getPadding(all: 16);
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.FillBluegray900:
        return ColorConstant.blueGray900;
      case ButtonVariant.FillGreen600b2:
        return ColorConstant.green600B2;
      case ButtonVariant.FillRed600b2:
        return ColorConstant.redA200;
        case ButtonVariant.FillOrenj900:
        return ColorConstant.orange300;
      default:
        return ColorConstant.whiteA700;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      case ButtonShape.Cove:
        return BorderRadius.circular(5);
      default:
        return BorderRadius.circular(getHorizontalSize(29.00));
    }
  }

  setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.OutfitMedium20WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(20),
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500,
        );
      case ButtonFontStyle.OutfitMedium25:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(25),
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500,
        );
      default:
        return TextStyle(
          color: ColorConstant.blueGray900,
          fontSize: getFontSize(20),
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500,
        );
    }
  }
}

enum ButtonShape { Square, CircleBorder29, Cove }

enum ButtonPadding { PaddingAll16, PaddingAll13 }

enum ButtonVariant {
  FillWhiteA700,
  FillBluegray900,
  FillOrenj900,
  FillGreen600b2,
  FillRed600b2
}

enum ButtonFontStyle { OutfitMedium20, OutfitMedium20WhiteA700, OutfitMedium25 ,FillOrenj900}
