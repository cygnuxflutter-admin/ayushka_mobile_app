// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/hr_screen/hr_screen_controller.dart';
import 'package:cattle_app/presentation/hr_screen/widget/employe_listview.dart';
import 'package:cattle_app/widgets/size.dart';

import '../../widgets/app_bar/custom_app_bar.dart';

class HrScreen extends GetView<HrScreenController> {
  const HrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIconOnTap: () {
            Get.back();
          },
          leadingIcon: const Icon(Icons.arrow_back, color: Colors.white,),
          centerTitle: true,
          height: 60,
          title: "HR",
          styleType: Style.bgFillBluegray900,
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.addEmployeeScreen,
                    arguments: "All",
                  );
                },
                child: const Image(
                  image: AssetImage(
                    'assets/images/add-user-3-512.png',
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Obx(
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
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          controller.updateFilteredItemList(value);
                        },
                        controller: controller.searchController,
                        decoration: const InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color(0xff232f34),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: AppSize.size(context).width * 0.06,
                        ),
                        Text(
                          'Name',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtOutfitLight15,
                        ),
                        const Spacer(),
                        Text(
                          'Active',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtOutfitLight15,
                        ),
                        SizedBox(
                          width: AppSize.size(context).width * 0.06,
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color(0xff232f34),
                    ),
                    Expanded(
                      child: EmployList(
                        employList: controller.employeeList,
                        hrScreenController: controller,
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
