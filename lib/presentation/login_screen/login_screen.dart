import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/core/utils/validation_functions.dart';
import 'package:cattle_app/widgets/custom_button.dart';
import 'package:cattle_app/widgets/custom_text_form_field.dart';
import 'controller/login_controller.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends GetWidget<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: getVerticalSize(600),
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: getVerticalSize(600),
                          width: double.maxFinite,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomImageView(
                                imagePath:
                                    ImageConstant.imgIgapalaczqzped8lo1sg,
                                height: getVerticalSize(600),
                                width: getHorizontalSize(430),
                                alignment: Alignment.center,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment(0.6, 0),
                                              end: Alignment(0.6, 1),
                                              colors: [
                                                ColorConstant.black90000,
                                                ColorConstant.whiteA700,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: getPadding(left: 31),
                          child: Text(
                            "lbl_login2".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtOutfitBold40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: getPadding(
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        autofocus: true,
                        controller: controller.usernameController,
                        hintText: "msg_email_or_username".tr,
                        labelText: "msg_email_or_username".tr,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              (!isValidEmail(value, isRequired: true))) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                      ),
                      Obx(
                        () => CustomTextFormField(
                          autofocus: true,
                          controller: controller.passwordController,
                          hintText: "lbl_password".tr,
                          labelText: "lbl_password".tr,
                          margin: getMargin(top: 15),
                          padding: TextFormFieldPadding.PaddingT26_1,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          suffix: IconButton(
                            onPressed: () {
                              controller.isShowPassword.value =
                                  !controller.isShowPassword.value;
                            },
                            icon: Icon(
                              controller.isShowPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 25,
                              color: Color(0xff232f34),
                            ),
                          ),
                          suffixConstraints: BoxConstraints(
                            maxHeight: getVerticalSize(79),
                          ),
                          validator: (value) {
                            if (value == null ||
                                (!isValidPassword(value, isRequired: true))) {
                              return "Please enter valid password";
                            }
                            return null;
                          },
                          isObscureText: controller.isShowPassword.value,
                        ),
                      ),
                      CustomButton(
                        height: getVerticalSize(58),
                        onTap: () {
                          controller.cmLogin(context);
                        },
                        text: "lbl_login".tr,
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                        margin: getMargin(
                          left: 28,
                          top: 50,
                          right: 29,
                          bottom: 5,
                        ),
                        variant: ButtonVariant.FillBluegray900,
                        fontStyle: ButtonFontStyle.OutfitMedium20WhiteA700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
