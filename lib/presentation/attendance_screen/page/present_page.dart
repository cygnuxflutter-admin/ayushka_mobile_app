import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cattle_app/presentation/attendance_screen/attendance_screen_controller.dart';

import '../../../widgets/custom_button.dart';
import '../widget/absent_view.dart';
import '../widget/male_female_count_view.dart';

class PresentPage extends GetView<AttendanceScreenController> {
  PresentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.presentEmployeeList.isEmpty) ...{
            const Center(
              child: Text("Data Not Found"),
            ),
          } else ...{
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  controller.presentSearchQuery.value = value;
                  if (value.isEmpty) {
                    controller.presentFilteredItemList('');
                  } else {
                    controller.presentFilteredItemList(value);
                  }
                },
                controller: controller.presentSearchController,
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
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(
                () {
                  final presentEmployeeList = controller
                      .presentFilteredItemList(controller.presentSearchQuery.value);
                  controller.PresentAbsentShot(presentEmployeeList);
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(thickness: 1,),
                        ),
                    itemCount: presentEmployeeList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          for (var employee in presentEmployeeList) {
                            if (presentEmployeeList[index].isSelect.value) {
                              continue;
                            }
                            employee.isSelect.value = false;
                          }
                          presentEmployeeList[index].isSelect.value =
                              !presentEmployeeList[index].isSelect.value;
                        },
                        child: AbsentPresentView(
                          index: index,
                          attendanceEmployeeList: presentEmployeeList,
                          isPresent: true,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff232f34),
                border: Border.all(color: const Color(0xff232f34), width: 2),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              ),
              child: Obx(() {
                final presentEmployeeList = controller.presentFilteredItemList(
                    controller.presentSearchQuery.value);
                return presentEmployeeList.isNotEmpty
                    ? Column(
                  children: [
                    MaleFemaleCountView(
                      countList: controller.presentEmployeeList,
                    ),
                    _Button(
                      context: context,
                      presentTap: () {
                        controller.searchController.text = '';
                        controller.UpdateAttendanceApi(
                          context: context,
                          attendanceType: 'HalfDay',
                          id: controller.findId() ?? '',
                        );
                      },
                      absentTap: () {
                        controller.searchController.text = '';
                        controller.UpdateAttendanceApi(
                          context: context,
                          attendanceType: 'Absent',
                          id: controller.findId() ?? '',
                        );
                      },
                    ),
                  ],
                ) : const SizedBox();
              }),
            )
          },
        ],
      ),
    );
  }

  Widget _Button({
    required BuildContext context,
    required VoidCallback presentTap,
    required VoidCallback absentTap,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton(
              text: "HALF DAY",
              shape: ButtonShape.Cove,
              height: 48,
              width: 150,
              variant: ButtonVariant.FillBluegray900,
              textStyle: const TextStyle(
                color: Colors.white,
              ),
              onTap: presentTap,
            ),
            CustomButton(
              text: "ABSENT",
              shape: ButtonShape.Cove,
              height: 48,
              width: 150,
              variant: ButtonVariant.FillRed600b2,
              textStyle: const TextStyle(
                color: Colors.white,
              ),
              onTap: absentTap,
            ),
          ],
        ),
      ),
    );
  }
}
