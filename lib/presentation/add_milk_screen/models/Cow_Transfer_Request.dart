import 'dart:convert';

CowTransferRequest cowTransferRequestFromJson(String str) => CowTransferRequest.fromJson(json.decode(str));

String cowTransferRequestToJson(CowTransferRequest data) => json.encode(data.toJson());

class CowTransferRequest {
  final String userId;
  final String cowId;
  final String oldShed;
  final String dateTime;
  final String newShed;
  final String cowType;
  final String description;
  final String gaushalaId;

  CowTransferRequest( {
    required this.userId,
    required this.cowId,
    required this.oldShed,
    required this.dateTime,
    required this.newShed,
    required this.cowType,
    required this.description,
    required this.gaushalaId,
  });

  factory CowTransferRequest.fromJson(Map<String, dynamic> json) => CowTransferRequest(
    userId: json["userId"],
    cowId: json["cowId"],
    oldShed: json["oldShed"],
    dateTime: json["dateTime"],
    newShed: json["newShed"],
    cowType: json["cowType"],
    description: json["description"],
    gaushalaId: json["gaushalaId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "cowId": cowId,
    "oldShed": oldShed,
    "dateTime": dateTime,
    "newShed": newShed,
    "cowType": cowType,
    "description": description,
    "gaushalaId": gaushalaId,
  };
}
