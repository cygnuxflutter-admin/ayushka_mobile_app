import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';

class Dropdown extends StatelessWidget {
  Dropdown({
    required this.text,
    required this.list,
    required this.onChanged,
    this.clearOnPressed,
    this.selectedItem,
    this.showSearchBox,
    this.validator,
    this.globalKey,
    this.clearButton,
  });

  final RxString text;
  final RxString? selectedItem;
  final void Function(String?)? onChanged;
  final void Function()? clearOnPressed;
  final FormFieldValidator<String>? validator;
  final List<String> list;
  final bool? showSearchBox;
  final bool? clearButton;
  final GlobalKey<FormState>? globalKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
      child: Form(
        key: globalKey,
        child: DropdownSearch<String>(
          selectedItem: selectedItem?.value,

          /// 🔹 IMPORTANT CHANGE (v6)
          items: (filter, loadProps) => list,

          popupProps: PopupProps.dialog(
            showSearchBox: showSearchBox ?? true,
          ),

          /// 🔹 decoratorProps (renamed in v6)
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(getHorizontalSize(10.00)),
                borderSide: BorderSide(
                    color: ColorConstant.blueGray9007f, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(getHorizontalSize(10.00)),
                borderSide: BorderSide(
                    color: ColorConstant.blueGray9007f, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(getHorizontalSize(10.00)),
                borderSide: BorderSide(
                    color: ColorConstant.blueGray9007f, width: 2),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(getHorizontalSize(10.00)),
                borderSide: BorderSide(
                    color: ColorConstant.blueGray9007f, width: 2),
              ),
              contentPadding:
              getPadding(left: 17, top: 18, right: 17, bottom: 18),
              labelText: text.value,
              hintText: text.value,
              labelStyle: TextStyle(
                color: ColorConstant.blueGray9007f,
                fontSize: getFontSize(20),
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
              ),
              hintStyle: TextStyle(
                color: ColorConstant.blueGray9007f,
                fontSize: getFontSize(20),
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
              ),

              /// 🔹 Clear button (v6 way)
              suffixIcon: clearButton == true
                  ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: clearOnPressed,
              )
                  : null,
            ),
          ),

          onChanged: onChanged,
          validator: validator,
        ),
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  CustomDropdown({
    required this.text,
    required this.list,
    required this.onChanged,
    this.clearOnPressed,
    this.selectedItem,
    this.showSearchBox,
    this.validator,
    this.globalKey,
    this.clearButton,
    required this.image,
    required this.height,
  });

  final RxString text;
  final RxString? selectedItem;
  final void Function(String?)? onChanged;
  final void Function()? clearOnPressed;
  final FormFieldValidator<String>? validator;
  final List<String> list;
  final bool? showSearchBox;
  final bool? clearButton;
  final String image;
  final double height;
  final GlobalKey<FormState>? globalKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstant.blueGray9007f, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image(
                image: AssetImage(image),
                height: height,
              ),
            ),
            Expanded(
              child: Form(
                key: globalKey,
                child: DropdownSearch<String>(
                  selectedItem: selectedItem?.value,

                  /// 🔹 v6 items format
                  items: (filter, loadProps) => list,

                  popupProps: PopupProps.dialog(
                    showSearchBox: showSearchBox ?? true,
                  ),

                  decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: getPadding(
                          left: 17, top: 18, right: 17, bottom: 18),
                      labelText: text.value,
                      hintText: text.value,
                      labelStyle: TextStyle(
                        color: ColorConstant.blueGray9007f,
                        fontSize: getFontSize(20),
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                      ),
                      hintStyle: TextStyle(
                        color: ColorConstant.blueGray9007f,
                        fontSize: getFontSize(20),
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                      ),

                      /// 🔹 Clear button
                      suffixIcon: clearButton == true
                          ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: clearOnPressed,
                      )
                          : null,
                    ),
                  ),

                  onChanged: onChanged,
                  validator: validator,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomMultiSelectDropdown extends StatelessWidget {
  CustomMultiSelectDropdown({
    required this.text,
    required this.list,
    required this.onChanged,
    required this.image,
    required this.height,
  });

  final String text;
  final void Function(List<String>)? onChanged;
  final List<String> list;
  final String image;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstant.blueGray9007f, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image(
                image: AssetImage(image),
                height: height,
              ),
            ),
            Expanded(
              child: DropdownSearch<String>.multiSelection(
                items: (filter, loadProps) => list,
                popupProps: const PopupPropsMultiSelection.dialog(
                  showSearchBox: true,
                ),
                dropdownBuilder: (context, selectedItems) {
                  if (selectedItems.isEmpty) {
                    return Text(
                      text,
                      style: TextStyle(
                        color: Colors.transparent,
                        fontSize: getFontSize(20),
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }

                  String displayText = '';
                  if (selectedItems.length > 3) {
                    displayText = selectedItems.take(3).join(', ') + '...';
                  } else {
                    displayText = selectedItems.join(', ');
                  }

                  return Text(
                    displayText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getFontSize(16),
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  );
                },
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: getPadding(
                        left: 17, top: 18, right: 17, bottom: 18),
                    labelText: text,
                    hintText: text,
                    labelStyle: TextStyle(
                      color: ColorConstant.blueGray9007f,
                      fontSize: getFontSize(20),
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                    ),
                    hintStyle: TextStyle(
                      color: ColorConstant.blueGray9007f,
                      fontSize: getFontSize(20),
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
