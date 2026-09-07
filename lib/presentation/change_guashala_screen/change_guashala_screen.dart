import 'package:cattle_app/core/utils/pref_utils.dart';
import 'package:cattle_app/presentation/change_guashala_screen/change_guashala_controller.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeGuashalaScreen extends GetView<ChangeGuashalaScreenController> {
  const ChangeGuashalaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentGaushalaId = PrefUtils.getGaushalaId.toString();

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
        title: "Change Guashala",
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
                    controller.getLatestAppVersion(GaushalaId: "01");
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: currentGaushalaId == "01" ? Colors.green : Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(child: Text('Bangalore', style: TextStyle(fontSize: 20))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    controller.getLatestAppVersion(GaushalaId: "02");
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: currentGaushalaId == "02" ? Colors.green : Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(child: Text('Vasad', style: TextStyle(fontSize: 20))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    controller.getLatestAppVersion(GaushalaId: "03");
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: currentGaushalaId == "03" ? Colors.green : Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(child: Text('Pune', style: TextStyle(fontSize: 20))),
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
