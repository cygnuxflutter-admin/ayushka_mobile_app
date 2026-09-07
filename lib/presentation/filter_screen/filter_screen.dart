// ignore_for_file: sdk_version_since

import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/filter_screen/filter_controller.dart';
import 'package:cattle_app/presentation/milk_screen/controller/milk_controller.dart';

import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';

enum SortBy { Milkingcow, Drycow }

enum Shed { Shed1, Shed2, Shed3 }

enum Cow { Entry, Exit }

enum DayTime { Morning, Evening }

class FilterScreen extends StatelessWidget {
  final void Function(List<String> value) sortedData;

  const FilterScreen({Key? key, required this.sortedData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FilterController filterController = Get.put(FilterController());
    final MilkController milkController = Get.put(MilkController());

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIconOnTap: () {
            Get.back();
          },
          leadingIcon: const Icon(Icons.arrow_back, color: Colors.white,),
          centerTitle: true,
          height: 60,
          title: "Sort".tr,
          styleType: Style.bgFillBluegray900,
        ),
        body: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: Text('Sort By', style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Wrap(
                  spacing: 5.0,
                  children: SortBy.values.map((SortBy sotrBy) {
                    return FilterChip(
                      checkmarkColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                      backgroundColor: Colors.white,
                      selectedColor: Colors.blue[50],
                      label: Text(sotrBy.name),
                      selected: filterController.filtersSortBy.contains(sotrBy),
                      onSelected: (bool selected) {
                        if (selected) {
                          filterController.filtersSortBy.add(sotrBy);
                          milkController.sort.add(sotrBy.name.toString());
                        } else {
                          filterController.filtersSortBy.remove(sotrBy);
                          milkController.sort.remove(sotrBy.name.toString());
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10.0),
              const Divider(color: Colors.grey, height: 10),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: Text('Shed', style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Wrap(
                  spacing: 5.0,
                  children: Shed.values.map((Shed shed) {
                    return FilterChip(
                      checkmarkColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                      backgroundColor: Colors.white,
                      selectedColor: Colors.blue[50],
                      label: Text(shed.name),
                      selected: filterController.filtersShed.contains(shed),
                      onSelected: (bool selected) {
                        if (selected) {
                          filterController.filtersShed.add(shed);
                          milkController.sort.add(shed.name.toString());
                        } else {
                          filterController.filtersShed.remove(shed);
                          milkController.sort.remove(shed.name.toString());
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10.0),
              const Divider(color: Colors.grey, height: 10),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: Text('Cow', style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Wrap(
                  spacing: 5.0,
                  children: Cow.values.map((Cow cow) {
                    return FilterChip(
                      checkmarkColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                      backgroundColor: Colors.white,
                      selectedColor: Colors.blue[50],
                      label: Text(cow.name),
                      selected: filterController.filtersCow.contains(cow),
                      onSelected: (bool selected) {
                        if (selected) {
                          filterController.filtersCow.add(cow);
                          milkController.sort.add(cow.name.toString());
                        } else {
                          filterController.filtersCow.remove(cow);
                          milkController.sort.remove(cow.name.toString());
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10.0),
              const Divider(color: Colors.grey, height: 10),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: Text('Day Time', style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Wrap(
                  spacing: 5.0,
                  children: DayTime.values.map((DayTime dayTime) {
                    return FilterChip(
                      checkmarkColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                      backgroundColor: Colors.white,
                      selectedColor: Colors.blue[50],
                      label: Text(dayTime.name),
                      selected: filterController.filtersDayTime.contains(dayTime),
                      onSelected: (bool selected) {
                        if (selected) {
                          filterController.filtersDayTime.add(dayTime);
                          milkController.sort.add(dayTime.name.toString());
                        } else {
                          filterController.filtersDayTime.remove(dayTime);
                          milkController.sort.remove(dayTime.name.toString());
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              CustomButton(
                height: getVerticalSize(58),
                onTap: () {
                  filterController.filtersSortBy.clear();
                  filterController.filtersShed.clear();
                  filterController.filtersCow.clear();
                  filterController.filtersDayTime.clear();
                  milkController.sort.clear();
                  Get.back();
                },
                text: "Clear".tr,
                margin: getMargin(
                  left: 28,
                  top: 102,
                  right: 29,
                  bottom: 5,
                ),
                textStyle: const TextStyle(color: Colors.white),
                variant: ButtonVariant.FillBluegray900,
                fontStyle: ButtonFontStyle.OutfitMedium20WhiteA700,
              ),
              CustomButton(
                height: getVerticalSize(58),
                onTap: () {
                  sortedData(milkController.sort);
                  Navigator.pop(context, milkController.sort);
                },
                text: "Apply".tr,
                margin: getMargin(
                  left: 28,
                  top: 10,
                  right: 29,
                  bottom: 5,
                ),
                textStyle: const TextStyle(color: Colors.white),
                variant: ButtonVariant.FillBluegray900,
                fontStyle: ButtonFontStyle.OutfitMedium20WhiteA700,
              ),
            ],
          );
        }),
      ),
    );
  }
}
