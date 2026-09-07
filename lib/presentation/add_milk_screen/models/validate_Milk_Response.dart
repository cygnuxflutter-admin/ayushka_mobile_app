import 'dart:convert';

ValidateMilkResponse validateMilkResponseFromJson(String str) => ValidateMilkResponse.fromJson(json.decode(str));

String validateMilkResponseToJson(ValidateMilkResponse data) => json.encode(data.toJson());

class ValidateMilkResponse {
  final String status;
  final String message;
  final ValidateMilkData validateMilkData;

  ValidateMilkResponse({
    required this.status,
    required this.message,
    required this.validateMilkData,
  });

  factory ValidateMilkResponse.fromJson(Map<String, dynamic> json) => ValidateMilkResponse(
    status: json["status"],
    message: json["message"],
    validateMilkData: ValidateMilkData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "validateMilkData": validateMilkData.toJson(),
  };
}

class ValidateMilkData {
  final bool isValid;
  final String data;

  ValidateMilkData({
    required this.isValid,
    required this.data,
  });

  factory ValidateMilkData.fromJson(Map<String, dynamic> json) => ValidateMilkData(
    isValid: json["isValid"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "isValid": isValid,
    "data": data,
  };
}
