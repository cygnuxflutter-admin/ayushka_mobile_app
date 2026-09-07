import 'package:cattle_app/core/utils/pref_utils.dart';
import 'package:cattle_app/presentation/change_guashala_screen/models/change_guashala_request.dart';
import 'package:cattle_app/presentation/change_guashala_screen/models/change_guashala_response.dart';
import 'package:cattle_app/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../data/apiClient/api_client.dart';
import '../../data/apiClient/api_methods.dart';



class ChangeGuashalaScreenController extends GetxController {

  Future<void> getLatestAppVersion({required String GaushalaId}) async {
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.changeGuashala,
      body: changeGuashalaRequestToJson(ChangeGuashalaRequest(changeGaushalaId: GaushalaId)),
      token: PrefUtils.getToken.toString(),
    );

    try {
      if (response.statusCode == 200) {
        ChangeGuashalaResponse changeGuashalaResponse = changeGuashalaResponseFromJson(response.data);
        if (changeGuashalaResponse.status.toString() == "SUCCESS") {
          PrefUtils.setToken(changeGuashalaResponse.changeGuashalaData.token);
          PrefUtils.setGaushalaId(changeGuashalaResponse.changeGuashalaData.gaushalaId);
          Get.offAllNamed(AppRoutes.splashScreen);
        } else {
          print("****************status**************************");
          print("****************status**************************");
        }
      } else {
        print("*******************statusCode***********************");
        print(response.statusCode);
        print("*******************statusCode***********************");
      }
    } catch (error) {
      print("********************ERROR**********************");
      print(error.toString());
      print("********************ERROR**********************");
    }
    return;
  }
}
