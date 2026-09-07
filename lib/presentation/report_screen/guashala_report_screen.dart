import 'package:cattle_app/presentation/report_screen/guashala_report_controller.dart';
import 'package:cattle_app/presentation/report_screen/report_screen.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuashalaReportScreen extends GetView<GuashalaReportScreenController> {
  const GuashalaReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        title: "Report Screen",
        styleType: Style.bgFillBluegray900,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    controller.Report.value = 1;
                    Get.to(() => const ReportScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(child: Text('Expense Report', style: TextStyle(fontSize: 20))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    controller.Report.value = 2;
                    Get.to(() => const ReportScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(child: Text('ProfitLoss Report', style: TextStyle(fontSize: 20))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    controller.Report.value = 3;
                    Get.to(() => const ReportScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(child: Text('Sales Report', style: TextStyle(fontSize: 20))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
