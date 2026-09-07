import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:cattle_app/core/utils/pref_utils.dart';
import 'package:cattle_app/widgets/alert_dialog.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../routes/app_routes.dart';

class WebService {
  static final Dio _dio = Dio();

  static final logger = Logger(
    printer: PrettyPrinter(),
  );

  static void initializeDio() {
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (Response response, handler) async {
        if (isUnAuthorized(response)) {
          await CattleAlertDialog(
            Get.context!,
            Sajesan: 'this user is login other device',
            onpressed: () {
              PrefUtils().clearPreferencesData();
              Get.offAllNamed(AppRoutes.loginScreen);
            },
            text: 'Continue',
            cancel: false,
          );
        }
        return handler.next(response);
      },
    ));
  }

  /// get api
  static Future<Response> cmGetRequestWithToken({required String url, required String body, required String token}) async {
    logger.i(url);
    logger.i(body);
    Response response = await _dio.get(
      url,
      options: Options(
        method: 'GET',
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token', // Add the Bearer token here
          'Content-Type': 'application/json',
        },
        responseType: ResponseType.plain,
      ),
    );
    logger.i(response);
    return response;
  }



  static Future<Response> getRequestWithToken({
    required String url,
    required String token,
  }) async {

    Response response = await _dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return response;
  }
  /// post api
  static Future<Response> cmPostWithoutTokenRequest({
    required String url,
    required String body,
  }) async {
    logger.i(url);
    logger.i(body);
    print(body);
    Response response = await _dio.post(
      url,
      data: body,
      options: Options(
        validateStatus: (status) => true,
        method: 'POST',
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        responseType: ResponseType.plain,
        receiveTimeout: Duration(seconds: 45),
      ),
    );
    logger.i(response);
    return response;
  }

  /// post With Token api
  static Future<Response> cmPostWithTokenRequest({
    required String url,
    required String body,
    required String token,
  }) async {
    logger.i(url);
    logger.i(body);
    print(body);
    Response response = await _dio.post(
      url,
      data: body,
      options: Options(
        validateStatus: (status) => true,
        method: 'POST',
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        responseType: ResponseType.plain,
        receiveTimeout: Duration(seconds: 45),
      ),
    );
    logger.i(response);
    return response;
  }

  // Multi Part
  // static Future<String> MultiPartRequest({required String url,
  //   required String items,
  //   required List<String> images}) async {
  //
  //   var headers = {'accept': '*/*'};
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(
  //       await http.MultipartFile.fromPath('items', items));
  //   request.files
  //       .add(await http.MultipartFile.fromPath('images', images.toString()));
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   print(response.statusCode);
  //
  //
  //   return await response.stream.bytesToString();
  // }
  static Future<String> MultiPartRequest({
    required String url,
    required String items,
    required List<String> images,
    required String token,
  }) async {
    logger.i(url);
    logger.i(items);

    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['items'] = items;
    for (String imagePath in images) {
      request.files.add(await http.MultipartFile.fromPath('images', imagePath));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    logger.i(response);
    return await response.stream.bytesToString();
  }
}

bool isUnAuthorized(Response response) {
  final int statusCode = response.statusCode!;
  if (statusCode == 401) return true;
  return false;
}
