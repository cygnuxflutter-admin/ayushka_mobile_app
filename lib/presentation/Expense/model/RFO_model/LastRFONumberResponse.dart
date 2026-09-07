import 'package:meta/meta.dart';
import 'dart:convert';

LastRfoNumberResponse lastRfoNumberResponseFromJson(String str) => LastRfoNumberResponse.fromJson(json.decode(str));

String lastRfoNumberResponseToJson(LastRfoNumberResponse data) => json.encode(data.toJson());

class LastRfoNumberResponse {
  final String status;
  final String message;
  final String lastRfoData;

  LastRfoNumberResponse({
    required this.status,
    required this.message,
    required this.lastRfoData,
  });

  factory LastRfoNumberResponse.fromJson(Map<String, dynamic> json) => LastRfoNumberResponse(
    status: json["status"],
    message: json["message"],
    lastRfoData: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "LastRfoData": lastRfoData,
  };
}
