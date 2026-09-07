import 'package:cattle_app/presentation/report_screen/guashala_report_controller.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GuashalaReportScreenController reportScreenController =
        Get.put(GuashalaReportScreenController());

    void showYearPickerDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return YearPickerDialog(
            initialYear: DateTime.now().year,
            firstYear: 2022,
            lastYear: DateTime.now().year + 1,
            onYearSelected: (year) {
              reportScreenController.selectedYear.value = year;
            },
          );
        },
      );
    }

    void showMonthPickerDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MonthPickerDialog(
            onMonthSelected: (month) {
              reportScreenController.selectedMonth.value = month;
            },
          );
        },
      );
    }

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
        title:
            "${reportScreenController.Report.value == 1 ? "Expanse" : reportScreenController.Report.value == 2 ? "ProfitLoss" : "Sales"} Report Screen",
        styleType: Style.bgFillBluegray900,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select year :',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: showYearPickerDialog,
                      child: Obx(
                        () => Text(
                          reportScreenController.selectedYear.value.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Month :',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: showMonthPickerDialog,
                      child: Obx(
                        () => Text(
                          reportScreenController.selectedMonth.value.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Email ID',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => WillPopScope(
                            onWillPop: () async => false,
                            child: AlertDialog(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22.0)),
                              ),
                              elevation: 0,
                              content: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Stack(
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
                                      padding: const EdgeInsets.only(top: 20),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomTextField(
                                              image:
                                                  'assets/images/email.png',
                                              height: 40,
                                              globalKey: reportScreenController
                                                  .emailIDKey,
                                              controller: reportScreenController
                                                  .emailIDController,
                                              hintText: "Email ID",
                                              labelText: "Email ID",
                                              textInputType: TextInputType.emailAddress,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please Enter Email ID';
                                                }
                                                return null;
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: CustomButton(
                                                  text: "Add",
                                                  width: 200,
                                                  height: 55,
                                                  textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                  variant: ButtonVariant
                                                      .FillGreen600b2,
                                                  onTap: () {
                                                    reportScreenController
                                                        .emailList
                                                        .add(reportScreenController
                                                            .emailIDController
                                                            .text);
                                                    Get.back();
                                                    reportScreenController
                                                        .emailIDController
                                                        .clear();
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorConstant.blueGray9007f, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/images/add.png',
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Obx(
                    () => ListView.builder(
                      itemCount: reportScreenController.emailList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              reportScreenController.emailList[index].toString().length <= 25
                                  ? reportScreenController.emailList[index].toString()
                                  : "${reportScreenController.emailList[index].toString().substring(0, 25)}...",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                reportScreenController.emailList
                                    .removeAt(index);
                              },
                              child: Image.asset(
                                'assets/images/remove.png',
                                height: 8,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: CustomButton(
          text: "Send Report",
          width: 200,
          height: 55,
          textStyle: const TextStyle(color: Colors.white, fontSize: 20),
          variant: ButtonVariant.FillGreen600b2,
          onTap: () {
            reportScreenController.SendReport();
          },
        ),
      ),
    );
  }
}

class YearPickerDialog extends StatelessWidget {
  final int initialYear;
  final int firstYear;
  final int lastYear;
  final ValueChanged<int> onYearSelected;

  const YearPickerDialog({
    Key? key,
    required this.initialYear,
    required this.firstYear,
    required this.lastYear,
    required this.onYearSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            title: const Text('Pick a Year'),
            automaticallyImplyLeading: false,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lastYear - firstYear + 1,
              itemBuilder: (context, index) {
                int year = firstYear + index;
                return ListTile(
                  title: Text(year.toString()),
                  onTap: () {
                    onYearSelected(year);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MonthPickerDialog extends StatelessWidget {
  final ValueChanged<int> onMonthSelected;

  MonthPickerDialog({Key? key, required this.onMonthSelected}) : super(key: key);

  final List<String> months = const [
    "01", "02", "03", "04", "05", "06",
    "07", "08", "09", "10", "11", "12"
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            title: const Text('Pick a Month'),
            automaticallyImplyLeading: false,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: months.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(months[index]),
                  onTap: () {
                    onMonthSelected(index + 1);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}