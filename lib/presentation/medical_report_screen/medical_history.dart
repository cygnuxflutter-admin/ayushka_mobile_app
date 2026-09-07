import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/presentation/medical_report_screen/medical_report_controller.dart';
import 'package:cattle_app/routes/app_routes.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';

import '../../widgets/dropdown/dropdown.dart';
import '../../widgets/rich_text.dart';
import '../milk_screen/controller/milk_controller.dart';

class MedicalHistory extends GetView<MedicalReportController> {
  const MedicalHistory({Key? key}) : super(key: key);

  String convertDateFormat({required String date}) {
    try {
      DateTime inputDate = DateFormat("yyyy-MM-dd").parse(date);
      String formattedDate = DateFormat("dd-MM-yyyy").format(inputDate);
      return formattedDate;
    } catch (e) {
      return date;
    }
  }

  String? cowName(MilkController milkController, int index) {
    for (var item in milkController.cowList) {
      if (item.tagId == controller.MedicineData[index].cowId) {
        return item.calfName;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final MilkController milkController = Get.put(MilkController());

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIconOnTap: () {
            Get.back();
          },
          leadingIcon: const Icon(Icons.arrow_back, color: Colors.white),
          centerTitle: true,
          height: 60,
          title: "Medicine History",
          styleType: Style.bgFillBluegray900,
        ),
        body: Column(
          children: [
            Dropdown(
              text: 'cowId'.obs,
              list: milkController.cowList
                  .map((data) => '${data.tagId} : ${data.calfName}')
                  .toList(),
              onChanged: (value) async {
                print(milkController.cowList.length);
                controller.cowIdController.text = value.toString();
                controller.medicineData(context);
              },
            ),
            Expanded(
              child: Obx(
                () => controller.MedicineData.isEmpty
                    ? Center(
                        child: Text(
                          "No record found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.MedicineData.length,
                        itemBuilder: (context, index) {
                          final item = controller.MedicineData[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (item.status != "COMPLETED")
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () {
                                            controller.ItemName();
                                            controller.EditOnTap(index: index);
                                            controller.updateCowIdController.text =
                                                "${item.cowId} : ${cowName(milkController, index) ?? ''}";
                                            Get.toNamed(AppRoutes.medicationUpdateScreen);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    CattleRichText(
                                      text: 'Cow ID : ',
                                      fontSize1: 14,
                                      color: const Color(0xff262626),
                                      richText: '${item.cowId} : ${cowName(milkController, index) ?? ''}',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                              CattleRichText(
                                text: 'Vaccine Name : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.vacName}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'Date : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.date}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'Type : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.type}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'Gaushala Id : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.gaushalaId}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'items : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.items}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'ID : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.id}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'status : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.status}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'AddedBy : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.addedBy}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'dose : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.dose}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'gapInDay : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.gapInDay}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'heatAttempt : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.heatAttempt}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'lastLogRemark : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.lastLogRemark}',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'nextDoseTime : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: convertDateFormat(date: item.nextDoseTime),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'toDate : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: convertDateFormat(date: item.toDate),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              CattleRichText(
                                text: 'remark : ',
                                fontSize1: 14,
                                color: const Color(0xff262626),
                                richText: '${item.remark}',
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
          ],
        ),
      ),
    );
  }
}
