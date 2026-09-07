import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/cow_screen/Add_cow/add_cow_controller.dart';
import '../../../widgets/alert_dialog.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/dropdown/dropdown.dart';
import '../../common file/defaultVariablesList.dart';

class CowTransferScreen extends GetView<AddCowScreenController> {
  const CowTransferScreen();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoutes.dashboardScreen);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            centerTitle: true,
            height: getVerticalSize(60),
            leadingIcon: Icon(Icons.arrow_back,color: Colors.white,),
            leadingIconOnTap: (){
              Get.offAllNamed(AppRoutes.dashboardScreen);
            },
            title: 'Shed Transfer',
            styleType: Style.bgFillBluegray900,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => Column(
                    children: [
                      Dropdown(
                        globalKey: controller.CowTypeKey,
                        text: 'Cow Type : '.obs,
                        list: cowType.map((data) => data.value).toList(),
                        onChanged: (value) async {
                          controller.CowTypeController.text = value.toString();
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please Enter Cow Type';
                          }
                          return null;
                        },
                      ),
                      Dropdown(
                        globalKey: controller.ShedIdKey,
                        text: 'New Shed Id : '.obs,
                        list: shed.map((data) => data.value).toList(),
                        onChanged: (value) async {
                          controller.ShedIdController.text = value.toString();
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please Enter New Shed Id';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                CustomTextFormField(
                  globalKey: controller.RemarkKey,
                  controller: controller.RemarkController,
                  hintText: "Remark",
                  labelText: "Remark",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Remark';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomButton(
            onTap: () {
              if (controller.CowTypeKey.currentState!.validate() &&
                  controller.ShedIdKey.currentState!.validate() &&
                  controller.RemarkKey.currentState!.validate()) {
                CattleAlertDialog(
                  context,
                  cancelonTap: () {
                    Get.back();
                  },
                  Sajesan: 'Do you want to exit this cow ',
                  onpressed: () {
                    controller.CowTransfer(context);
                    Get.offAllNamed(AppRoutes.dashboardScreen);
                  },
                  text: 'Continue',
                  cancel: true,
                );
              }
            },
            height: getVerticalSize(58),
            text: "lbl_done".tr,
            textStyle: TextStyle(color: Colors.white),
            margin: getMargin(left: 59, right: 58, bottom: 25),
            variant: ButtonVariant.FillGreen600b2,
            padding: ButtonPadding.PaddingAll13,
            fontStyle: ButtonFontStyle.OutfitMedium25,
          ),
        ),
      ),
    );
  }
}
