// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/shed_couting/shed_transfer/shed_transfer_controller.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/dropdown/dropdown.dart';
import '../../../widgets/rich_text.dart';
import '../../common file/defaultVariablesList.dart';
import '../../milk_screen/controller/milk_controller.dart';

class ShedTransfer extends GetView<ShedTransferController> {
  const ShedTransfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MilkController milkController = Get.find<MilkController>();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIconOnTap: () {
            Get.back();
            Get.back();
            controller.cowTransfer.clear();
          },
          leadingIcon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          centerTitle: true,
          height: 60,
          title: "Shed Transfer",
          styleType: Style.bgFillBluegray900,
        ),
        body: WillPopScope(
          onWillPop: () async {
            Get.back();
            Get.back();
            controller.cowTransfer.clear();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: CattleRichText(
                    text: 'UserID : ',
                    richText: controller.retrievedData!['user_id'],
                    fontSize1: 15,
                  ),
                ),
                Dropdown(
                  selectedItem: controller.selectedCowId,
                  globalKey: controller.cowIdKey,
                  text: 'cowId'.obs,
                  list: milkController.cowList.map((data) => data.tagId + ' : ' + data.calfName).toList(),
                  onChanged: (value) async {
                    controller.showShed.value = false;
                    controller.cowIdController.text = value.toString();
                    controller.selectedCowId.value = value.toString();
                    controller.CowsDetail(id: controller.cowIdController.text);
                    controller.newShedController.text = 'newShed';
                    controller.selectedNewShed.value = 'newShed';
                    controller.cowTypeController.text = 'cowType';
                    controller.selectedCowType.value = 'cowType';
                  },
                  validator: (value) {
                    if (value == null || value == 'cowId') {
                      return 'Please Enter cowId';
                    }
                    return null;
                  },
                ),
                Obx(
                  () => Column(
                    children: [
                      controller.showShed.value == true
                          ? Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: InkWell(
                                    onTap: null,
                                    child: Text(
                                      "WANT TO SHOW OLD SHED HISTORY ?",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: 'Outfit',
                                      ),
                                    ),
                                  ),
                                ),
                                Dropdown(
                                  selectedItem: controller.selectedOldShed,
                                  globalKey: controller.oldShedKey,
                                  text:
                                      "oldShed : ${controller.oldShedController.text}".obs,
                                  list: shed.map((data) => data.value).toList(),
                                  onChanged: (value) async {
                                    controller.oldShedController.text = value.toString();
                                    controller.selectedOldShed.value = value.toString();
                                  },
                                  validator: (value) {
                                    if (controller.oldShedController.text.isEmpty) {
                                      if (value == null || value == 'oldShed') {
                                        return 'Please Enter oldShed';
                                      }
                                      return 'Please Enter oldShed';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )
                          : const SizedBox(),
                      Dropdown(
                        selectedItem: controller.selectedNewShed,
                        globalKey: controller.newShedKey,
                        text: 'newShed  '.obs,
                        list: shed.map((data) => data.value).toList(),
                        onChanged: (value) async {
                          controller.newShedController.text = value.toString();
                          controller.selectedNewShed.value = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value == 'newShed') {
                            return 'Please Enter newShed';
                          }
                          return null;
                        },
                      ),
                      Dropdown(
                        selectedItem: controller.selectedCowType,
                        globalKey: controller.cowTypeKey,
                        text: 'cowType  '.obs,
                        list: cowType.map((data) => data.value).toList(),
                        onChanged: (value) async {
                          controller.cowTypeController.text = value.toString();
                          controller.selectedCowType.value = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value == 'cowType') {
                            return 'Please Enter cowType';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                CustomTextFormField(
                  labelText: "Description",
                  controller: controller.descriptionController,
                  hintText: "Description",
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Obx(
                    () => Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Shed Transfer List",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        const Divider(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cow Name",
                                style: TextStyle(fontWeight: FontWeight.bold,)),
                            Text(
                              "New Shed ID",
                              style: TextStyle(fontWeight: FontWeight.bold,),
                            ),
                          ],
                        ),
                        const Divider(),
                        SizedBox(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.cowTransfer.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${controller.cowTransfer[index].tagId} : ${controller.cowTransfer[index].calfName}"),
                                        Text(controller.cowTransfer[index].shedId),
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                );
                              },
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
        bottomNavigationBar: CustomButton(
          onTap: () {
            if (controller.cowIdKey.currentState!.validate() &&
                controller.oldShedKey.currentState!.validate() &&
                controller.newShedKey.currentState!.validate() &&
                controller.cowTypeKey.currentState!.validate()) {
              controller.CowTransfer(context);
            }
            controller.cowIdController.text = 'cowId';
            controller.selectedCowId.value = 'cowId';
            controller.oldShedController.text = 'oldShed';
            controller.selectedOldShed.value = 'oldShed';
            controller.newShedController.text = 'newShed';
            controller.selectedNewShed.value = 'newShed';
            controller.cowTypeController.text = 'cowType';
            controller.selectedCowType.value = 'cowType';
          },
          height: getVerticalSize(58),
          text: "continue".tr,
          margin: getMargin(left: 59, right: 58, bottom: 25),
          variant: ButtonVariant.FillGreen600b2,
          padding: ButtonPadding.PaddingAll13,
          textStyle: const TextStyle(color: Colors.white),
          fontStyle: ButtonFontStyle.OutfitMedium25,
        ),
      ),
    );
  }
}
