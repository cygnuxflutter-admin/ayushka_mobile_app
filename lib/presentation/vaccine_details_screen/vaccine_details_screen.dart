import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cattle_app/core/utils/size_utils.dart';
import 'package:cattle_app/presentation/vaccine_details_screen/vaccine_details_controller.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/dropdown/dropdown.dart';
import '../milk_screen/controller/milk_controller.dart';

class VaccineDetails extends GetView<VaccineDetailsController> {
  const VaccineDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MilkController milkController = Get.put(MilkController());

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIconOnTap: () {
            Get.back();
          },
          leadingIcon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          centerTitle: true,
          height: 60,
          title: "Vaccine Details",
          styleType: Style.bgFillBluegray900,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Dropdown(
                  selectedItem: controller.cowIdText,
                  globalKey: controller.cowIdKey,
                  text: 'cowId'.obs,
                  list: milkController.cowList.map((data) => '${data.tagId}-${data.calfName}').toList(),
                  onChanged: (value) async {
                    controller.cowIdController.text = value.toString();
                    controller.cowIdText.value = value.toString();
                  },
                  validator: (value) {
                    if (value == null || value == 'cowId') {
                      return 'Please Enter cowId';
                    }
                    return null;
                  },
                ),
              ),
              Obx(
                () => Dropdown(
                  selectedItem: controller.vaccineTypeText,
                  globalKey: controller.vaccineTypeKey,
                  text: 'Vaccine Type'.obs,
                  list: const [],
                  onChanged: (value) async {
                    controller.vaccineTypeController.text = value.toString();
                    controller.vaccineTypeText.value = value.toString();
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please Enter Vaccine Type.0';
                    }
                    return null;
                  },
                ),
              ),
              CustomTextFormField(
                globalKey: controller.AttemptedDoseKey,
                controller: controller.AttemptedDoseController,
                hintText: "Attempted Dose",
                labelText: "Attempted Dose",
                textInputType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Attempted Dose';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      hintText: "last issue date",
                      labelText: "last issue date",
                      textInputType: TextInputType.none,
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      hintText: "Upcoming Dose Details",
                      labelText: "Upcoming Dose Details",
                      textInputType: TextInputType.none,
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                controller: controller.RemarkController,
                hintText: "Remark",
                labelText: "Remark",
              ),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      activeColor: const Color(0xff232f34),
                      value: controller.AllDoses.value,
                      onChanged: (bool? newValue) {
                        if (newValue != null) {
                          controller.AllDoses.value = newValue;
                        }
                      },
                    ),
                  ),
                  const Text('   All Doses taken and close'),
                ],
              ),
              Obx(
                () => controller.AllDoses.value == true
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomButton(
                          text: "Finish",
                          width: 200,
                          height: 55,
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                          variant: ButtonVariant.FillGreen600b2,
                          onTap: () {},
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomButton(
                          text: "Submit",
                          width: 200,
                          height: 55,
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                          variant: ButtonVariant.FillGreen600b2,
                          onTap: () {},
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
