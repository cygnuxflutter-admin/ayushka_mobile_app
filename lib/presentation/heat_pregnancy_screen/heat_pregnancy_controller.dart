import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class HeatPregnancyController extends GetxController {
  RxBool AllDoses = false.obs;
  RxInt selectedSegment = 0.obs;
  RxString cowIdText = 'cowId'.obs;
  RxString selectFirstDateText = ''.obs;

  TextEditingController cowIdController = TextEditingController();
  TextEditingController selectFirstDateController = TextEditingController();
  TextEditingController LastPeriodTimeDateController = TextEditingController();
  TextEditingController NextDateController = TextEditingController();
  TextEditingController RemainingDaysController = TextEditingController();
  TextEditingController PrecautionDaysController = TextEditingController(text: '5');
  TextEditingController RemarkController = TextEditingController();

  GlobalKey<FormState> cowIdKey = GlobalKey<FormState>();
  GlobalKey<FormState> vaccineTypeKey = GlobalKey<FormState>();
  GlobalKey<FormState> LastPeriodTimeDateKey = GlobalKey<FormState>();
}
