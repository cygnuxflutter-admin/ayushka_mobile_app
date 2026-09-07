import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:cattle_app/core/utils/pref_utils.dart';
import 'package:cattle_app/data/apiClient/api_client.dart';
import 'package:cattle_app/data/apiClient/api_methods.dart';
import 'package:cattle_app/widgets/loder.dart';
import 'package:cattle_app/widgets/toast_message/toast_message.dart';
import '../../common file/defaultVariablesList.dart';
import 'package:cattle_app/presentation/cow_screen/Add_cow/models/addCowRequest.dart';
import 'package:cattle_app/presentation/cow_screen/Add_cow/models/addCowResponse.dart';
import 'package:cattle_app/presentation/cow_screen/models/combined_cow_shed_response.dart';
import '../../../routes/app_routes.dart';
import '../../add_milk_screen/models/Cow_Transfer_Request.dart';
import '../../add_milk_screen/models/Cow_Transfer_Response.dart';
import '../../milk_screen/controller/milk_controller.dart';
import '../../splashScreen/models/defaultVariables_response.dart';
import '../models/combined_cow_shed_request.dart';

enum DataStatus { loading, done, error }

class AddCowScreenController extends GetxController {
  Map<String, dynamic> args = Get.arguments;
  Map<String, dynamic>? retrievedData = PrefUtils.getData;
  Rx<DataStatus> dataStatus = DataStatus.loading.obs;

  MilkController milkController = Get.put(MilkController());

  @override
  void onInit() {
    retrieveCowData();
    getLastCowId();
    super.onInit();
  }

  late CowData cowData;

  CowTransferData? cowTransferData;

  TextEditingController breedController = TextEditingController();
  TextEditingController calfIDController = TextEditingController();
  TextEditingController calfNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController sairIdController = TextEditingController();
  TextEditingController cowTypeController = TextEditingController();
  TextEditingController damIdController = TextEditingController();
  TextEditingController newShedIdController = TextEditingController();
  TextEditingController cowWeightController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController purchaseDateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController ShedIdController = TextEditingController();
  TextEditingController RemarkController = TextEditingController();
  TextEditingController CowTypeController = TextEditingController();

  RxString lastCowId = ''.obs;
  RxString dobText = ''.obs;
  RxString purchaseDateText = ''.obs;

  GlobalKey<FormState> breedKey = GlobalKey<FormState>();
  GlobalKey<FormState> calfIDKey = GlobalKey<FormState>();
  GlobalKey<FormState> calfNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> genderKey = GlobalKey<FormState>();
  GlobalKey<FormState> sairIdKey = GlobalKey<FormState>();
  GlobalKey<FormState> cowTypeKey = GlobalKey<FormState>();
  GlobalKey<FormState> damIdKey = GlobalKey<FormState>();
  GlobalKey<FormState> newShedIdKey = GlobalKey<FormState>();
  GlobalKey<FormState> cowWeightKey = GlobalKey<FormState>();
  GlobalKey<FormState> CowTypeKey = GlobalKey<FormState>();
  GlobalKey<FormState> ShedIdKey = GlobalKey<FormState>();
  GlobalKey<FormState> RemarkKey = GlobalKey<FormState>();

  RxList<String> Gender = ['Female', 'Male'].obs;

  String findValueById(String id) {
    for (var item in bull) {
      if (item.id == id) {
        return item.value;
      }
    }
    return 'Not Found';
  }

  String findDameName(String id) {
    for (var name in milkController.cowList) {
      if (name.tagId == id) {
        return name.calfName;
      }
    }
    return '';
  }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("dd-MM-yyyy").parse(date);

    String formattedDate = DateFormat("yyyy-MM-dd").format(inputDate);

