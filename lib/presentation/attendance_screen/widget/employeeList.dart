import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/attendance_screen/attendance_screen_controller.dart';
import 'package:cattle_app/presentation/attendance_screen/models/attend_employee_list/AttendEmployeeList.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({Key? key, required this.employeeList}) : super(key: key);

  final RxList<EmployeeDetailsList> employeeList;

  void toggleAllPresentAbsent(AttendanceScreenController controller) {
    bool allSelected = true;
    for (var employee in controller.employeeList) {
      if (!employee.isPresentAbsent.value) {
        allSelected = false;
        break;
      }
    }

    for (var employee in controller.employeeList) {
      employee.isPresentAbsent.value = !allSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AttendanceScreenController attendanceScreenController =
        Get.find<AttendanceScreenController>();

    return Container(
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: TextField(
                onChanged: (value) {
                  attendanceScreenController.mainSearchQuery.value = value;
                  attendanceScreenController.updateFilteredItemList(value);
                },
                controller: attendanceScreenController.searchController,
                decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Color(0xff232f34),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 15),
              child: Row(
                children: [
                  Obx(
                    () => Checkbox(
                      activeColor: const Color(0xff232f34),
                      value: attendanceScreenController.SelectAll.value,
                      onChanged: (bool? newValue) {
                        toggleAllPresentAbsent(attendanceScreenController);
                        attendanceScreenController.SelectAll.value = newValue!;
                      },
                    ),
                  ),
                  Text(
                    'Name',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtOutfitLight15,
                  ),
                  const Spacer(),
                  Text(
                    'Full day',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtOutfitLight15,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xff232f34),
            ),
            Obx(
              () {
                List<EmployeeDetailsList> filteredList =
                    attendanceScreenController.updateFilteredItemList(
                  attendanceScreenController.mainSearchQuery.value,
                );
                filteredList.sort((a, b) {
                  final codeA = a.empId;
                  final codeB = b.empId;

                  final numericPartA = int.tryParse(codeA.substring(1));
                  final numericPartB = int.tryParse(codeB.substring(1));

                  if (numericPartA != null && numericPartB != null) {
                    if (numericPartA != numericPartB) {
                      return numericPartA.compareTo(numericPartB);
                    }
                  } else if (numericPartA != null) {
                    return -1;
                  } else if (numericPartB != null) {
                    return 1;
                  }
                  return codeA.compareTo(codeB);
                });

                if (filteredList.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        "Data Not Found",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtOutfitLight15,
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(thickness: 1),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return _allDetailsView(
                        index: index,
                        employeeList: filteredList,
                        onTap: () {
                          for (var item in employeeList) {
                            if (item.empId == filteredList[index].empId) {
                              if (item.isPresentAbsent.value == false) {
                                item.isPresentAbsent.value = true;
                                print('0');
                              } else {
                                item.isPresentAbsent.value = false;
                              }
                            }
                          }
                        },
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _allDetailsView({
    required int index,
    required List<EmployeeDetailsList> employeeList,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            Obx(
              () => Checkbox(
                activeColor: const Color(0xff232f34),
                value: employeeList[index].isPresentAbsent.value,
                onChanged: (bool? newValue) {
                  employeeList[index].isPresentAbsent.value = newValue!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${employeeList[index].empId}",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: getFontSize(18),
                      fontFamily: 'Outfit',
                    ),
                  ),
                  Text(
                    "${employeeList[index].payrollName.length <= 15 ? employeeList[index].payrollName : employeeList[index].payrollName.substring(0, 15) + "..."}",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Obx(
              () => Transform.scale(
                scale: 0.9,
                child: Switch(
                  activeColor: const Color(0xff232f34),
                  activeTrackColor: const Color(0xff80909a),
                  value: employeeList[index].isFullDay.value,
                  onChanged: (bool newValue) {
                    print(newValue);
                    employeeList[index].isFullDay.value = newValue;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
