import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cattle_app/presentation/attendance_screen/widget/employeeList.dart';
import 'package:cattle_app/widgets/custom_button.dart';
import '../attendance_screen_controller.dart';
import '../models/attend_employee_list/AttendEmployeeList.dart';

class AllDetailsPage extends StatelessWidget {
  AllDetailsPage({key, required this.employeeList});

  final RxList<EmployeeDetailsList> employeeList;
  final attendanceScreenController = Get.put(AttendanceScreenController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (attendanceScreenController.employeeList.isNotEmpty) ...{
              Expanded(
                child: EmployeeList(
                  employeeList: employeeList,
                ),
              ),
              _Button(
                context: context,
                presentTap: () {
                  attendanceScreenController.searchController.text = '';
                  attendanceScreenController.attendanceSubmitApi(
                    context: context,
                    attendanceType: 'Present',
                  );
                },
                absentTap: () {
                  attendanceScreenController.searchController.text = '';
                  attendanceScreenController.attendanceSubmitApi(
                    context: context,
                    attendanceType: 'Absent',
                  );
                },
              ),
            } else ...{
              Center(
                child: Image(
                  image: AssetImage('assets/images/done.gif'),
                  width: 100,
                  height: 100,
                ),
              ),
            },
          ],
        ),
      ),
    );
  }

  _Button({
    required BuildContext context,
    required VoidCallback presentTap,
    required VoidCallback absentTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
            text: "PRESENT",
            shape: ButtonShape.Cove,
            height: 48,
            width: 150,
            variant: ButtonVariant.FillGreen600b2,
            textStyle: TextStyle(
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
            textStyle: TextStyle(
              color: Colors.white,
            ),
            onTap: absentTap,
          ),
        ],
      ),
    );
  }
}
