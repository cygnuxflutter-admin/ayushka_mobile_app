import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cattle_app/presentation/dairy_usage_screen/controller/dairy_usage_controller.dart';
import '../models/todayMilkUsageResponse.dart';

class HistoryWidget extends GetView<DairyUsageController> {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.historyData == null) {
      return const SizedBox();
    }
    final history = controller.historyData!;

    return SingleChildScrollView(
      child: Column(
        children: [
          history.todayMilkUsedInCurd.isEmpty
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Milk Used In Curd",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: history.todayMilkUsedInCurd.length,
                          itemBuilder: (context, index) {
                            TodayMilkUsedIn milkUsedIn = history.todayMilkUsedInCurd[index];
                            return Row(
                              children: [
                                Text(
                                  '${milkUsedIn.usedIn}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const Spacer(),
                                Text(
                                  '${milkUsedIn.liter} LT',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(height: 10),
          history.todayMilkUsedInMilkPowder.isEmpty
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Milk Used In Milk Powder",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: history.todayMilkUsedInMilkPowder.length,
                          itemBuilder: (context, index) {
                            TodayMilkUsedIn milkUsedIn = history.todayMilkUsedInMilkPowder[index];
                            return Row(
                              children: [
                                Text(
                                  '${milkUsedIn.usedIn}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const Spacer(),
                                Text(
                                  '${milkUsedIn.liter} LT',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(height: 10),
          history.todayMilkUsedInMilkCounter.isEmpty
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Milk Used In Milk Counter",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: history.todayMilkUsedInMilkCounter.length,
                          itemBuilder: (context, index) {
                            TodayMilkUsedIn milkUsedIn = history.todayMilkUsedInMilkCounter[index];
                            return Row(
                              children: [
                                Text(
                                  '${milkUsedIn.usedIn}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const Spacer(),
                                Text(
                                  '${milkUsedIn.liter} LT',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(height: 10),
          history.todayMilkUsedInTajaMilk.isEmpty
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Milk Used In Taja Milk",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: history.todayMilkUsedInTajaMilk.length,
                          itemBuilder: (context, index) {
                            TodayMilkUsedIn milkUsedIn = history.todayMilkUsedInTajaMilk[index];
                            return Row(
                              children: [
                                Text(
                                  '${milkUsedIn.usedIn}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const Spacer(),
                                Text(
                                  '${milkUsedIn.liter} LT',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(height: 10),
          history.todayMilkUsedInDistributionFree.isEmpty
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Milk Used In Distribution",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: history.todayMilkUsedInDistributionFree.length,
                          itemBuilder: (context, index) {
                            TodayMilkUsedIn milkUsedIn = history.todayMilkUsedInDistributionFree[index];
                            return Row(
                              children: [
                                Text(
                                  '${milkUsedIn.usedIn}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const Spacer(),
                                Text(
                                  '${milkUsedIn.liter} LT',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(height: 10),
          history.todayMilkUsedInSweet.isEmpty
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Milk Used In Sweet",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: history.todayMilkUsedInSweet.length,
                          itemBuilder: (context, index) {
                            TodayMilkUsedIn milkUsedIn = history.todayMilkUsedInSweet[index];
                            return Row(
                              children: [
                                Text(
                                  '${milkUsedIn.usedIn}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const Spacer(),
                                Text(
                                  '${milkUsedIn.liter} LT',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
