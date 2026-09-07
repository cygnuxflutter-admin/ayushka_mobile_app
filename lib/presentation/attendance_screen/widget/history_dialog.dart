import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/attendance_screen/attendance_screen_controller.dart';

class HistoryDialog extends GetView<AttendanceScreenController> {
  HistoryDialog({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController employeeController = TextEditingController(text: 'SSG');

  String? validateDateRange(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      return 'Please select both start and end dates.';
    }

    if (startDate.isAfter(endDate)) {
      return 'End Date cannot be earlier than Start Date.';
    }

    return null;
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: controller.historyStartDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedStartDate != null) {
      controller.historyStartDate.value = pickedStartDate;
      controller.historyErrorMessage.value =
          validateDateRange(pickedStartDate, controller.historyEndDate.value);
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedEndDate = await showDatePicker(
      context: context,
      initialDate: controller.historyEndDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedEndDate != null) {
      controller.historyEndDate.value = pickedEndDate;
      controller.historyErrorMessage.value =
          validateDateRange(controller.historyStartDate.value, pickedEndDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Attendance History'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text('Start Date:'),
              const Spacer(),
              Obx(
                () => OutlinedButton(
                  onPressed: () => _selectStartDate(context),
                  child: Text(
                    "${convertDateFormat(date: controller.historyStartDate.value.toLocal().toString())}"
                        .split(' ')[0],
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const Text('End Date:'),
              const Spacer(),
              Obx(
                () => OutlinedButton(
                  onPressed: () => _selectEndDate(context),
                  child: Text(
                    "${convertDateFormat(date: controller.historyEndDate.value.toLocal().toString())}"
                        .split(' ')[0],
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => controller.historyErrorMessage.value != null
                ? Text(
                    controller.historyErrorMessage.value!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  )
                : const SizedBox(),
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: employeeController,
              decoration: InputDecoration(
                labelText: 'Employee ID',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
              ),
              onChanged: (value) {
                controller.historyEmployeeId.value = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Employee ID cannot be empty';
                }
                return null;
              },
            ),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            employeeController.clear();
            Get.back();
          },
        ),
        TextButton(
          child: const Text(
            'Submit',
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            if (!(controller.historyStartDate.value
                .isAfter(controller.historyEndDate.value))) {
              if (_formKey.currentState!.validate()) {
                controller.attendanceHistory(
                    context: context,
                    empId: [controller.historyEmployeeId.value],
                    endDate: "${controller.historyEndDate.value}",
                    startDate: "${controller.historyStartDate.value}");
              }
            }
            employeeController.clear();
          },
        ),
      ],
    );
  }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("yyyy-MM-dd").parse(date);
    String formattedDate = DateFormat("dd-MM-yyyy").format(inputDate);
    return formattedDate;
  }
}
