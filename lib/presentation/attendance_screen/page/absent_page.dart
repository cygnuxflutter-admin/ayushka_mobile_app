import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../attendance_screen_controller.dart';
import '../widget/absent_view.dart';
import '../widget/male_female_count_view.dart';

class AbsentPage extends GetView<AttendanceScreenController> {
  AbsentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.absentEmployeeList.isEmpty) ...{
            const Center(
              child: Text("Data Not Found"),
            ),
          } else ...{
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  controller.absentSearchQuery.value = value;
                  if (value.isEmpty) {
                    controller.absentFilteredItemList('');
                  } else {
                    controller.absentFilteredItemList(value);
                  }
                },
                controller: controller.absentSearchController,
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
                  final absentEmployeeList = controller.absentFilteredItemList(
                      controller.absentSearchQuery.value);
                  controller.PresentAbsentShot(absentEmployeeList);
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(thickness: 1,),
                        ),
                    itemCount: absentEmployeeList.length,
                    itemBuilder: (context, index) {
                      return AbsentPresentView(
                        index: index,
                        attendanceEmployeeList: absentEmployeeList,
                        isPresent: false,
                      );
                    },
                  );
                },
              ),
            ),
            Obx(() {
              final absentEmployeeList = controller.absentFilteredItemList(
                  controller.absentSearchQuery.value);
              return absentEmployeeList.isNotEmpty
                  ? MaleFemaleCountView(countList: controller.absentEmployeeList,)
                  : const SizedBox();
            }),
          },
        ],
      ),
    );
  }
}
