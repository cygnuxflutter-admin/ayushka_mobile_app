import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';

import '../../../widgets/loder.dart';
import '../hr_screen_controller.dart';
import '../models/employeeListResponse.dart';

class EmployList extends StatelessWidget {
  const EmployList({
    Key? key,
    required this.employList,
    required this.hrScreenController,
  }) : super(key: key);

  final RxList<Employee> employList;
  final HrScreenController hrScreenController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(left: 22, top: 0, right: 11),
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(thickness: 1),
                itemCount: employList.length,
                itemBuilder: (context, index) {
                  // Create a sorted copy of the list to avoid mutating the RxList during build
                  final List<Employee> sortedList = List<Employee>.from(employList);
                  sortedList.sort((a, b) {
                    final idA = a.empId;
                    final idB = b.empId;
                    final intA = idA;
                    final intB = idB;
                    if (intA != double.infinity && intB != double.infinity) {
                      return intA.compareTo(intB);
                    } else if (intA == double.infinity && intB == double.infinity) {
                      return idA.compareTo(idB);
                    } else {
                      return intA == double.infinity ? 1 : -1;
                    }
                  });
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.employeeDetailScreen,
                        arguments: sortedList[index].id,
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          height: 43,
                          width: 43,
                          decoration: BoxDecoration(
                              color: const Color(0xff232F34),
                              borderRadius: BorderRadius.circular(20)),
                          child: CustomImageView(
                            imagePath: ImageConstant.male,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${employList[index].empId}",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              "${employList[index].payrollName.length <= 15 ? employList[index].payrollName : employList[index].payrollName.substring(0, 15) + "..."}",
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
                        const Spacer(),
                        Transform.scale(
                          scale: 0.9,
                          child: Switch(
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: const Color(0xffDBDBDB),
                            activeColor: Colors.white,
                            activeTrackColor: const Color(0xff119516),
                            value: employList[index].isActive,
                            onChanged: (bool newValue) {
                              _showConfirmationDialog(context, index, newValue);
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, int index, bool newValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            newValue ? 'Activate Employee' : 'Deactivate Employee',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black87.withOpacity(0.7),
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            newValue
                ? 'Are you sure you want to activate this employee?'
                : 'Are you sure you want to deactivate this employee?',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    employList[index].isActive = newValue;
                    employList.refresh();
                    Get.back();
                    AppLoader().show();
                    await hrScreenController.employeePartialUpdateApi(
                      context: context,
                      isActive: newValue,
                      id: employList[index].id,
                    );
                    AppLoader().hide();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 11, bottom: 11),
                    decoration: BoxDecoration(
                        color: const Color(0xff119516),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
