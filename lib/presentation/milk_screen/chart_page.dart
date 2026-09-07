// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cattle_app/presentation/milk_screen/controller/milk_controller.dart';
import 'package:cattle_app/presentation/milk_screen/pending_cow_screen.dart';
import 'package:cattle_app/widgets/rich_text.dart';

class LineChart extends GetView<MilkController> {
  const LineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.initChartData();
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          children: [
            SfCartesianChart(
              onTooltipRender: (tooltipArgs) {
                controller.updateChartData(tooltipArgs.text!);
              },
              tooltipBehavior: TooltipBehavior(
                enable: true,
                header: 'Milk Liter',
              ),
              primaryXAxis: CategoryAxis(
                labelStyle: const TextStyle(color: Colors.black),
                axisLine: AxisLine(width: 0),
                autoScrollingDelta: 4,
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
              ),
              zoomPanBehavior: ZoomPanBehavior(
                enablePanning: true,
                enablePinching: false,
              ),
              series: <CartesianSeries<ChartData, String>>[
                LineSeries<ChartData, String>(
                  dataSource: controller.chartData(),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    color: Color(0xff6979F8),
                  ),
                  pointColorMapper: (ChartData data, _) => const Color(0xff6979F8),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xffE5F0FF),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChartDetailWidget(
                          text: 'Total',
                          images: 'assets/images/totalMilk.png',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          imageSize: 30,
                        ),
                        Text(
                          '${convertDateFormat(date: controller.Date.value.split(' : ')[0])}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: CattleRichText(
                            text: 'Milk  ',
                            fontSize1: 15,
                            color1: Colors.black,
                            color: Colors.black54,
                            richText:
                                '${controller.Date.value == "0" ? 0 : controller.Date.value.split(' : ')[0] == DateFormat("yyyy-MM-dd").format(DateTime.now()) ? controller.milkHistory!.last7DayMilks.last.totalMilk : controller.Date.value.split(' : ')[1]}',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: CattleRichText(
                            text: 'Cows  ',
                            fontSize1: 15,
                            color1: Colors.black,
                            color: Colors.black54,
                            richText:
                                '${controller.totalMilkingCow.value == '' ? 0 : controller.totalMilkingCow.value} ',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: CattleRichText(
                            text: 'Gir cows  ',
                            fontSize1: 15,
                            color1: Colors.black,
                            color: Colors.black54,
                            richText:
                                " ${controller.girCow.value.isEmpty ? 0 : controller.girCow.value} ",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: CattleRichText(
                            text: 'other breed cows  ',
                            fontSize1: 15,
                            color1: Colors.black,
                            color: Colors.black54,
                            richText:
                                "${controller.otherCow.value.isEmpty ? 0 : controller.otherCow.value} ",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xffE5F0FF),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ChartDetailWidget(
                            text: 'Morning',
                            images: 'assets/images/morning.png',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            imageSize: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: CattleRichText(
                              text: 'Milk  ',
                              fontSize1: 15,
                              color1: Colors.black,
                              color: Colors.black54,
                              richText: '${controller.morningLiters.value} ',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: CattleRichText(
                              text: 'Cows  ',
                              fontSize1: 15,
                              color1: Colors.black,
                              color: Colors.black54,
                              richText: " ${controller.totalMorningCow.value} ",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xffE5F0FF),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ChartDetailWidget(
                            text: 'Evening',
                            images: 'assets/images/evening.png',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            imageSize: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: CattleRichText(
                              text: 'Milk  ',
                              fontSize1: 15,
                              color1: Colors.black,
                              color: Colors.black54,
                              richText: " ${controller.eveningLiters.value} ",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: CattleRichText(
                              text: 'Cows  ',
                              fontSize1: 15,
                              color1: Colors.black,
                              color: Colors.black54,
                              richText: " ${controller.totalEveningCow.value} ",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (controller.toDayCow.value == true) ...{
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: GestureDetector(
                  onTap: () {
                    controller.pendingMorningCow.value = true;
                    controller.pendingEveningCow.value = false;
                    controller.pendingMorningCows.sort((a, b) {
                      final numericPartA = int.tryParse(a);
                      final numericPartB = int.tryParse(b);

                      if (numericPartA != null &&
                          numericPartB != null) {
                        return numericPartA.compareTo(numericPartB);
                      } else if (numericPartA != null) {
                        return -1;
                      } else if (numericPartB != null) {
                        return 1;
                      }

                      return a.compareTo(b);
                    });
                    Get.to(PendingCowScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffE5F0FF),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChartDetailWidget(
                          text: 'Morning pending cows',
                          images: 'assets/images/morningMilk.png',
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          imageSize: 30,
                        ),
                        Spacer(),
                        Text("${controller.pendingMorningCows.length} ",
                          style: TextStyle(
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54, size: 18,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: GestureDetector(
                  onTap: () {
                    controller.pendingEveningCow.value = true;
                    controller.pendingMorningCow.value = false;
                    controller.pendingEveningCows.sort((a, b) {
                      final numericPartA = int.tryParse(a);
                      final numericPartB = int.tryParse(b);

                      if (numericPartA != null &&
                          numericPartB != null) {
                        return numericPartA.compareTo(numericPartB);
                      } else if (numericPartA != null) {
                        return -1;
                      } else if (numericPartB != null) {
                        return 1;
                      }
                      return a.compareTo(b);
                    });
                    Get.to(PendingCowScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffE5F0FF),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChartDetailWidget(
                          text: 'Evening pending cows',
                          images: 'assets/images/eveningMilk.png',
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          imageSize: 30,
                        ),
                        Spacer(),
                        Text("${controller.pendingEveningCows.length}",
                          style: TextStyle(
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54, size: 18,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            },
          ],
        ),
      );
    });
  }

  String convertDateFormat({required String date}) {
    if (date == "0") return "";
    DateTime inputDate = DateFormat("yyyy-MM-dd").parse(date);
    String formattedDate = DateFormat("dd-MM-yyyy").format(inputDate);
    return formattedDate;
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

class ChartDetailWidget extends StatelessWidget {
  const ChartDetailWidget(
      {required this.text,
      required this.images,
      required this.fontWeight,
      required this.fontSize,
      required this.imageSize});

  final String text;
  final String images;
  final FontWeight fontWeight;
  final double fontSize;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: AssetImage(images),
          height: imageSize,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: 'Outfit',
            ),
          ),
        ),
      ],
    );
  }
}
