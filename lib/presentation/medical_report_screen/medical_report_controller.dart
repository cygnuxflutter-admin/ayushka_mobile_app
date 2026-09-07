import 'package:cattle_app/presentation/Medication/medication_controller.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:cattle_app/presentation/common%20file/defaultVariablesList.dart';
import 'package:cattle_app/presentation/medical_report_screen/models/medical_report_response.dart';
import 'package:cattle_app/presentation/medical_report_screen/models/medicine_History_ByCowID_Request.dart';
import 'package:cattle_app/presentation/medical_report_screen/models/medicine_History_ByCowID_Response.dart';
import 'package:cattle_app/presentation/medical_report_screen/models/medicine_update_request.dart';
import 'package:cattle_app/presentation/medical_report_screen/models/medicine_update_response.dart';
import 'package:cattle_app/presentation/medical_report_screen/models/pending_Vaccine_request.dart';
import 'package:cattle_app/presentation/medical_report_screen/models/pending_Vaccine_response.dart';
import 'package:cattle_app/widgets/toast_message/toast_message.dart';

import '../../core/utils/pref_utils.dart';
import '../../data/apiClient/api_client.dart';
import '../../data/apiClient/api_methods.dart';
import '../../widgets/loder.dart';
import 'models/medical_report_request.dart';

enum DataStatus { loading, done, error }

class MedicalReportController extends GetxController {
  RxInt selectedSegment = 0.obs;
  Rx<bool?> popupBuilderSelection = Rx<bool?>(false);
  MedicationController medicationController = Get.put(MedicationController());

  RxString cowIdText = ''.obs;
  RxString vaccineTypeText = ''.obs;
  RxString shedIDText = ''.obs;
  RxString cowTypeText = ''.obs;
  RxString selectFirstDateText = ''.obs;
  RxString nextDateText = ''.obs;
  RxString nextToDateText = ''.obs;
  RxString medicineNameText = ''.obs;
  RxString updateMedicationMedicineNameText = ''.obs;

  TextEditingController cowIdController = TextEditingController();
  TextEditingController vaccineTypeController = TextEditingController();
  TextEditingController medicineNameController = TextEditingController();
  TextEditingController gapInDayController = TextEditingController();
  TextEditingController doseController = TextEditingController();
  TextEditingController selectFirstDateController = TextEditingController();
  TextEditingController nextDateController = TextEditingController();
  TextEditingController nextToDateController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController shedIDController = TextEditingController();
  TextEditingController cowTypeController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  TextEditingController updateMedicalIdController = TextEditingController();
  TextEditingController updateCowIdController = TextEditingController();
  TextEditingController updateVaccineNameController = TextEditingController();
  TextEditingController updateDoseController = TextEditingController();
  TextEditingController updateNextDoseDateController = TextEditingController();
  TextEditingController updateDoseDateController = TextEditingController();
  TextEditingController updateToDateController = TextEditingController();
  TextEditingController updateGapInDayController = TextEditingController();
  TextEditingController updateStatusController = TextEditingController();
  TextEditingController updateTypeController = TextEditingController();
  TextEditingController updateHeatAttemptController = TextEditingController();
  TextEditingController updateRemarkController = TextEditingController();
  TextEditingController updateMedicalLogRemarkController = TextEditingController();
  TextEditingController updateMedicationMedicineNameController = TextEditingController();

  TextEditingController updateStockExpensTypeController = TextEditingController(text: 'Medical');
  TextEditingController updateStockItemNameController = TextEditingController();
  TextEditingController updateStockTotalWtOrQtyController = TextEditingController();
  TextEditingController updateAddMedicationQtyController = TextEditingController();
  RxString updateStockItemNameText = 'itemName'.obs;

  DateTime nextDoseController = DateTime.now();
  DateTime toDateController = DateTime.now();

  GlobalKey<FormState> cowIdKey = GlobalKey<FormState>();
  GlobalKey<FormState> vaccineTypeKey = GlobalKey<FormState>();
  GlobalKey<FormState> medicineNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> doseKey = GlobalKey<FormState>();

  GlobalKey<FormState> updateStockItemNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateStockTotalWtOrQtyKey = GlobalKey<FormState>();

  GlobalKey<FormState> updateMedicineKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateQtyKey = GlobalKey<FormState>();
  RxList<Medicine> AddMedication = <Medicine>[].obs;

