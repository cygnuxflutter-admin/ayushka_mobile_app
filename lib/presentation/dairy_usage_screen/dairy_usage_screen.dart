import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/dairy_usage_screen/controller/dairy_usage_controller.dart';
import 'package:cattle_app/presentation/dairy_usage_screen/historyWidget/historyWidget.dart';
import 'package:cattle_app/widgets/custom_button.dart';
import 'package:cattle_app/widgets/custom_text_form_field.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/dropdown/dropdown.dart';
import '../common file/defaultVariablesList.dart';

class DairyUsageScreen extends GetView<DairyUsageController> {
  const DairyUsageScreen({Key? key}) : super(key: key);

  bool isNumeric(String input) {
    final RegExp numericRegExp = RegExp(r'^\d*\.?\d*$');
    return numericRegExp.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIconOnTap: () {
            Get.back();
          },
          leadingIcon: const Icon(Icons.arrow_back, color: Colors.white),
          centerTitle: true,
          height: 60,
          title: "DAIRY USAGE",
          styleType: Style.bgFillBluegray900,
          actions: [
            IconButton(
              onPressed: () {
                controller.milkUsageDay.value = true;
                controller.DairyUsageHistory();
              },
              icon: const Icon(Icons.history, color: Colors.white),
            ),
          ],
        ),
        body: Obx(() {
          switch (controller.dataStatus.value) {
            case DataStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case DataStatus.error:
              return const Center(child: Text("NO HISTORY FOUND"));
            case DataStatus.done:
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Obx(
                          () => Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      decoration: BoxDecoration(color: const Color(0xff92C7CF).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          const Text("Morning Milk", style: TextStyle(fontSize: 12, color: Colors.black)),
                                          Text(
                                            "${controller.morningMilk.value} LT",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      decoration: BoxDecoration(color: const Color(0xff92C7CF).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          const Text("Morning Used Milk", style: TextStyle(fontSize: 12, color: Colors.black)),
                                          Text(
                                            "${controller.morningMilkUsage.value} LT",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      decoration: BoxDecoration(color: const Color(0xffBEADFA).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          const Text("Evening Milk", style: TextStyle(fontSize: 12, color: Colors.black)),
                                          Text(
                                            "${controller.eveningMilk.value} LT",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      decoration: BoxDecoration(color: const Color(0xffBEADFA).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          const Text("Evening Used Milk", style: TextStyle(fontSize: 12, color: Colors.black)),
                                          Text(
                                            "${controller.eveningMilkUsage.value} LT",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      decoration: BoxDecoration(color: const Color(0xffF2C18D).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          const Text("Total Milk", style: TextStyle(fontSize: 12, color: Colors.black)),
                                          Text(
                                            "${controller.dashboardController.todaysMilk.value} LT",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      decoration: BoxDecoration(color: const Color(0xffF2C18D).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          const Text("Total Used Milk", style: TextStyle(fontSize: 12, color: Colors.black)),
                                          Text(
                                            "${controller.dashboardController.todayMilkUsage.value} LT",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey.shade200),
                      CustomTextField(
                        image: 'assets/images/milkLiter.png',
                        height: 30,
                        globalKey: controller.literKey,
                        controller: controller.literController,
                        hintText: "LITER",
                        labelText: "LITER",
                        textInputType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))],
                        onChanged: (value) {
                          double RestMilk =
                              double.parse(controller.dashboardController.todaysMilk.value) -
                              double.parse(controller.dashboardController.todayMilkUsage.value);

                          if (RestMilk < double.parse(value)) {
                            controller.literController.text = RestMilk.toString();
                          }

                          if (!isNumeric(value)) {
                            controller.literController.clear();
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Liter ';
                          }
                          return null;
                        },
                      ),
                      Obx(
                        () => Column(
                          children: [
                            CustomDropdown(
                              image: 'assets/images/remarkIcon.png',
                              height: 30,
                              globalKey: controller.dayTimeKey,
                              text: 'DAY TIME  '.obs,
                              list: ['Morning', 'Evening'],
                              onChanged: (value) {
                                controller.dayTimeController.text = value.toString();
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please Select DAY TIME ';
                                }
                                return null;
                              },
                            ),
                            CustomDropdown(
                              image: 'assets/images/useIn.png',
                              height: 30,
                              globalKey: controller.usedInKey,
                              text: 'USED IN  '.obs,
                              list: dairyItems.map((data) => data.value).toList(),
                              onChanged: (value) {
                                controller.usedInController.text = value.toString();
                                controller.isDistribution(controller.usedInController.text);
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please Enter USED IN ';
                                }
                                return null;
                              },
                            ),
                            controller.distribution == true
                                ? Dropdown(
                                    globalKey: controller.distributionKey,
                                    text: 'Distribution Person  '.obs,
                                    list: distributionFreePerson.map((data) => data.value).toList(),
                                    onChanged: (value) {
                                      controller.distributionController.text = value.toString();
                                    },
                                    validator: (value) {
                                      if (controller.distribution == true) {
                                        if (value == null) {
                                          return 'Please Enter Distribution Person   ';
                                        }
                                      }
                                      return null;
                                    },
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      CustomTextField(
                        image: 'assets/images/remarkIcon.png',
                        height: 30,
                        controller: controller.descriptionController,
                        hintText: "DESCRIPTION",
                        labelText: "DESCRIPTION",
                      ),
                      const SizedBox(height: 20),
                      HistoryWidget(),
                    ],
                  ),
                ),
              );
          }
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
          child: CustomButton(
            text: "SUBMIT",
            width: 200,
            height: 55,
            textStyle: const TextStyle(color: Colors.white, fontSize: 20),
            variant: ButtonVariant.FillBluegray900,
            onTap: () {
              bool isDayTimeValid = controller.dayTimeKey.currentState!.validate();
              bool isLiterValid = controller.literKey.currentState!.validate();
              bool isUsedInValid = controller.usedInKey.currentState!.validate();
              
              if (isDayTimeValid && isLiterValid && isUsedInValid) {
                if (controller.distribution == true) {
                  bool isDistributionValid = controller.distributionKey.currentState!.validate();
                  if (isDistributionValid) {
                    FocusScope.of(context).unfocus();
                    controller.dataStatus.value = DataStatus.loading;
                    controller.cmDairyUsageEntry(context);
                    controller.cmTodayMilkUsageApi();
                  }
                } else {
                  FocusScope.of(context).unfocus();
                  controller.dataStatus.value = DataStatus.loading;
                  controller.cmDairyUsageEntry(context);
                  controller.cmTodayMilkUsageApi();
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
