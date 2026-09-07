import 'package:flutter/material.dart';
import 'package:cattle_app/core/app_export.dart';

class VaccineDetailsController extends GetxController {
  RxBool AllDoses = false.obs;

  RxString cowIdText = 'cowId'.obs;
  RxString vaccineTypeText = 'Vaccine Type'.obs;

  TextEditingController cowIdController = TextEditingController();
  TextEditingController vaccineTypeController = TextEditingController();
  TextEditingController selectFirstDateController = TextEditingController();
  TextEditingController AttemptedDoseController = TextEditingController();
  TextEditingController RemarkController = TextEditingController();

  GlobalKey<FormState> cowIdKey = GlobalKey<FormState>();
  GlobalKey<FormState> vaccineTypeKey = GlobalKey<FormState>();
  GlobalKey<FormState> AttemptedDoseKey = GlobalKey<FormState>();
}
