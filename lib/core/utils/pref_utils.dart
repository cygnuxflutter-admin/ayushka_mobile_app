import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  ///set
  static setToken(String? value) async =>
      await _sharedPreferences!.setString(SharedKey.token, value ?? '');
  static setUserType(int? value) async =>
      await _sharedPreferences!.setInt(SharedKey.userType, value ?? 0);
  static setGaushalaId(String? value) async =>
      await _sharedPreferences!.setString(SharedKey.gaushalaId, value ?? '');

  static setIsLogin(bool value) async =>
      await _sharedPreferences!.setBool(SharedKey.isLogin, value);
  static setSelectPrint(bool value) async =>
      await _sharedPreferences!.setBool(SharedKey.selectPrint, value);

  static setData(Map<String, dynamic> data) async {
    String dataJson = json.encode(data);
    _sharedPreferences!.setString(SharedKey.data, dataJson);
  }
  static setDefaultVariables(String data) async {
    _sharedPreferences!.setString(SharedKey.defaultVariables, data);
  }


  ///get
  static String? get getToken =>
      _sharedPreferences!.getString(SharedKey.token) ?? '';
  static String? get getGaushalaId =>
      _sharedPreferences!.getString(SharedKey.gaushalaId) ?? '';
 static int? get getUserType =>
      _sharedPreferences!.getInt(SharedKey.userType) ?? 0;

  static bool? get getIsLogin =>
      _sharedPreferences!.getBool(SharedKey.isLogin) ?? false;
  static bool? get getSelectPrint =>
      _sharedPreferences!.getBool(SharedKey.selectPrint) ?? false;

  static Map<String, dynamic>? get getData {
    String dataJson = _sharedPreferences!.getString(SharedKey.data) ?? '';

    if (dataJson.isNotEmpty) {
      return json.decode(dataJson);
    } else {
      return null;
    }
  }

  static String? getDefaultVariables() {
    return _sharedPreferences!.getString(SharedKey.defaultVariables);
  }




}

class SharedKey {
  static String token = "token";
  static String userType = "userType";
  static String isLogin = "isLogin";
  static String data = "data";
  static String defaultVariables = "defaultVariables";
  static String gaushalaId = "gaushalaId";
  static String selectPrint = "selectPrint";
}
