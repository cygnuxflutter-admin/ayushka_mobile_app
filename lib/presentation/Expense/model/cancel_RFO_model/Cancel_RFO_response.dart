
import 'dart:convert';

CancelRfoResponse cancelRfoResponseFromJson(String str) => CancelRfoResponse.fromJson(json.decode(str));

String cancelRfoResponseToJson(CancelRfoResponse data) => json.encode(data.toJson());

class CancelRfoResponse {
  final String status;
  final String message;
  final CancelRfoData cancelRfoData;

  CancelRfoResponse({
    required this.status,
    required this.message,
    required this.cancelRfoData,
  });

  factory CancelRfoResponse.fromJson(Map<String, dynamic> json) => CancelRfoResponse(
    status: json["status"],
    message: json["message"],
    cancelRfoData: CancelRfoData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "CancelRfoData": cancelRfoData.toJson(),
  };
}

class CancelRfoData {
  final int deletedRfo;

  CancelRfoData({
    required this.deletedRfo,
  });

  factory CancelRfoData.fromJson(Map<String, dynamic> json) => CancelRfoData(
    deletedRfo: json["deletedRFO"],
  );

  Map<String, dynamic> toJson() => {
    "deletedRFO": deletedRfo,
  };
}
