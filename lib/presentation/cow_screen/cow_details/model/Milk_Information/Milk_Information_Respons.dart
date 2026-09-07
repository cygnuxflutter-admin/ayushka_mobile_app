import 'dart:convert';

MilkInformationRespons milkInformationResponsFromJson(String str) => MilkInformationRespons.fromJson(json.decode(str));

String milkInformationResponsToJson(MilkInformationRespons data) => json.encode(data.toJson());

class MilkInformationRespons {
  final String status;
  final String message;
  final MilkInfoData milkInfoData;

  MilkInformationRespons({
    required this.status,
    required this.message,
    required this.milkInfoData,
  });

  factory MilkInformationRespons.fromJson(Map<String, dynamic> json) => MilkInformationRespons(
    status: json["status"],
    message: json["message"],
    milkInfoData: MilkInfoData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "milkInfoData": milkInfoData.toJson(),
  };
}

class MilkInfoData {
  final num currentYearTotalMilk;
  final num lastYearTotalMilk;
  final num totalMilk;

  MilkInfoData({
    required this.currentYearTotalMilk,
    required this.lastYearTotalMilk,
    required this.totalMilk,
  });

  factory MilkInfoData.fromJson(Map<String, dynamic> json) => MilkInfoData(
    currentYearTotalMilk: json["currentYearTotalMilk"]??0.0,
    lastYearTotalMilk: json["lastYearTotalMilk"]??0.0,
    totalMilk: json["TotalMilk"]??0.0,
  );

  Map<String, dynamic> toJson() => {
    "currentYearTotalMilk": currentYearTotalMilk,
    "lastYearTotalMilk": lastYearTotalMilk,
    "TotalMilk": totalMilk,
  };
}
