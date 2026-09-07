import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/image_constant.dart';
import '../../../theme/app_style.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/size.dart';
import '../attendance_screen_controller.dart';

class AllEmpHistory extends StatelessWidget {
  const AllEmpHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AttendanceScreenController attendanceScreenController =
        Get.find<AttendanceScreenController>();

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 10,
            backgroundColor: const Color(0xff232f34),
            title: const Text(
              'Employee History',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
                Get.back();
                Get.back();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.history,
                  color: Colors.white,
                ),
                onPressed: () {
                  attendanceScreenController.selectedHistoryDate.value =
                      attendanceScreenController.empHistoryDateController.text.isEmpty
                          ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                          : attendanceScreenController.empHistoryDateController.text;

                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => WillPopScope(
                      onWillPop: () async => false,
                      child: AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22.0)),
                        ),
                        elevation: 0,
                        content: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.black26,
                                radius: 15,
                                child: Icon(Icons.close,
                                    color: Colors.black, size: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 0, right: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Select Date : ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.blueGray9007f,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            datePicker(
                                                context: context,
                                                controller:
                                                    attendanceScreenController);
                                          },
                                          child: Obx(
                                            () => Text(
                                              attendanceScreenController
                                                  .selectedHistoryDate.value,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CustomButton(
                                      text: "Apply",
                                      width: 200,
                                      height: 55,
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                      variant: ButtonVariant.FillGreen600b2,
                                      onTap: () {
                                        attendanceScreenController
                                            .allEmpHistory(context: context);
                                        Get.back();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
            bottom: TabBar(
              unselectedLabelColor: Colors.white60,
              indicatorWeight: 5,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Present',
                  icon: Obx(() => Text(
                      "${attendanceScreenController.AllEmpPresentHistoryList.length}")),
                ),
                Tab(
                  text: 'Absent',
                  icon: Obx(() => Text(
                      "${attendanceScreenController.AllEmpAbsentHistoryList.length}")),
                ),
              ],
            ),
          ),
          body: Obx(() {
            switch (attendanceScreenController.allEmpHistoryStatus.value) {
              case AttendanceDataStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case AttendanceDataStatus.error:
                return const Center(child: Text("Data Not Found"));
              case AttendanceDataStatus.done:
                return TabBarView(
                  children: [
                    _PresentPage(attendanceScreenController),
                    _AbsentPage(attendanceScreenController),
                  ],
                );
            }
          }),
        ),
      ),
    );
  }

  void datePicker(
      {required BuildContext context,
      required AttendanceScreenController controller}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    String formatted = DateFormat('dd-MM-yyyy').format(pickedDate);
    controller.selectedHistoryDate.value = formatted;
    controller.empHistoryDateController.text = formatted;
  }

  Widget _PresentPage(AttendanceScreenController attendanceScreenController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          if (attendanceScreenController.AllEmpPresentHistoryList.isEmpty) {
            return const Center(
              child: Text("Data Not Found"),
            );
          }
          final EmpList = attendanceScreenController.AllEmpPresentHistoryList;
          return Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(thickness: 1),
              itemCount: EmpList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 20),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.green,
                              backgroundImage: AssetImage(
                                EmpList[index].gender == "FEMALE" ||
                                        EmpList[index].gender == "Female"
                                    ? ImageConstant.female
                                    : ImageConstant.male,
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.size(context).width * 0.45,
                            child: Text(
                              "${EmpList[index].empId} - ${EmpList[index].payrollName}",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtOutfitLight15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _AbsentPage(AttendanceScreenController attendanceScreenController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          if (attendanceScreenController.AllEmpAbsentHistoryList.isEmpty) {
            return const Center(
              child: Text("Data Not Found"),
            );
          }
          final EmpList = attendanceScreenController.AllEmpAbsentHistoryList;
          return Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(thickness: 1),
              itemCount: EmpList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 20),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.redAccent,
                              backgroundImage: AssetImage(
                                EmpList[index].gender == "FEMALE" ||
                                        EmpList[index].gender == "Female"
                                    ? ImageConstant.female
                                    : ImageConstant.male,
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.size(context).width * 0.45,
                            child: Text(
                              "${EmpList[index].empId} - ${EmpList[index].payrollName}",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtOutfitLight15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
