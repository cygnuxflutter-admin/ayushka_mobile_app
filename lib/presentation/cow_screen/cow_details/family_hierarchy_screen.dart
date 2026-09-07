import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Node;
import 'package:graphview/GraphView.dart';

import '../../../core/utils/size_utils.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import 'cow_details_controller.dart';

class FamilyHierarchy extends GetView<CowsDetailScreenController> {
  const FamilyHierarchy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIconOnTap: () {
          Get.back();
        },
        centerTitle: true,
        leadingIcon: const Icon(Icons.arrow_back, color: Colors.white),
        height: getVerticalSize(74),
        title: "Family Hierarchy",
        styleType: Style.bgFillBluegray900,
      ),
      body: SafeArea(
        child: Obx(
          () {
            switch (controller.cowHierarchyStatus.value) {
              case CowHierarchyDataStatus.loading:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(child: CircularProgressIndicator())
                  ],
                );
              case CowHierarchyDataStatus.error:
                return const Center(
                  child: Text("NO DATA FOUND", style: TextStyle(fontSize: 20)),
                );

              case CowHierarchyDataStatus.done:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: InteractiveViewer(
                                constrained: false,
                                boundaryMargin: const EdgeInsets.all(100),
                                minScale: 0.01,
                                maxScale: 2.0,
                                child: controller.edgesList.isNotEmpty
                                    ? GraphView(
                                        animated: true,
                                        graph: controller.graph.value,
                                        algorithm: BuchheimWalkerAlgorithm(
                                          controller.builder,
                                          TreeEdgeRenderer(controller.builder),
                                        ),
                                        paint: Paint()
                                          ..color = Colors.green
                                          ..strokeWidth = 1
                                          ..style = PaintingStyle.stroke,
                                        builder: (Node node) {
                                          var a = "${node.key!.value}";
                                          var nodes = controller.nodes;
                                          if (nodes.isEmpty) {
                                            return const SizedBox();
                                          }
                                          var nodeValue = nodes.firstWhere((element) => element.id == a);
                                          return rectangleWidget(
                                              id: "${nodeValue.id}",
                                              label: nodeValue.label,
                                              gender: nodeValue.gender,
                                              type: nodeValue.type,
                                              breed: nodeValue.breed);
                                        },
                                      )
                                    : rectangleWidget(
                                        id: controller.cowHierarchyResponse!.cowData.cowId,
                                        breed: controller.cowHierarchyResponse!.cowData.breed,
                                        type: controller.cowHierarchyResponse!.cowData.type,
                                        label: controller.cowHierarchyResponse!.cowData.calfName,
                                        gender: controller.cowHierarchyResponse!.cowData.gender,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  Widget rectangleWidget({
    required String id,
    required String label,
    required String gender,
    required String type,
    required String breed,
  }) {
    bool isMale = gender == "Male" ? true : false;
    String types = gender == "Male" ? " Bull" : " Cow";

    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isMale ? const Color(0xff7D6C69) : const Color(0xffF2A344),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            customText(
              text: "$id - $label",
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  isMale ? Icons.male : Icons.female,
                  color: Colors.white,
                  size: 40,
                ),
                customText(
                  text: isMale ? "M" : "F",
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customText(
                      text: "$breed $types",
                      color: isMale ? const Color(0xffF2A344) : const Color(0xff7D6C69),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    customText(
                      text: type,
                      color: const Color(0xffB8FF8F),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text customText({
    required String text,
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
