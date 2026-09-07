import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cattle_app/presentation/milk_screen/controller/milk_controller.dart';

import '../../widgets/app_bar/custom_app_bar.dart';

class PendingCowScreen extends GetView<MilkController> {
  const PendingCowScreen({Key? key}) : super(key: key);

  String getCowName(int index) {
    for (var item in controller.cowList) {
      if (controller.pendingMorningCow.value) {
        if (item.tagId == controller.pendingMorningCows[index]) {
          return item.calfName;
        }
      } else {
        if (item.tagId == controller.pendingEveningCows[index]) {
          return item.calfName;
        }
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.sort.clear();
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIconOnTap: () {
            controller.sort.clear();
            Get.back();
          },
          leadingIcon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          centerTitle: true,
          height: 60,
          title: controller.pendingMorningCow.value
              ? 'pending Morning Cow ID'
              : 'pending Evening Cow ID',
          styleType: Style.bgFillBluegray900,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.pendingMorningCow.value
                            ? controller.pendingMorningCows.length
                            : controller.pendingEveningCows.length,
                        itemBuilder: (context, index) {
                          final name = getCowName(index);
                          final displayName = name.length <= 10 ? name : "${name.substring(0, 10)}...";
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Colors.orangeAccent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Image(
                                      image: AssetImage("assets/images/img_group11.png"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      displayName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 60,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/Mask group.png'),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${controller.pendingMorningCow.value ? controller.pendingMorningCows[index] : controller.pendingEveningCows[index]} ',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}