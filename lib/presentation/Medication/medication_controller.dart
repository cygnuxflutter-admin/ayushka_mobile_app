import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:cattle_app/presentation/Medication/models/Add_New_Medicine_Request.dart';
import 'package:cattle_app/presentation/Medication/models/Add_New_Medicine_Response.dart';
import 'package:cattle_app/presentation/Medication/models/getPending_Medicine_Response.dart';
import 'package:cattle_app/presentation/Medication/models/medication_History_Request.dart';
import 'package:cattle_app/presentation/Medication/models/medication_History_Response.dart';
import 'package:cattle_app/presentation/Medication/upcoming_medications_screen.dart';
import 'package:cattle_app/presentation/common%20file/defaultVariablesList.dart';
import 'package:cattle_app/presentation/medical_report_screen/models/medicine_update_request.dart';

import '../../core/utils/pref_utils.dart';
import '../../data/apiClient/api_client.dart';
import '../../data/apiClient/api_methods.dart';
import '../../widgets/loder.dart';
import '../../widgets/toast_message/toast_message.dart';
import '../medical_report_screen/models/medicine_update_response.dart';
import 'models/getUpcomingMedications_response.dart';
import 'models/remove_medicine_request.dart';
import 'models/remove_medicine_response.dart';

enum MedicationDataStatus { loading, done, error }

class MedicationController extends GetxController {
  Rx<MedicationDataStatus> dataStatus = MedicationDataStatus.loading.obs;
  RxInt selectedSegment = 0.obs;
  RxString selectedVaccineType = ''.obs;
  RxList<GetPendingMedicineDatum> getPendingMedicineDatum = <GetPendingMedicineDatum>[].obs;
  RxList<UpcomingMedicationsDatum> getUpcomingMedication = <UpcomingMedicationsDatum>[].obs;
  RxList<GetPendingMedicineDatum> todayData = <GetPendingMedicineDatum>[].obs;
  RxList<GetPendingMedicineDatum> olderData = <GetPendingMedicineDatum>[].obs;
  RxList<MedicationHistoryDatum> medicineHistoryData = <MedicationHistoryDatum>[].obs;

  RxList<StockList> AddMedication = <StockList>[].obs;

  var filteredItemList = [''].obs;

  Map<String, dynamic>? retrievedData = PrefUtils.getData;

  RxBool isPregnant = false.obs;
  RxBool selectCow = false.obs;
  RxBool selectCustomTime = false.obs;
  RxBool UpComingMedicationCow = false.obs;
  RxBool upComingCows = false.obs;

  TextEditingController medicationCowId = TextEditingController();
  TextEditingController medicationType = TextEditingController();
  TextEditingController medicationVaccineName = TextEditingController();
  TextEditingController medicationDose = TextEditingController();
  TextEditingController medicationAttemptDose = TextEditingController();
  TextEditingController medicationGapInDay = TextEditingController();
  TextEditingController medicationDoseDate = TextEditingController();
  TextEditingController medicationNextDoseDate = TextEditingController();
  TextEditingController medicationMedicineNameController = TextEditingController();
  TextEditingController medicationMedicalIdController = TextEditingController();
  TextEditingController medicationRemarkController = TextEditingController();
  TextEditingController medicationStatusController = TextEditingController();
  TextEditingController medicationToDateController = TextEditingController();
  TextEditingController vaccineController = TextEditingController();

  RxString medicationNextDoseDateText = ''.obs;
  RxString medicationToDateDateText = ''.obs;

  TextEditingController addMedicationRemarkController = TextEditingController();
  TextEditingController addMedicationMedicineNameController = TextEditingController();
  TextEditingController addMedicationQtyController = TextEditingController();
  TextEditingController addMedicationStockController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxString searchQuery = ''.obs;

  DateTime nextDoseController = DateTime.now();
  DateTime toDateController = DateTime.now();

