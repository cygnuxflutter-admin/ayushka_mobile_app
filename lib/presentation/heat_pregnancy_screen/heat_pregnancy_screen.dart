import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/presentation/heat_pregnancy_screen/heat_pregnancy_controller.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';
import '../../core/utils/color_constant.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/dropdown/dropdown.dart';
import '../milk_screen/controller/milk_controller.dart';

class HeatPregnancy extends GetView<HeatPregnancyController> {
  const HeatPregnancy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MilkController milkController = Get.put(MilkController());

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIconOnTap: () {
            Get.back();
          },
          leadingIcon: const Icon(Icons.arrow_back, color: Colors.white),
          centerTitle: true,
          height: 60,
          title: "Heat Pregnancy",
          styleType: Style.bgFillBluegray900,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => CupertinoSegmentedControl(
                  padding: const EdgeInsets.all(10),
                  children: const {
                    0: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, right: 25, left: 25),
                      child: Text("Check Pregnancy"),
                    ),
                    1: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, right: 25, left: 25),
                      child: Text("Cow Period Time"),
                    ),
                  },
                  groupValue: controller.selectedSegment.value,
                  onValueChanged: (value) {
                    controller.selectedSegment.value = int.parse(value.toString());
                  },
                  borderColor: const Color(0xffb232b832),
                  selectedColor: const Color(0xffb232b832),
                  unselectedColor: CupertinoColors.white,
                ),
              ),
              Obx(
                () => controller.selectedSegment.value == 0
                    ? checkPregnancy(milkController)
                    : cowPeriodTime(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkPregnancy(MilkController milkController) {
    return Column(
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
        CustomTextFormField(
          globalKey: controller.LastPeriodTimeDateKey,
          controller: controller.LastPeriodTimeDateController,
          hintText: "Last Period Time Date",
          labelText: "Last Period Time Date ",
          textInputType: TextInputType.none,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter Last Period Time Date';
            }
            return null;
          },
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: controller.NextDateController,
                hintText: "Next Date",
                labelText: "Next Date",
                textInputType: TextInputType.none,
              ),
            ),
            Expanded(
              child: CustomTextFormField(
                controller: controller.RemainingDaysController,
                hintText: "Remaining Days",
                labelText: "Remaining Days",
                textInputType: TextInputType.none,
              ),
            ),
          ],
        ),
        CustomTextFormField(
          controller: controller.PrecautionDaysController,
          hintText: "Precaution Days",
          labelText: "Precaution Days",
          textInputType: TextInputType.none,
        ),
        CustomTextFormField(
          controller: controller.RemarkController,
          hintText: "Remark",
          labelText: "Remark",
        ),
        Padding(
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
      ],
    );
  }

  Widget cowPeriodTime(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Dropdown(
            selectedItem: controller.cowIdText,
            globalKey: controller.cowIdKey,
            text: 'cowId'.obs,
            list: const [],
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
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            children: [
              Text(
                'Select Period Time : ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.blueGray9007f,
                  fontSize: 17,
                ),
              ),
              const Spacer(),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    datePicker(context: context);
                  },
                  child: Text(
                    controller.selectFirstDateText.value.isEmpty
                        ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                        : controller.selectFirstDateText.value,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
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
            const Text('   Is Pregnant'),
          ],
        ),
        Padding(
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
      ],
    );
  }

  datePicker({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    controller.selectFirstDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    controller.selectFirstDateText.value = DateFormat('dd-MM-yyyy').format(pickedDate);
  }
}
