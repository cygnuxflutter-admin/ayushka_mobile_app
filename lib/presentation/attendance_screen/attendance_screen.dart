import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/presentation/attendance_screen/page/absent_page.dart';
import 'package:cattle_app/presentation/attendance_screen/page/all_details_page.dart';
import 'package:cattle_app/presentation/attendance_screen/page/present_page.dart';
import 'package:cattle_app/presentation/attendance_screen/widget/history_dialog.dart';

import '../../core/utils/color_constant.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import 'attendance_screen_controller.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AttendanceScreenController attendanceScreenController = Get.put(AttendanceScreenController());

    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: () async {
          Get.back();
          attendanceScreenController.attendanceDataStatus.value =
              AttendanceDataStatus.loading;
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 10,
            backgroundColor: const Color(0xff232f34),
            title: const Text(
              'Attendance',
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
                attendanceScreenController.attendanceDataStatus.value =
                    AttendanceDataStatus.loading;
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.addEmployeeScreen,
                      arguments: "All",
                    );
                  },
                  child: const Image(
                    image: AssetImage(
                      'assets/images/add-user-3-512.png',
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.history,
                  color: Colors.white,
                ),
                onPressed: () {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (_) => WillPopScope(
                                              onWillPop: () async => false,
                                              child: AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              22.0)),
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
                                                        backgroundColor:
                                                            Colors.black26,
                                                        radius: 15,
                                                        child: Icon(Icons.close,
                                                            color: Colors.black,
                                                            size: 20),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 30),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10,
                                                                    left: 0,
                                                                    right: 10),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'Select Date : ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: ColorConstant
                                                                        .blueGray9007f,
                                                                    fontSize:
                                                                        17,
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    datePicker(
                                                                        context: context,
                                                                        attendanceScreenController: attendanceScreenController);
                                                                  },
                                                                  child: Obx(() => Text(
                                                                    attendanceScreenController.selectedHistoryDate.value.isEmpty
                                                                        ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                                                                        : attendanceScreenController.selectedHistoryDate.value,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            20),
                                                                  )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child: CustomButton(
                                                              text: "Apply",
                                                              width: 200,
                                                              height: 55,
                                                              textStyle: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                              variant: ButtonVariant
                                                                  .FillGreen600b2,
                                                              onTap: () {
                                                                attendanceScreenController
                                                                    .allEmpHistory(
                                                                        context:
                                                                            context);
                                                                Get.toNamed(
                                                                    AppRoutes
                                                                        .allEmpHistory);
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
                                        child: const Text(
                                          "All Employee History",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff232f34)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return HistoryDialog();
                                            },
                                          );
                                        },
                                        child: const Text(
                                          "Employee Wise History",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff232f34)),
                                        )),
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
                    text: 'Pending',
                    icon: Obx(() => Text(
                        "${attendanceScreenController.employeeList.length}"))),
                Tab(
                    text: 'Present',
                    icon: Obx(() => Text(
                        "${attendanceScreenController.presentEmployeeList.length}"))),
                Tab(
                    text: 'Absent',
                    icon: Obx(() => Text(
                        "${attendanceScreenController.absentEmployeeList.length}"))),
              ],
            ),
          ),
          body: Obx(() {
            switch (attendanceScreenController.attendanceDataStatus.value) {
              case AttendanceDataStatus.loading:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [Center(child: CircularProgressIndicator())],
                );
              case AttendanceDataStatus.error:
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Center(child: Text("ERROR"))]);
              case AttendanceDataStatus.done:
                return TabBarView(
                  children: [
                    AllDetailsPage(
                      employeeList: attendanceScreenController.employeeList,
                    ),
                    PresentPage(),
                    AbsentPage(),
                  ],
                );
            }
          }),
        ),
      ),
    );
  }

  datePicker({required BuildContext context, required AttendanceScreenController attendanceScreenController}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    attendanceScreenController.selectedHistoryDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
    attendanceScreenController.empHistoryDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }
}