  var filteredItemList = [''].obs;

  List<AddMedicalRequest> addMedicineList = [];
  RxList<MedicineHistoryDatum> MedicineData = <MedicineHistoryDatum>[].obs;
  List<String> statusList = ["RUNNING", "COMPLETED"];
  Map<String, dynamic>? retrievedData = PrefUtils.getData;
  RxList<StockList> stockList = <StockList>[].obs;

  RxList<PendingVaccineCowDatum> pendingVaccineCowList =
      <PendingVaccineCowDatum>[].obs;
  Rx<DataStatus> dataStatus = DataStatus.loading.obs;

  RxBool isSelectedCows = false.obs;
  RxList<String> selectedCowIds = <String>[].obs;
  RxList<String> selectedCowFullDetails = <String>[].obs;
  RxList<String> selectedVaccines = <String>[].obs;

  @override
  void onInit() {
    retrieveCowData();
    super.onInit();
  }

  String ItemName() {
    filteredItemList.clear();
    for (var item in itemMaster) {
      if (item.expenceType == 'Medical') {
        filteredItemList.add(item.itemName);
      }
    }
    return '';
  }

  String cowId({required String id}) {
    List<String> parts = id.split(' : ');
    String? desiredOutput;
    return desiredOutput = "${parts[0]}";
  }

  AllFieldClear() {
    cowIdController.clear();
    vaccineTypeController.clear();
    medicineNameController.clear();
    gapInDayController.clear();
    doseController.clear();
    selectFirstDateController.clear();
    nextDateController.clear();
    nextToDateController.clear();
    typeController.clear();
    remarkController.clear();

    cowIdText.value = '';
    vaccineTypeText.value = '';
    shedIDText.value = '';
    cowTypeText.value = '';
    selectFirstDateText.value = '';
    nextDateText.value = '';
    nextToDateText.value = '';
    medicineNameText.value = '';
    updateMedicationMedicineNameText.value = '';
    selectedCowIds.clear();
    selectedCowFullDetails.clear();
    selectedVaccines.clear();
  }

  EditOnTap({required index}) {
    medicationController.medicationVaccineName.text = MedicineData[index].vacName;
    medicationController.medicationType.text = MedicineData[index].type;
    medicationController.medicationAttemptDose.text = MedicineData[index].heatAttempt.toString();
    medicationController.medicationGapInDay.text = MedicineData[index].gapInDay.toString();
    medicationController.medicationDoseDate.text = MedicineData[index].date;
    medicationController.medicationNextDoseDate.text = MedicineData[index].nextDoseTime;
    medicationController.medicationDose.text = MedicineData[index].dose.toString();
    medicationController.medicationMedicalIdController.text = MedicineData[index].id.toString();
    medicationController.medicationRemarkController.text = MedicineData[index].remark;
    medicationController.medicationToDateController.text = MedicineData[index].toDate;
  }

  String itemId() {
    for (var item in itemMaster) {
      if (item.itemName == updateStockItemNameText.value) {
        return item.itemId;
      }
    }
    return '';
  }

  String MedicineItemId() {
    for (var item in itemMaster) {
      if (item.itemName == updateMedicationMedicineNameController.text) {
        return item.itemId;
      }
    }
    return '';
  }

  bool isStock() {
    for (var item in itemMaster) {
      if (item.itemName == updateStockItemNameText.value) {
        return item.isStock;
      }
    }
    return false;
  }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("dd-MM-yyyy").parse(date);

    String formattedDate = DateFormat("yyyy-MM-dd").format(inputDate);

