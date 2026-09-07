import 'dart:convert';

AddMilkHistoryResponse addMilkHistoryResponseFromJson(String str) => AddMilkHistoryResponse.fromJson(json.decode(str));

String addMilkHistoryResponseToJson(AddMilkHistoryResponse data) => json.encode(data.toJson());

class AddMilkHistoryResponse {
  final String status;
  final String message;
  final Milkdata milkdata;

  AddMilkHistoryResponse({
    required this.status,
    required this.message,
    required this.milkdata,
  });

  factory AddMilkHistoryResponse.fromJson(Map<String, dynamic> json) => AddMilkHistoryResponse(
    status: json["status"],
    message: json["message"],
    milkdata: Milkdata.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "milkdata": milkdata.toJson(),
  };
}

class Milkdata {
  final String todayMorningMilkCount;
  final String todayEveningMilkCount;
  final String cowsLastMilkLiter;
  final List<TodayMilkFiltered> todayMilkFiltered;

  Milkdata({
    required this.todayMorningMilkCount,
    required this.todayEveningMilkCount,
    required this.cowsLastMilkLiter,
    required this.todayMilkFiltered,
  });

  factory Milkdata.fromJson(Map<String, dynamic> json) => Milkdata(
    todayMorningMilkCount: json["todayMorningMilkCount"],
    todayEveningMilkCount: json["todayEveningMilkCount"],
    cowsLastMilkLiter: json["cowsLastMilkLiter"],
    todayMilkFiltered: List<TodayMilkFiltered>.from(json["todayMilkFiltered"].map((x) => TodayMilkFiltered.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
    "todayMorningMilkCount": todayMorningMilkCount,
    "todayEveningMilkCount": todayEveningMilkCount,
    "cowsLastMilkLiter": cowsLastMilkLiter,
    "todayMilkFiltered": List<dynamic>.from(todayMilkFiltered.map((x) => x.toJson())),
  };

  double lastMilkInDouble(){
    return double.tryParse(cowsLastMilkLiter) ?? 0.0;
  }



}

class TodayMilkFiltered {
  final String cowTagId;
  final double liter;
  final String date;
  final String dayTime;
  final String remark;
  final bool isDeleted;
  final String id;

  TodayMilkFiltered({
    required this.cowTagId,
    required this.liter,
    required this.date,
    required this.dayTime,
    required this.remark,
    required this.isDeleted,
    required this.id,
  });


  factory TodayMilkFiltered.fromJson(Map<String, dynamic> json) => TodayMilkFiltered(
    cowTagId: json["cow_tag_id"]??'',
    liter: json["liter"]?.toDouble(),
    date: json["date"]??'',
    dayTime: json["day_time"]??'',
    remark: json["remark"]??'',
    isDeleted: json["isDeleted"]??false,
    id: json["id"]??'',
  );
  Map<String, dynamic> toJson() => {
    "cow_tag_id": cowTagId,
    "liter": liter,
    "date": date,
    "day_time": dayTime,
    "remark": remark,
    "isDeleted": isDeleted,
    "id": id,
  };
}
