import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:cattle_app/core/app_export.dart';
import 'controller/add_milk_controller.dart';

MilkingCalf(BuildContext context) {
  AddMilkController addMilkController = Get.put(AddMilkController());

  return Column(
    children: [
      Padding(
        padding: getPadding(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addMilkController.tepData.value
                ? SizedBox()
                : Container(
                  width: 100,
                  child: TextFormField(
                    focusNode: addMilkController.addMilkFocus,
                    style: TextStyle(fontSize: 35),
                    keyboardType:  TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      double? parsedValue =
                      double.tryParse(value);
                      if (parsedValue != null) {
                        if (parsedValue <= 10) {
                          addMilkController.milkML.value = parsedValue;
                        } else {
                          addMilkController.milkML.value = 10;
                          addMilkController.adMilkController.text = "10";
                        }
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                        "0.0 L"
                    ),
                    onEditingComplete: () {
                      if (addMilkController.cowType == 'Milking' ||
                          addMilkController.cowType == 'Milking-Pregnant') {
                        addMilkController.AddMilkApi(context);
                      } else {
                        Get.back();
                      }
                      addMilkController.searchFocus.requestFocus();
                    },
                    controller: addMilkController.adMilkController,
                  ),
                ),
          ],
        ),
      ),
      Padding(
        padding: getPadding(left: 11, top: 11, right: 21,),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/addMilkIcon.png'),height: 100,),
            addMilkController.tepData.value
                ? SizedBox()
                : Obx(
                    () => Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "lbl_0_l".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtOutfitBold15,
                                ),
                                Spacer(),
                                Text(
                                  "lbl_10_l".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtOutfitBold15,
                                ),
                              ],
                            ),
                          ),
                          SfSlider(
                            min: 0.0,
                            max: 10.0,
                            value: addMilkController.milkML.value,
                            interval: 1,
                            showTicks: true,
                            stepSize: 0.1,
                            showLabels: true,
                            enableTooltip: true,
                            minorTicksPerInterval: 1,
                            onChanged: (dynamic value) {
                              double parsedValue = double.parse(value.toStringAsFixed(1));
                              addMilkController.milkML.value = parsedValue;
                              addMilkController.adMilkController.text = parsedValue.toString();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40,left: 10,right: 10,bottom: 30),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffE5F0FF),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Image(image: AssetImage('assets/images/morning.png'),height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Morning Milk Count",
                              style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 13
                              ),
                            ),
                          ),Text(
                            "${addMilkController.todayMorningMilkCount.value}",
                            style: TextStyle(
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffE5F0FF),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Image(image: AssetImage('assets/images/evening.png'),height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Evening Milk Count",
                              style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 13
                              ),
                            ),
                          ),Text(
                            "${addMilkController.todayEveningMilkCount.value}",
                            style: TextStyle(
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

DryCalf() {
  AddMilkController addMilkController = Get.put(AddMilkController());

  return Obx(
    () => Center(
      child: Text(
        "${addMilkController.cowType}",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: AppStyle.txtOutfitMedium20Blue700,
      ),
    ),
  );
}
