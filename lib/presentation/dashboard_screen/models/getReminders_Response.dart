// To parse this JSON data, do
//
//     final getRemindersResponse = getRemindersResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetRemindersResponse getRemindersResponseFromJson(String str) => GetRemindersResponse.fromJson(json.decode(str));

String getRemindersResponseToJson(GetRemindersResponse data) => json.encode(data.toJson());

class GetRemindersResponse {
  final String status;
  final String message;
  final GetReminderData getReminderData;

  GetRemindersResponse({
    required this.status,
    required this.message,
    required this.getReminderData,
  });

  factory GetRemindersResponse.fromJson(Map<String, dynamic> json) => GetRemindersResponse(
    status: json["status"],
    message: json["message"],
    getReminderData: GetReminderData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "GetReminderData": getReminderData.toJson(),
  };
}

class GetReminderData {
  final Obj pendingMedicationsObj;
  final Obj getPendingMilkingCowsObj;
  final Obj stockOutObj;
  final Obj? pendingVaccinesObj;

  GetReminderData({
    required this.pendingMedicationsObj,
    required this.getPendingMilkingCowsObj,
    required this.stockOutObj,
    this.pendingVaccinesObj,
  });

  factory GetReminderData.fromJson(Map<String, dynamic> json) => GetReminderData(
    pendingMedicationsObj: Obj.fromJson(json["pendingMedicationsObj"]),
    getPendingMilkingCowsObj: Obj.fromJson(json["getPendingMilkingCowsObj"]),
    stockOutObj: Obj.fromJson(json["stockOutObj"]),
    pendingVaccinesObj: json["pendingVaccinesObj"] == null ? null : Obj.fromJson(json["pendingVaccinesObj"]),
  );

  Map<String, dynamic> toJson() => {
    "pendingMedicationsObj": pendingMedicationsObj.toJson(),
    "getPendingMilkingCowsObj": getPendingMilkingCowsObj.toJson(),
    "stockOutObj": stockOutObj.toJson(),
    "pendingVaccinesObj": pendingVaccinesObj?.toJson(),
  };
}

class Obj {
  final String content;
  final int action;
  final String htmlContent;

  Obj({
    required this.content,
    required this.action,
    required this.htmlContent,
  });

  factory Obj.fromJson(Map<String, dynamic> json) => Obj(
    content: json["content"],
    action: json["action"],
    htmlContent: json["htmlContent"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "action": action,
    "htmlContent": htmlContent,
  };
}