    return formattedDate;
  }

  Future<void> getLastCowId() async {
    try {

      Response response = await WebService.getRequestWithToken(
        url: "${ApiClient.getCowLastId}${PrefUtils.getGaushalaId}",
        token: PrefUtils.getToken!,
      );

      if (response.statusCode == 200) {
        lastCowId.value = response.data['data'];
        _changeStatus(DataStatus.done);
        debugPrint("Status Code : ${response.statusCode}");
        debugPrint("Cow Last ID : ${response.data}");

      } else {

        CattleToast.msg(response.statusMessage.toString());
        _changeStatus(DataStatus.error);

      }

    } catch (e) {

      debugPrint("API Error : $e");
      _changeStatus(DataStatus.error);

    }
  }

  CombinedCowShedRequest combinedCowShedRequest() {
    return CombinedCowShedRequest(
      cow: Cow(
        breed: breedController.text,
        tagId: calfIDController.text,
        dob: dobController.text.isEmpty || dobController.text == '' ? '' : convertDateFormat(date: dobController.text),
        calfName: calfNameController.text,
        isFemale: isFemale(),
        damId: args['tagId'].toString(),
        damName: args['calfName'],
        sairId: extractId(sairIdController.text),
        sairName: findValueById(extractId(sairIdController.text)),
        deliveryTime: timeController.text,
        sendDiedDate: 'NA',
        purchaseDate: 'NA',
        remark: remarkController.text,
        type: 'Hipper',
        shedId: args['shedId'],
        calfWeight: double.tryParse(cowWeightController.text) ?? 0.0,
      ),
      shed: Shed(
        userId: retrievedData!['user_id'],
        cowId: args['tagId'].toString(),
        oldShed: args['shedId'],
        dateTime: DateTime.now().toString(),
        newShed: newShedIdController.text,
        description: remarkController.text,
      ),
    );
  }

  AddCombinedCowTransfer(BuildContext context) async {
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.combinedCowShedApi,
      body: combinedCowShedRequestToJson(combinedCowShedRequest()),
      token: PrefUtils.getToken.toString(),
    );
    try {
      print(response.statusMessage);
      if (response.statusCode == 200) {
        CombinedCowShedResponse combinedCowShedResponse = combinedCowShedResponseFromJson(response.data);
        Get.offAllNamed(AppRoutes.dashboardScreen);
        print(response.statusCode);
        CattleToast.msg(combinedCowShedResponse.message);
      }
    } catch (e) {
      CattleToast.msg(e.toString());
      print("******************Catch**ERROR**********************");
      print(e.toString());
      print("********************ERROR**********************");
    }
  }

  Future<void> CowTransfer(BuildContext context) async {
    AppLoader().show();
    Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.cowTransfer,
      body: cowTransferRequestToJson(
        CowTransferRequest(
          userId: retrievedData!['user_id'],
          cowId: args['tagId'].toString(),
          oldShed: args['shedId'],
          dateTime: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now().toUtc()),
          newShed: ShedIdController.text,
          cowType: CowTypeController.text,
          description: RemarkController.text,
          gaushalaId: PrefUtils.getGaushalaId.toString(),
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        CowTransferResponse cowTransferResponse = await cowTransferResponseFromJson(response.data);
        cowTransferData = cowTransferResponse.cowTransferData;
        _changeStatus(DataStatus.done);
        RemarkController.clear();
        CattleToast.msg(cowTransferResponse.message);

        print(response.statusCode);
      } else {
        print("*******************statusCode***********************");
        print(response.statusCode);
        CattleToast.msg(response.statusMessage!);
        print("*******************statusCode***********************");
        _changeStatus(DataStatus.error);
      }
    } catch (error, s) {
      AppLoader().hide();
      print('##########################################################$s');
      print("******************Catch**ERROR**********************");
      print(error.toString());
      CattleToast.msg(error.toString());
      print("********************ERROR**********************");
      _changeStatus(DataStatus.error);
    }
    return;
  }

  bool isFemale() {
    if (genderController.text == 'Female') {
      return true;
    }
    return false;
  }

  String extractId(String input) {
    List<String> parts = input.split(" - ");
    String id = parts[0];
    return id;
  }

  newCowEntry() {
    if (breedKey.currentState!.validate() &&
        calfIDKey.currentState!.validate() &&
        calfNameKey.currentState!.validate() &&
        genderKey.currentState!.validate() &&
        cowTypeKey.currentState!.validate() &&
        newShedIdKey.currentState!.validate() &&
        cowWeightKey.currentState!.validate()) {
      addCowApi(
        addCowRequest: AddCowRequest(
          breed: breedController.text,
          tagId: calfIDController.text,
          dob: dobController.text.isEmpty || dobController.text == '' ? '' : convertDateFormat(date: dobController.text),
          calfName: calfNameController.text,
          isFemale: isFemale(),
          damId: damIdController.text.isEmpty ? 'NA' : extractId(damIdController.text),
          damName: findDameName(extractId(damIdController.text)),
          sairId: sairIdController.text.isEmpty ? 'NA' : extractId(sairIdController.text),
          sairName: findValueById(extractId(sairIdController.text)),
          deliveryTime: timeController.text,
          sendDiedDate: "NA",
          purchaseDate: purchaseDateController.text.isEmpty || purchaseDateController.text == '' ? "" : convertDateFormat(date: purchaseDateController.text),
          remark: remarkController.text.isEmpty ? " " : remarkController.text,
          type: cowTypeController.text,
          shedId: newShedIdController.text,
          calfWeight: double.tryParse(cowWeightController.text) ?? 0.0,
          gaushalaId: PrefUtils.getGaushalaId.toString(),
        ),
      );
    }
  }

  Future<void> addCowApi({required AddCowRequest addCowRequest}) async {
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.addCow,
      body: addCowRequestToJson(addCowRequest),
      token: PrefUtils.getToken.toString(),
    );
    try {
      if (response.statusCode == 200) {
        AddCowResponse addCowResponse = addCowResponseFromJson(response.data);
        if (addCowResponse.status == "SUCCESS") {
          Get.back();
          breedController.clear();
          genderController.clear();
          dobController.clear();
          dobText.value = '';
          purchaseDateController.clear();
          purchaseDateText.value = '';
          timeController.clear();
          cowTypeController.clear();
          damIdController.clear();
          sairIdController.clear();
          newShedIdController.clear();
          cowWeightController.clear();
          remarkController.clear();
          getLastCowId();
          CattleToast.msg(addCowResponse.message);
        } else {
          print(addCowResponse.status);
          CattleToast.msg(addCowResponse.message);
        }
      } else {
        print(response.statusCode);
        print(response.statusMessage.toString());
        CattleToast.msg(response.statusMessage.toString());
      }
    } catch (e) {
      print(e.toString());
      CattleToast.msg(e.toString());
    }
  }

  _changeStatus(DataStatus value) => dataStatus(value);
}
