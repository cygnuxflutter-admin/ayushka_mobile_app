import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cattle_app/presentation/cow_screen/cow_controller.dart';
import 'package:cattle_app/routes/app_routes.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../milk_screen/controller/milk_controller.dart';
import '../milk_screen/widgets/milk_item_widget.dart';

class CowsScreen extends GetView<CowsScreenController> {
  const CowsScreen({Key? key}) : super(key: key);

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
          title: "Cow List",
          styleType: Style.bgFillBluegray900,
        ),
        body: Container(
          width: size.width,
          padding: getPadding(top: 10),
          decoration: BoxDecoration(color: ColorConstant.whiteA700),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: TextField(
                    onChanged: controller.onSearchTextChanged,
                    controller: controller.searchController,
                    decoration: const InputDecoration(
                      hintText: "Search",
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                        child: Image(image: AssetImage('assets/images/img_search.png'), height: 10),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isSearching.value) {
                    return const Center(
                      child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
                    );
                  }
                  switch (controller.milkController.dataStatus.value) {
                    case DataStatusE.loading:
                      return const Center(child: CircularProgressIndicator());
                    case DataStatusE.error:
                      return const Center(child: Text("ERROR"));
                    case DataStatusE.done:
                      return Padding(
                        padding: getPadding(left: 22, top: 0, right: 11),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.filteredCowList.length,
                          itemBuilder: (context, index) {
                            final cow = controller.filteredCowList[index];
                            return MilkItemWidget(
                              variant: cow.isFemale,
                              type: cow.type,
                              description: true,
                              name: "${cow.tagId} : ${cow.calfName}",
                              onTap: () {
                                Get.toNamed(AppRoutes.cowsDetailScreen, arguments: {'tagId': cow.tagId});
                              },
                            );
                          },
                        ),
                      );
                  }
                  return const SizedBox.shrink();
                }),
              ),
              Obx(() {
                // Dummy access to observables to satisfy Obx and ensure reactivity
                final _ = controller.currentPage.value;
                final __ = controller.isSearching.value;

                if (moduleEnum == ModuleEnum.cowsScreen && controller.searchController.text.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (controller.currentPage.value > 1) ...{
                          InkWell(
                            onTap: controller.previousPage,
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), color: const Color(0xffffaf4d)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                                  Text("Previous", style: TextStyle(color: Colors.white, fontSize: 18)),
                                ],
                              ),
                            ),
                          ),
                        } else ...{
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), color: Colors.grey.shade400),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                                Text("Previous", style: TextStyle(color: Colors.white, fontSize: 18)),
                              ],
                            ),
                          ),
                        },
                        if (controller.currentPage.value <
                            (controller.originalCowList.length / controller.itemsPerPage).ceil()) ...{
                          InkWell(
                            onTap: controller.nextPage,
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), color: const Color(0xff32b832)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Next", style: TextStyle(color: Colors.white, fontSize: 18)),
                                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 20),
                                ],
                              ),
                            ),
                          ),
                        },
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
