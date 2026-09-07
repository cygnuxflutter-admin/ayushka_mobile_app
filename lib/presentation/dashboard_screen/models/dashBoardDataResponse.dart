import 'dart:convert';

DashBoardDataResponse dashBoardDataResponseFromJson(String str) =>
    DashBoardDataResponse.fromJson(json.decode(str));

String dashBoardDataResponseToJson(DashBoardDataResponse data) =>
    json.encode(data.toJson());

class DashBoardDataResponse {
  final String status;
  final String message;
  final Data data;

  DashBoardDataResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DashBoardDataResponse.fromJson(Map<String, dynamic> json) =>
      DashBoardDataResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final double todaysMilk;
  final int milkingCows;
  final double todayMilkUsage;
  final double? morningMilk;
  final double? eveningMilk;
  final double? morningMilkUsage;
  final double? eveningMilkUsage;

  Data({
    required this.todaysMilk,
    required this.milkingCows,
    required this.todayMilkUsage,
    this.morningMilk,
    this.eveningMilk,
    this.morningMilkUsage,
    this.eveningMilkUsage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        todaysMilk: json["todaysMilk"]?.toDouble() ?? 0.0,
        milkingCows: json["milkingCows"] ?? 0,
        todayMilkUsage: json["todayMilkUsage"]?.toDouble() ?? 0.0,
        morningMilk: json["morningMilk"]?.toDouble() ?? 0.0,
        eveningMilk: json["eveningMilk"]?.toDouble() ?? 0.0,
        morningMilkUsage: json["morningMilkUsage"]?.toDouble() ?? 0.0,
        eveningMilkUsage: json["eveningMilkUsage"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "todaysMilk": todaysMilk,
        "milkingCows": milkingCows,
        "todayMilkUsage": todayMilkUsage,
        "morningMilk": morningMilk,
        "eveningMilk": eveningMilk,
        "morningMilkUsage": morningMilkUsage,
        "eveningMilkUsage": eveningMilkUsage,
      };
}