  GlobalKey<FormState> MedicineKey = GlobalKey<FormState>();
  GlobalKey<FormState> QtyKey = GlobalKey<FormState>();

  var tempTodayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void onInit() {
    retrieveCowData();
    getPendingMedicine();
    super.onInit();
    ever(searchQuery, (_) => applyFilters());
    ever(selectedSegment, (_) => applyFilters());
    ever(selectedVaccineType, (_) => applyFilters());
  }

  void applyFilters() {
    String query = searchQuery.value;
    String selectedType = '';
    if (selectedSegment.value == 0) {
      selectedType = 'VACCINE';
    } else if (selectedSegment.value == 1) {
      selectedType = 'HEAT';
    } else if (selectedSegment.value == 2) {
      selectedType = 'MEDICALCHECKUP';
    }
    
    List<GetPendingMedicineDatum> filtered = getPendingMedicineDatum;
    if (query.isNotEmpty) {
      filtered = filtered.where((data) => data.cowId.toLowerCase().contains(query.toLowerCase())).toList();
    }
    
    List<GetPendingMedicineDatum> tempToday = filtered.where((element) => element.nextDoseTime == tempTodayDate && element.type == selectedType).toList();
    List<GetPendingMedicineDatum> tempOlder = filtered.where((element) => element.nextDoseTime != tempTodayDate && element.type == selectedType).toList();

    String vacQuery = selectedVaccineType.value;
    if (vacQuery.isNotEmpty) {
      tempToday = tempToday.where((item) => item.vacName.contains(vacQuery)).toList();
      tempOlder = tempOlder.where((item) => item.vacName.contains(vacQuery)).toList();
    }
    
    todayData.assignAll(tempToday);
    olderData.assignAll(tempOlder);
  }

  UpComingMedicationOnTap({required UpcomingMedicationsDatum data}) {
    medicationVaccineName.text = data.vacName;
    medicationType.text = data.type;
    medicationAttemptDose.text = data.heatAttempt.toString();
    medicationGapInDay.text = data.gapInDay.toString();
    medicationDoseDate.text = data.date;
    medicationNextDoseDate.text = data.nextDoseTime;
    medicationNextDoseDateText.value = data.nextDoseTime;
    medicationDose.text = data.dose.toString();
    medicationMedicalIdController.text = data.medicalId.toString();
    medicationRemarkController.text = data.remark;
    medicationToDateController.text = data.toDate;
    medicationToDateDateText.value = data.toDate;
  }

  ToDayMedicationOnTap({required GetPendingMedicineDatum data}) {
    medicationVaccineName.text = data.vacName;
    medicationType.text = data.type;
    medicationAttemptDose.text = data.heatAttempt.toString();
    medicationGapInDay.text = data.gapInDay.toString();
    medicationDoseDate.text = data.date;
    medicationNextDoseDate.text = data.nextDoseTime;
    medicationNextDoseDateText.value = data.nextDoseTime;
    medicationDose.text = data.dose.toString();
    medicationMedicalIdController.text = data.medicalId.toString();
    medicationRemarkController.text = data.remark;
    medicationToDateController.text = data.toDate;
    medicationToDateDateText.value = data.toDate;
  }

  OlderMedicationOnTap({required GetPendingMedicineDatum data}) {
    medicationVaccineName.text = data.vacName;
    medicationType.text = data.type;
    medicationAttemptDose.text = data.heatAttempt.toString();
    medicationGapInDay.text = data.gapInDay.toString();
    medicationDoseDate.text = data.date;
    medicationNextDoseDate.text = data.nextDoseTime;
    medicationNextDoseDateText.value = data.nextDoseTime;
    medicationDose.text = data.dose.toString();
    medicationMedicalIdController.text = data.medicalId.toString();
    medicationRemarkController.text = data.remark;
    medicationToDateController.text = data.toDate;
    medicationToDateDateText.value = data.toDate;
  }

