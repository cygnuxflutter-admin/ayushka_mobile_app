import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cattle_app/widgets/custom_image_view.dart';

import '../../../core/utils/image_constant.dart';
import '../../../core/utils/size_utils.dart';
import '../../../theme/app_decoration.dart';
import '../controller/add_milk_controller.dart';
import '../milking_calf_screen.dart';

class CustomSearchBar extends GetView<AddMilkController> {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            height: 50,
            decoration: AppDecoration.outlineBlack9003f.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder15,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                focusNode: controller.searchFocus,
                controller: controller.searchNameIDController,
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  controller.isSearch.value = false;
                },
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  hintText: "Search",
                  helperStyle: const TextStyle(
                    fontFamily: 'Outfit',
                  ),
                  prefixIcon: CustomImageView(
                    imagePath: ImageConstant.imgSearch,
                    height: getSize(30),
                    width: getSize(30),
                    margin: getMargin(top: 5, bottom: 5, left: 7, right: 7),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.searchNameIDController.clear();
                      controller.isSearch.value = true;
                      controller.searchNameController!.clear();
                      controller.searchIdController!.clear();
                    },
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  controller.isSearch.value = true;
                },
                onChanged: (value) {
                  controller.filterList(value);
                },
              ),
            ),
          ),
          controller.isSearch.isTrue
              ? Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(5.0, 5.0),
                          blurRadius: 10.0,
                          spreadRadius: 3.0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: controller.filteredList.length,
                      itemBuilder: (context, index) {
                        final item = controller.filteredList[index];
                        return ListTile(
                          title: Text(
                            "${item.id} : ${item.name}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          onTap: () {
                            FocusScope.of(context).requestFocus(controller.addMilkFocus);
                            controller.isHide.value = false;
                            controller.MilkHistory(id: '${item.id}');

                            controller.cowType.value = item.type;
                            controller.milkML.value = controller.milkData!.lastMilkInDouble();
                            controller.adMilkController.text = controller.milkData!.cowsLastMilkLiter;
                            controller.searchNameController!.text = item.name;
                            controller.searchIdController!.text = item.id.toString();
                            controller.cowName.value = controller.searchNameController!.text;
                            controller.cowId.value = controller.searchIdController!.text;

                            controller.searchNameIDController = TextEditingController(
                              text: " ${item.id} : ${item.name}",
                            );

                            controller.isSearch.value = false;

                            if (controller.cowType == 'Milking-Calf') {
                              MilkingCalf(context);
                            } else {
                              DryCalf();
                            }
                          },
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class Item {
  String id;
  String name;
  String type;

  Item({required this.name, required this.id, required this.type});
}
