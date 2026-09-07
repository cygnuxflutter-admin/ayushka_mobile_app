import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';

import '../../core/utils/pref_utils.dart';
import '../../data/apiClient/api_client.dart';
import '../../data/apiClient/api_methods.dart';
import '../../widgets/loder.dart';
import 'model/Sair_Detail_Screen_request.dart';
import 'model/Sair_Detail_Screen_response.dart';


class SairDetailScreenController extends GetxController {

  RxList<SairDetailDatum> sairList = <SairDetailDatum>[].obs;
  TextEditingController sairID = TextEditingController();
  GlobalKey<FormState> sairIDKey = GlobalKey<FormState>();



  Future<void> SairDetail() async {
    sairList.clear();
    AppLoader().show();
    Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.getSairFamily,
      body: sairDetailRequestToJson(SairDetailRequest(sairId: sairID.text)),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        print("get Response");
        SairDetailResponse sairDetailResponse =
        sairDetailResponseFromJson(response.data);

        print("${sairDetailResponse.sairDetailData} ");
        sairList.addAll(sairDetailResponse.sairDetailData);

        print(response.statusCode);
        sairID.clear();
        Get.back();
      } else {
        print(response.statusCode);
      }
    } catch (error, s) {
      AppLoader().hide();
      print("${error} - ${s}");
    }
    return;
  }



}