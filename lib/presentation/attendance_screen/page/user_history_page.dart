import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/attendance_screen/attendance_screen_controller.dart';
import 'package:cattle_app/widgets/rich_text.dart';
import 'package:cattle_app/widgets/size.dart';

import '../models/attendance_histroy/attendane_history_response.dart';
import '../widget/history_dialog.dart';

enum AttendanceType {
  absent,
  present,
  halfDay,
  }

class UserHistory extends StatelessWidget {
  const UserHistory({
    Key? key,
    required this.attendanceHistoryListDup,
    required this.maxDay,
    required this.minDay,
  }) : super(key: key);

  final List<AttendanceHistoryList> attendanceHistoryListDup;
  final DateTime minDay;
  final DateTime maxDay;

  Widget _sfCalendar(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      headerHeight: AppSize.size(context).height * 0.07,
      viewHeaderStyle: const ViewHeaderStyle(
          backgroundColor: Color(0xff232f34),
          dayTextStyle: TextStyle(color: Colors.white,),
          dateTextStyle: TextStyle(color: Colors.white)),
      firstDayOfWeek: 1,
      controller: CalendarController(),
      dataSource: _getCalendarDataSource(attendanceHistoryListDup),
      todayHighlightColor: Colors.green,
      viewHeaderHeight: AppSize.size(context).height * 0.05,
      backgroundColor: Colors.white,
      cellBorderColor: const Color(0xff232f34),
      headerStyle: const CalendarHeaderStyle(
        textAlign: TextAlign.center,
      ),
      minDate: DateTime(2000, 1, 1),
      maxDate: maxDay,
    );
  }

  _DataSource _getCalendarDataSource(
      List<AttendanceHistoryList> attendanceHistoryList) {
    final appointments = <Appointment>[];
    for (var attendanceData in attendanceHistoryList) {
      Color eventColor = Colors.green;
      if (attendanceData.attendanceType == 'Absent') {
        eventColor = Colors.red;
      } else if (attendanceData.attendanceType == 'HalfDay') {
        eventColor = Colors.orange;
      } else if (attendanceData.attendanceType == 'Holiday') {
        eventColor = Colors.purple;
      }

      appointments.add(Appointment(
        startTime: DateTime.parse(attendanceData.date),
        endTime: DateTime.parse(attendanceData.date),
        subject: attendanceData.attendanceType,
        color: eventColor,
      ));
    }

    return _DataSource(appointments);
  }

  @override
  Widget build(BuildContext context) {
    final AttendanceScreenController attendanceScreenController =
        Get.find<AttendanceScreenController>();

    int presentCount = 0;
    int absentCount = 0;
    int halfDayCount = 0;
    int holidayDayCount = 0;
    for (final item in attendanceHistoryListDup) {
      final attendanceType = item.attendanceType;
      if (attendanceType == 'Present') {
        presentCount++;
      } else if (attendanceType == 'Absent') {
        absentCount++;
      } else if (attendanceType == 'HalfDay') {
        halfDayCount++;
      } else if (attendanceType == 'Holiday') {
        holidayDayCount++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff232f34),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white),
        title: const Text(
          'Employee Calendar',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white,),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return HistoryDialog();
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: AppSize.size(context).height * 0.55,
              child: _sfCalendar(context),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                child: CattleRichText(
                  text: attendanceHistoryListDup.isEmpty ? "" : attendanceHistoryListDup.first.empId,
                  richText: attendanceHistoryListDup.isEmpty ? "" : " - ${attendanceHistoryListDup.first.payrollName}",
                  fontSize: 18,
                  fontSize1: 18,
                  fontWeight1: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 70,
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  String title = '';
                  int count = 0;
                  Color color = Colors.transparent;
                  Color lightColor = Colors.transparent;
                  switch (index) {
                    case 0:
                      title = 'Present';
                      count = presentCount;
                      color = Colors.green.shade600;
                      lightColor = Colors.lightGreen;
                      break;
                    case 1:
                      title = 'Absent';
                      count = absentCount;
                      color = Colors.red.shade600;
                      lightColor = Colors.redAccent;
                      break;
                    case 2:
                      title = 'Half Day';
                      count = halfDayCount;
                      color = Colors.orange.shade600;
                      lightColor = Colors.orangeAccent;
                      break;
                    case 3:
                      title = 'Holiday Day';
                      count = holidayDayCount;
                      color = Colors.purple.shade600;
                      lightColor = Colors.purpleAccent;
                      break;
                  }
                  return AttendanceCountTile(
                    title: title,
                    count: count,
                    colors: color,
                    lightColor: lightColor,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}

class AttendanceCountTile extends StatelessWidget {
  final String title;
  final int count;
  final Color colors;
  final Color lightColor;

  const AttendanceCountTile({
    Key? key,
    required this.title,
    required this.count,
    required this.colors,
    required this.lightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: AppSize.size(context).width * 0.12,
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "$count",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: AppSize.size(context).width * 0.05,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