    return formattedDate;
  }

  RxList<PendingVaccineCowDatum> updateFilteredItemList(String query) {
    List<PendingVaccineCowDatum> ListTamp;
    if (query != '') {
      ListTamp = pendingVaccineCowList.where((data) =>
              data.tagId.toLowerCase().contains(query.toLowerCase()) ||
              data.calfName.toLowerCase().contains(query.toLowerCase())).toList();
    } else {
      ListTamp = pendingVaccineCowList;
    }
    return ListTamp.obs;
  }

  RxString OUTUnitType() {
    for (var item in itemMaster) {
      if (item.itemName == updateStockItemNameText.value) {
        return item.outUnitType.obs;
      }
    }
    return ''.obs;
  }

  List<PendingVaccineCowDatum> totalSelectFilter() {
    List<PendingVaccineCowDatum> selectCowList = [];
    for (var data in pendingVaccineCowList) {
      if (data.isSelectCow.isTrue) {
        selectCowList.add(data);
      }
    }
    return selectCowList;
  }

  List<AddMedicalRequest> MedicineSubmitRequest() {
    List<AddMedicalRequest> addMedicine = [];

    // Helper to generate VaccineItem list based on selected vaccines or single vaccine
    List<VaccineItem> generateVaccines() {
      List<VaccineItem> items = [];
      String type = typeController.text;
      
      // If VACCINE or HEAT and multi-select is used
      if ((type == 'VACCINE' || type == 'HEAT') && selectedVaccines.isNotEmpty) {
        for (var vac in selectedVaccines) {
          items.add(VaccineItem(
            vacName: vac,
            dose: int.tryParse(doseController.text) ?? 1,
            nextDoseTime: convertDateFormat(date: nextDateController.text),
            gapInDay: int.tryParse(gapInDayController.text) ?? 0,
            toDate: '2030-01-01',
            heatAttempt: 1,
            medicines: AddMedication,
          ));
        }
      } else {
        // Fallback for single selection
        items.add(VaccineItem(
            vacName: type == 'VACCINE' || type == 'HEAT'
                ? vaccineTypeController.text
                : medicineNameController.text,
            dose: int.tryParse(doseController.text) ?? 1,
            nextDoseTime: convertDateFormat(date: nextDateController.text),
            gapInDay: int.tryParse(gapInDayController.text) ?? 0,
            toDate: type == 'VACCINE' || type == 'HEAT'
                ? '2030-01-01'
                : convertDateFormat(date: nextToDateController.text),
            heatAttempt: 1,
            medicines: AddMedication,
          ));
      }
      return items;
    }

    if (typeController.text == 'VACCINE') {
      // 1. Hande cows selected from PendingCowScreen
      for (var data in totalSelectFilter()) {
        addMedicine.add(
          AddMedicalRequest(
            gaushalaId: PrefUtils.getGaushalaId.toString(),
            cowId: data.tagId,
            date: selectFirstDateController.text.isEmpty
                ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                : convertDateFormat(date: selectFirstDateController.text),
            remark: remarkController.text,
            status: 'RUNNING',
            addedBy: retrievedData!['user_id'],
            type: typeController.text,
            vaccines: generateVaccines(),
          ),
        );
      }
      // 2. Handle cows selected directly from multi-select dropdown
      if (selectedCowIds.isNotEmpty) {
        for (var cId in selectedCowIds) {
          addMedicine.add(
            AddMedicalRequest(
                gaushalaId: PrefUtils.getGaushalaId.toString(),
                cowId: cowId(id: cId),
                date: selectFirstDateController.text.isEmpty
                    ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                    : convertDateFormat(date: selectFirstDateController.text),
                remark: remarkController.text,
                status: 'RUNNING',
                addedBy: retrievedData!['user_id'],
                type: typeController.text,
                vaccines: generateVaccines(),
            ),
          );
        }
      } else if (isSelectedCows.isTrue && cowIdController.text.isNotEmpty) {
        // 3. Fallback for single cow selected
        addMedicine.add(
          AddMedicalRequest(
              gaushalaId: PrefUtils.getGaushalaId.toString(),
              cowId: cowId(id: cowIdController.text),
              date: selectFirstDateController.text.isEmpty
                  ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                  : convertDateFormat(date: selectFirstDateController.text),
              remark: remarkController.text,
              status: 'RUNNING',
              addedBy: retrievedData!['user_id'],
              type: typeController.text,
              vaccines: generateVaccines(),
          ),
        );
      }
    } else {
      // Not VACCINE (e.g. Checkup/Heat)
      List<String> targetCows = selectedCowIds.isNotEmpty ? selectedCowIds : [cowIdController.text];
      
      for (var cId in targetCows) {
        if (cId.isEmpty) continue;
        addMedicine.add(
          AddMedicalRequest(
            gaushalaId: PrefUtils.getGaushalaId.toString(),
            cowId: cowId(id: cId),
            date: selectFirstDateController.text.isEmpty
                ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                : convertDateFormat(date: selectFirstDateController.text),
            remark: remarkController.text,
            status: 'RUNNING',
            addedBy: retrievedData!['user_id'],
            type: typeController.text,
            vaccines: generateVaccines(),
          ),
        );
      }
    }
    return addMedicine;
  }

  Future<void> addVaccine(BuildContext context) async {
    AppLoader().show();
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.addMedicine,
      body: addMedicalRequestToJson(
        MedicineSubmitRequest(),
      ),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        AddMedicalResponse addMedicalResponse = addMedicalResponseFromJson(response.data);
        print(response.data);
        if (addMedicalResponse.status == "SUCCESS") {
          CattleToast.msg(addMedicalResponse.message);
          pendingVaccineCowList.clear();
          AddMedication.clear();
        } else {
          CattleToast.msg(addMedicalResponse.message);
        }
      } else {
        CattleToast.msg(response.statusMessage!);
        print(response.statusCode);
      }
    } catch (error) {
      AppLoader().hide();
      CattleToast.msg(error.toString());
    }
  }

  Future<void> medicineData(BuildContext context) async {
    AppLoader().show();
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.medicineByCowId,
      body: medicineHistoryByCowIdRequestToJson(
        MedicineHistoryByCowIdRequest(
          cowId: cowId(id: cowIdController.text),
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        MedicineHistoryByCowIdResponse medicineHistoryByCowIdResponse = medicineHistoryByCowIdResponseFromJson(response.data);
        MedicineData.value = medicineHistoryByCowIdResponse.medicineHistoryData;
        CattleToast.msg(medicineHistoryByCowIdResponse.message);
      } else {
        CattleToast.msg(response.statusMessage!);
        print(response.statusCode);
      }
    } catch (error) {
      AppLoader().hide();
      CattleToast.msg(error.toString());
    }
  }

  Future<void> medicineUpdate(BuildContext context) async {
    AppLoader().show();
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.medicineUpdate,
      body: medicineUpdateRequestToJson(
        MedicineUpdateRequest(
          medicalIds: [int.parse(updateMedicalIdController.text)],
          gaushalaId: PrefUtils.getGaushalaId.toString(),
          cowId: cowId(id: updateCowIdController.text),
          vacName: updateVaccineNameController.text,
          dose: int.parse(updateDoseController.text),
          nextDoseTime:
              convertDateFormat(date: updateNextDoseDateController.text),
          date: convertDateFormat(date: updateDoseDateController.text),
          remark: updateRemarkController.text,
          medicalLogRemark: updateMedicalLogRemarkController.text.isEmpty
              ? ''
              : updateMedicalLogRemarkController.text,
          medicalLogDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          gapInDay: int.parse(updateGapInDayController.text),
          status: updateStatusController.text,
          addedBy: retrievedData!['user_id'],
          type: updateTypeController.text,
          toDate: convertDateFormat(date: updateToDateController.text),
          heatAttempt: int.parse(updateHeatAttemptController.text),
          stockList: stockList,
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        MedicineUpdateResponse medicineUpdateResponse = medicineUpdateResponseFromJson(response.data);
        stockList.clear();
        Get.back();
        Get.back();
        CattleToast.msg(medicineUpdateResponse.message);
      } else {
        CattleToast.msg(response.statusMessage!);
        print(response.statusCode);
      }
    } catch (error) {
      AppLoader().hide();
      CattleToast.msg(error.toString());
    }
  }

  Future<void> pendingVaccineCow(BuildContext context) async {
    AppLoader().show();
    pendingVaccineCowList.clear();
    print("API CALLED");
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.getPendingVaccineCow,
      body: pendingVaccineRequestToJson(
        PendingVaccineRequest(
          vacName: vaccineTypeController.text,
          shedId: shedIDController.text.isEmpty || shedIDController.text == 'Shed Id' ? '' : shedIDController.text,
          cowType: cowTypeController.text.isEmpty ||cowTypeController.text == 'Cow Type'? '' : cowTypeController.text,
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        print("RESPONSE GETED");
        PendingVaccineCowResponse pendingVaccineCowResponse = pendingVaccineCowResponseFromJson(response.data);
        pendingVaccineCowList.value = pendingVaccineCowResponse.pendingVaccineCowData;
        updateFilteredItemList("");

      } else {
        CattleToast.msg(response.statusMessage!);
        print(response.statusCode);
      }
    } catch (error) {
      AppLoader().hide();
      CattleToast.msg(error.toString());
    }
  }

  changeStatus(DataStatus value) => dataStatus(value);
}
