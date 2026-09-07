import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/hr_screen/employe_detail_screen/employedetailscreencontroller.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../widget/detailwidgetlist.dart';

class EmployeeDetailScreen extends GetView<EmployeeDetailScreenController> {
  const EmployeeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () {
          switch (controller.dataStatus.value) {
            case DataStatus.loading:
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Center(child: CircularProgressIndicator())],
              );
            case DataStatus.error:
              return const Column(children: [Center(child: Text("ERROR"))]);
            case DataStatus.done:
              return Scaffold(
                appBar: CustomAppBar(
                  leadingIconOnTap: () {
                    Get.back();
                  },
                  leadingIcon: const Icon(Icons.arrow_back, color: Colors.white,),
                  centerTitle: true,
                  height: 60,
                  title: controller.Title!,
                  styleType: Style.bgFillBluegray900,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: IconButton(
                        onPressed: () {
                          controller.checkAddData();
                        },
                        icon: const Icon(Icons.print, color: Colors.white,),
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      DetailWidgetList(
                        employeeDetail: controller.singleEmployeeDetail!,
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
