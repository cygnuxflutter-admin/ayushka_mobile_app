import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cattle_app/widgets/rich_text.dart';

import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import 'medical_report_controller.dart';

class AddMedicineHistory extends GetView<MedicalReportController> {
  const AddMedicineHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIconOnTap: () {
            Get.back();
          },
          leadingIcon: const Icon(Icons.arrow_back, color: Colors.white),
          centerTitle: true,
          height: 60,
          title: "Add Medicine History",
          styleType: Style.bgFillBluegray900,
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.stockList.length,
                  itemBuilder: (context, index) {
                    final item = controller.stockList[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      controller.stockList.removeAt(index);
                                    },
                                    icon: const Icon(Icons.close)),
                              ),
                              CattleRichText(
                                text: 'Item ID : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.itemId}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'Total Qty : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.totalWtOrQty}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(
                text: "Add Medicine",
                width: 200,
                height: 55,
                textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                variant: ButtonVariant.FillGreen600b2,
                onTap: () {
                  controller.medicineUpdate(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