  bool isStock() {
    for (var item in itemMaster) {
      if (item.itemName == addMedicationStockController.text) {
        return item.isStock;
      }
    }
    return false;
  }

  String itemId() {
    for (var item in itemMaster) {
      if (item.itemName == medicationMedicineNameController.text) {
        return item.itemId;
      }
    }
    return '';
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

  RxString OUTUnitType() {
    for (var item in itemMaster) {
      if (item.itemName == medicationMedicineNameController.text) {
        return item.outUnitType.obs;
      }
    }
    return ''.obs;
  }

  String cowId({required String id}) {
    List<String> parts = id.split(' : ');
    String? desiredOutput;
    return desiredOutput = "${parts[0]}";
  }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("dd-MM-yyyy").parse(date);

    String formattedDate = DateFormat("yyyy-MM-dd").format(inputDate);

    return formattedDate;
  }



  Future<void> getUpcomingMedications() async {
    AppLoader().show();
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.upcomingMedications,
      body: '',
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        GetUpcomingMedicationsResponse getUpcomingMedicationsResponse = getUpcomingMedicationsResponseFromJson(response.data);
        getUpcomingMedication.value = getUpcomingMedicationsResponse.upcomingMedicationsData;
        Get.to(UpcomingMedicationScreen());
        CattleToast.msg(getUpcomingMedicationsResponse.message);
      } else {
        print(response.statusCode);
        CattleToast.msg(response.statusMessage!);
      }
    } catch (error) {
      AppLoader().hide();
      print(error);
      CattleToast.msg(error.toString());
    }
  }

  Future<void> getPendingMedicine() async {
    dataStatus.value = MedicationDataStatus.loading;
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.getPendingMedicine,
      body: '',
      token: PrefUtils.getToken.toString(),
    );

    try {
      if (response.statusCode == 200) {
        GetPendingMedicineResponse getPendingMedicineResponse = getPendingMedicineResponseFromJson(response.data);
        getPendingMedicineDatum.value = getPendingMedicineResponse.getPendingMedicineData;
        applyFilters();
        dataStatus.value = MedicationDataStatus.done;
      } else {
        dataStatus.value = MedicationDataStatus.error;
        print(response.statusCode);
        CattleToast.msg(response.statusMessage!);
      }
    } catch (error) {
      dataStatus.value = MedicationDataStatus.error;
      print(error);
      CattleToast.msg(error.toString());
    }
  }

  Future<void> addNewMedicine() async {
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.addNewMedicine,
      body: addNewMedicineRequestToJson(
        AddNewMedicineRequest(
          medicalId: int.parse(medicationMedicalIdController.text),
          itemId: itemId(),
          itemName: medicationMedicineNameController.text,
          count: double.parse(addMedicationQtyController.text),
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    try {
      if (response.statusCode == 200) {
        AddNewMedicineResponse addNewMedicineResponse =
            addNewMedicineResponseFromJson(response.data);
      } else {
        print(response.statusCode);
        CattleToast.msg(response.statusMessage!);
      }
    } catch (error) {
      print(error);
      CattleToast.msg(error.toString());
    }
  }

  Future<void> removeMedicine({
    required String itemId,
    required int medicalId,
  }) async {
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.removeMedicine,
      body: removeMedicineRequestToJson(
        RemoveMedicineRequest(
          medicalId: medicalId,
          itemId: itemId,
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    try {
      if (response.statusCode == 200) {
        RemoveMedicineResponse removeMedicineResponse = removeMedicineResponseFromJson(response.data);
      } else {
        print(response.statusCode);
        CattleToast.msg(response.statusMessage!);
      }
    } catch (error) {
      print(error);
      CattleToast.msg(error.toString());
    }
  }

  Future<void> medicineHistory({required medicalId}) async {
    AppLoader().show();
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.getMedicationHistory,
      body: medicationHistoryRequestToJson(
        MedicationHistoryRequest(
          medicalId: medicalId,
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        MedicationHistoryResponse medicationHistoryResponse = medicationHistoryResponseFromJson(response.data);
        medicineHistoryData.value = medicationHistoryResponse.medicationHistoryData;
        CattleToast.msg(medicationHistoryResponse.message);
      } else {
        print(response.statusCode);
        CattleToast.msg(response.statusMessage!);
      }
    } catch (error) {
      AppLoader().hide();
      print(error);
      CattleToast.msg(error.toString());
    }
  }

  List<GetPendingMedicineDatum> totalSelectFilter() {
    List<GetPendingMedicineDatum> selectCowList = [];
    for (var data in getPendingMedicineDatum) {
      if (data.isSelectCow.isTrue) {
        selectCowList.add(data);
      }
    }
    return selectCowList;
  }

  List<int> checkSelectID() {
    List<int> selectedID = [];

    if (selectCow.isTrue) {
      if (medicationType.text == 'VACCINE') {
        for (var data in todayData) {
          if (data.isSelectCow.value) {
            selectedID.add(data.medicalId);
          }
        }

        for (var data in olderData) {
          if (data.isSelectCow.value) {
            selectedID.add(data.medicalId);
          }
        }
      }
    } else {
      selectedID.add(int.parse(medicationMedicalIdController.text.isEmpty
          ? "0"
          : medicationMedicalIdController.text));
    }

    return selectedID;
  }

  Future<void> medicineUpdate(BuildContext context) async {
    AppLoader().show();
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.medicineUpdate,
      body: medicineUpdateRequestToJson(
        MedicineUpdateRequest(
          medicalIds: checkSelectID(),
          gaushalaId: PrefUtils.getGaushalaId.toString(),
          cowId: cowId(id: medicationCowId.text),
          vacName: medicationVaccineName.text,
          dose: medicationDose.text.isEmpty || medicationDose.text == ""
              ? 0
              : int.parse(medicationDose.text),
          nextDoseTime: selectCustomTime.value == true
              ? convertDateFormat(date: medicationNextDoseDate.text)
              : "",
          date: medicationDoseDate.text,
          remark: medicationRemarkController.text,
          medicalLogRemark: addMedicationRemarkController.text.isEmpty
              ? ''
              : addMedicationRemarkController.text,
          medicalLogDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          gapInDay:
              medicationGapInDay.text.isEmpty || medicationGapInDay.text == ""
                  ? 0
                  : int.parse(medicationGapInDay.text),
          status: medicationStatusController.text,
          addedBy: retrievedData!['user_id'],
          type: medicationType.text,
          toDate: medicationToDateController.text.isEmpty ||
                  medicationToDateController.text == ''
              ? "2030-01-01"
              : convertDateFormat(date: medicationToDateController.text),
          heatAttempt: medicationAttemptDose.text.isEmpty ||
                  medicationAttemptDose.text == ""
              ? 0
              : int.parse(medicationAttemptDose.text),
          stockList: AddMedication,
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        MedicineUpdateResponse medicineUpdateResponse = medicineUpdateResponseFromJson(response.data);
        applyFilters();
        AddMedication.clear();
        UpComingMedicationCow.value = false;
        addMedicationRemarkController.clear();
        selectCustomTime.value = false;
        selectCow.value = false;
        medicationVaccineName.clear();
        medicationCowId.clear();
        medicationType.clear();
        medicationAttemptDose.clear();
        medicationGapInDay.clear();
        medicationDoseDate.clear();
        medicationNextDoseDate.clear();
        medicationDose.clear();
        medicationMedicalIdController.clear();
        medicationRemarkController.clear();
        medicationToDateController.clear();
        if (upComingCows.isTrue) {
          upComingCows.value = false;
          Get.back();
          Get.back();
        } else {
          Get.back();
        }
        await getPendingMedicine();
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
}
