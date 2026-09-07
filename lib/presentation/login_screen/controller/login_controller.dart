


import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:cattle_app/core/utils/pref_utils.dart';
import 'package:cattle_app/data/apiClient/api_client.dart';
import 'package:cattle_app/data/apiClient/api_methods.dart';
import 'package:cattle_app/presentation/login_screen/models/login_req.dart';
import 'package:cattle_app/presentation/login_screen/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:cattle_app/presentation/login_screen/models/login_res.dart';
import 'package:cattle_app/routes/app_routes.dart';
import 'package:cattle_app/widgets/loder.dart';
import 'package:cattle_app/widgets/toast_message/toast_message.dart';
/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj

enum DataStatus { loading, done, error }

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Rx<LoginModel> loginModelObj = LoginModel().obs;

  Rx<bool> isShowPassword = true.obs;

  Rx<DataStatus> dataStatus = DataStatus.loading.obs;

  LoginRes? loginRes;

  LoginRes? loginRes400;

  Data? loginData;


  @override
  void onClose() {
    super.onClose();
    usernameController.dispose();
    passwordController.dispose();
  }

  Future<void> cmLogin(BuildContext context) async {
    AppLoader().show();
    Response? response;
    try {
      response = await WebService.cmPostWithoutTokenRequest(
        url: ApiClient.loginUrl,
        body: loginReqToJson(
          LoginReq(
            username: usernameController.text,
            password: passwordController.text,
          ),
        ),
      );
    } on DioException catch (dioError) {
      // Handle connection errors gracefully
      CattleToast.msg('Unable to connect to server. Please check your network.');
      print('DioException: ${dioError.message}');
    } catch (e) {
      CattleToast.msg('Unexpected error occurred.');
      print('Error: $e');
    } finally {
      AppLoader().hide();
    }

    if (response == null) return;
    try {
      if (response.statusCode == 200) {
        loginRes = loginResFromJson(response.data);
        if (loginRes != null && loginRes!.status.toString() == "SUCCESS") {
          loginData = loginRes!.data;
          PrefUtils.setToken(loginData!.token);
          PrefUtils.setUserType(loginData!.userType);
          PrefUtils.setIsLogin(true);
          PrefUtils.setGaushalaId(loginData!.gaushalaId);
          PrefUtils.setData(loginData!.toJson());
          Get.offAllNamed(AppRoutes.dashboardScreen);
          CattleToast.msg(loginRes!.message);
          _changeStatus(DataStatus.done);
        } else {
          print("****************status**************************");
          print(loginRes?.status);
          print("****************status**************************");
          _changeStatus(DataStatus.error);
        }
      } else {
        CattleToast.msg(loginRes?.message ?? 'Server error');
        print("*******************statusCode***********************");
        print(response.statusCode);
        print("*******************statusCode***********************");
        _changeStatus(DataStatus.error);
      }
    } catch (error) {
      CattleToast.msg(error.toString());
      _changeStatus(DataStatus.error);
      print("********************ERROR**********************");
      print(error.toString());
    }
  }


  _changeStatus(DataStatus value) => dataStatus(value);
}
