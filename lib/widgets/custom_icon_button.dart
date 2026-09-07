import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    this.shape,
    this.padding,
    this.variant,
    this.alignment,
    this.margin,
    this.width,
    this.height,
    this.child,
    this.onTap,
  });

  IconButtonShape? shape;

  IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? width;

  double? height;

  Widget? child;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        visualDensity: VisualDensity(vertical: -4, horizontal: -4),
        iconSize: getSize(height ?? 0),
        padding: EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: getSize(width ?? 0),
          height: getSize(height ?? 0),
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(color: _setColor(), borderRadius: _setBorderRadius());
  }

  _setPadding() {
    switch (padding) {
      default:
        return getPadding(all: 7);
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.FillOrange300:
        return ColorConstant.orange300;
      case IconButtonVariant.FillRedA200:
        return ColorConstant.redA200;
      case IconButtonVariant.FillBlue200:
        return ColorConstant.blue700;
      case IconButtonVariant.FillWhite200:
        return ColorConstant.whiteA700;
      case IconButtonVariant.FillWhite0:
        return Colors.transparent;
      default:
        return ColorConstant.green600B2;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      default:
        return BorderRadius.circular(getHorizontalSize(21.00));
    }
  }
}

enum IconButtonShape { RoundedBorder21 }

enum IconButtonPadding { PaddingAll7 }

enum IconButtonVariant {
  FillGreen600b2,
  FillOrange300,
  FillRedA200,
  FillBlue200,
  FillWhite200,
  FillWhite0
}
