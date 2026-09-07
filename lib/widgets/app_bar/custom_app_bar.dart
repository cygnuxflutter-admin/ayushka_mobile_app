import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';

enum Style {
  bgFillBluegray900,
}

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    required this.height,
    required this.centerTitle,
    required this.styleType,
    required this.leadingIcon,
    required this.title,
    required this.leadingIconOnTap,
    this.actions,
  }) : super(
          key: key,
        );

  Style styleType;

  double height;

  Widget leadingIcon;

  String title;

  bool centerTitle;

  List<Widget>? actions;

  Function leadingIconOnTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      backgroundColor: ColorConstant.blueGray900,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: AppStyle.txtOutfitBold25.copyWith(
          color: ColorConstant.whiteA700,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          leadingIconOnTap.call();
        },
        child: leadingIcon,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        size.width,
        height,
      );
}
