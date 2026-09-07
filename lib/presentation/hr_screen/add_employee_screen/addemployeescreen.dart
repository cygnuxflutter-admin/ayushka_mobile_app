import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/hr_screen/add_employee_screen/addemployeescreencontroller.dart';
import 'package:cattle_app/widgets/custom_text_form_field.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/dropdown/dropdown.dart';
import '../../common file/defaultVariablesList.dart';

class AddEmployeeScreen extends GetView<AddEmployeeScreenController> {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Entry = Get.arguments;
    return SafeArea(
      child: Obx(
        () {
          switch (controller.dataStatus.value) {
            case DataStatus.loading:
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Center(child: CircularProgressIndicator())],
              );
            case DataStatus.error:
              return const Column(children: [Center(child: Text("ERROR"))]);
            case DataStatus.done:
              return Scaffold(
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
                  title: Entry == "All"
                      ? "ADD EMPLOYEE"
                      : Entry == "PERSONAL"
                          ? "PERSONAL DETAIL"
                          : Entry == "BANK"
                              ? "BANK DETAIL"
                              : Entry == "SALARY"
                                  ? "SALARY DETAIL"
                                  : Entry == "OTHER"
                                      ? "OTHER DETAIL"
                                      : "",
                  styleType: Style.bgFillBluegray900,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        (Entry == "PERSONAL" || Entry == "All")
                            ? Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8, left: 12),
                                        child: Text(
                                          "PERSONAL DETAIL",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      CustomTextFormField(
                                        labelText: "Name",
                                        controller: controller
                                            .payrollNameController,
                                      ),
                                      Entry == "All"
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12),
                                              child: Row(
                                                children: [
                                                  const Text('Employ Type'),
                                                  Obx(
                                                    () => Checkbox(
                                                      activeColor:
                                                          const Color(0xff232f34),
                                                      shape: const CircleBorder(),
                                                      value: controller
                                                          .isTemporary.value,
                                                      onChanged:
                                                          (bool? newValue) {
                                                        controller
                                                            .isTemporary
                                                            .value = newValue!;
                                                        controller
                                                            .isPermanent
                                                            .value = false;
                                                      },
                                                    ),
                                                  ),
                                                  const Text('Temporary'),
                                                  Obx(
                                                    () => Checkbox(
                                                      activeColor:
                                                          const Color(0xff232f34),
                                                      shape: const CircleBorder(),
                                                      value: controller
                                                          .isPermanent.value,
                                                      onChanged:
                                                          (bool? newValue) {
                                                        controller
                                                            .isPermanent
                                                            .value = newValue!;
                                                        controller
                                                            .isTemporary
                                                            .value = false;
                                                      },
                                                    ),
                                                  ),
                                                  const Text('Permanent'),
                                                ],
                                              ),
                                            )
                                          : const SizedBox(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: [
                                            const Text('Gender'),
                                            Obx(
                                              () => Checkbox(
                                                activeColor: const Color(0xff232f34),
                                                shape: const CircleBorder(),
                                                value: controller
                                                            .genderController
                                                            .text ==
                                                        'MALE'
                                                    ? true
                                                    : controller
                                                        .isMale.value,
                                                onChanged: (bool? newValue) {
                                                  controller
                                                      .isMale.value = newValue!;
                                                  controller
                                                      .isFemale.value = false;
                                                  controller
                                                      .genderController
                                                      .text = 'MALE';
                                                },
                                              ),
                                            ),
                                            const Text('Male'),
                                            Obx(
                                              () => Checkbox(
                                                activeColor: const Color(0xff232f34),
                                                shape: const CircleBorder(),
                                                value: controller
                                                            .genderController
                                                            .text ==
                                                        'FEMALE'
                                                    ? true
                                                    : controller
                                                        .isFemale.value,
                                                onChanged: (bool? newValue) {
                                                  controller.isFemale
                                                      .value = newValue!;
                                                  controller
                                                      .isMale.value = false;
                                                  controller
                                                      .genderController
                                                      .text = 'FEMALE';
                                                },
                                              ),
                                            ),
                                            const Text('Female'),
                                          ],
                                        ),
                                      ),
                                      Obx(
                                        () => controller
                                                .isTemporary.isTrue
                                            ? CustomTextFormField(
                                                labelText: "emp ID",
                                                controller:
                                                    controller
                                                        .empIdController,
                                              )
                                            : const SizedBox(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Date of Birth : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    ColorConstant.blueGray9007f,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                dobDatePicker(
                                                    context: context);
                                              },
                                              child: Obx(
                                                () => Text(
                                                  controller.dobText.value.isEmpty
                                                      ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                                                      : controller.dobText.value,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      CustomTextFormField(
                                        labelText: "Parent Name",
                                        controller: controller
                                            .parentSpouseNameController,
                                      ),
                                      CustomTextFormField(
                                        labelText: "RelationShip",
                                        controller: controller
                                            .relationshipController,
                                      ),
                                      CustomTextFormField(
                                        labelText: "mobile No.",
                                        controller: controller
                                            .mobileNoController,
                                        textInputType: TextInputType.phone,
                                      ),
                                      CustomTextFormField(
                                        labelText: "Aadhaar No",
                                        controller: controller
                                            .aadhaarNumberController,
                                        textInputType:
                                            const TextInputType.numberWithOptions(
                                                decimal: true),
                                      ),
                                      CustomTextFormField(
                                        labelText: "Aadhaar Name",
                                        controller: controller
                                            .aadhaarNameController,
                                      ),
                                      CustomTextFormField(
                                        labelText: "Pan No",
                                        controller: controller
                                            .panCardController,
                                      ),
                                      Obx(
                                        () => Dropdown(
                                          text: controller
                                                  .employeeCategoryController
                                                  .text
                                                  .isEmpty
                                              ? 'Employee Category'.obs
                                              : "${controller.employeeCategoryController.text}"
                                                  .obs,
                                          list: employeeCategory
                                              .map((element) => element.value)
                                              .toList(),
                                          showSearchBox: true,
                                          onChanged: (value) async {
                                            controller
                                                .employeeCategoryController
                                                .text = value.toString();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 10),
                        (Entry == "BANK" || Entry == "All")
                            ? Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8, left: 12),
                                        child: Text(
                                          "BANK DETAIL",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      CustomTextFormField(
                                        labelText: "Bank Account No",
                                        controller: controller
                                            .bankAccountController,
                                        textInputType:
                                            const TextInputType.numberWithOptions(
                                                decimal: true),
                                      ),
                                      CustomTextFormField(
                                        labelText: "Bank Name",
                                        controller: controller
                                            .bankNameController,
                                      ),
                                      CustomTextFormField(
                                        labelText: "IFSC Code",
                                        controller: controller
                                            .ifscCodeController,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 10),
                        (Entry == "SALARY" || Entry == "All")
                            ? Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8, left: 12),
                                        child: Text(
                                          "SALARY DETAIL",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Date of Salary : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    ColorConstant.blueGray9007f,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                salaryDatePicker(
                                                    context: context);
                                              },
                                              child: Obx(
                                                () => Text(
                                                  controller.salaryDateText.value.isEmpty
                                                      ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                                                      : controller.salaryDateText.value,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      CustomTextFormField(
                                        labelText: "Salary Amount",
                                        controller: controller
                                            .salaryAmountController,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 10),
                        (Entry == "OTHER" || Entry == "All")
                            ? Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8, left: 12),
                                        child: Text(
                                          "OTHER DETAIL",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Joining Date : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    ColorConstant.blueGray9007f,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                joiningDatePicker(
                                                    context: context);
                                              },
                                              child: Obx(
                                                () => Text(
                                                  controller.joiningDateText.value.isEmpty
                                                      ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                                                      : controller.joiningDateText.value,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      CustomTextFormField(
                                        labelText: "UAN No",
                                        controller: controller
                                            .uanNoController,
                                        textInputType:
                                            const TextInputType.numberWithOptions(
                                                decimal: true),
                                      ),
                                      CustomTextFormField(
                                        labelText: "PF No",
                                        controller: controller
                                            .pfNoController,
                                      ),
                                      CustomTextFormField(
                                        labelText: "ESI No",
                                        controller: controller
                                            .esiNoController,
                                        textInputType:
                                            const TextInputType.numberWithOptions(
                                                decimal: true),
                                      ),
                                      CustomTextFormField(
                                        labelText: "Remark",
                                        controller: controller
                                            .remarkController,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            text: "SUBMIT",
                            height: 55,
                            variant: ButtonVariant.FillBluegray900,
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            onTap: () {
                              controller.editPart(argument: Entry);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }

  void joiningDatePicker({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(1900),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    String formatted = DateFormat('dd-MM-yyyy').format(pickedDate);
    controller.joiningDateText.value = formatted;
    controller.joiningDateController.text = formatted;
  }

  void dobDatePicker({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(1900),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    String formatted = DateFormat('dd-MM-yyyy').format(pickedDate);
    controller.dobText.value = formatted;
    controller.dobController.text = formatted;
  }

  void salaryDatePicker({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(1900),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    String formatted = DateFormat('dd-MM-yyyy').format(pickedDate);
    controller.salaryDateText.value = formatted;
    controller.salaryDateController.text = formatted;
  }
}
