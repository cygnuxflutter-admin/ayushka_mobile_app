import 'dart:convert';

AddMilkResponse addMilkResponseFromJson(String str) => AddMilkResponse.fromJson(json.decode(str));

String addMilkResponseToJson(AddMilkResponse data) => json.encode(data.toJson());

class AddMilkResponse {
  final String status;
  final String message;
  final Data data;

  AddMilkResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddMilkResponse.fromJson(Map<String, dynamic> json) => AddMilkResponse(
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
  final String cowTagId;
  final double liter;
  final String date;
  final String dayTime;
  final String remark;
  final bool isDeleted;
  final String id;

  Data({
    required this.cowTagId,
    required this.liter,
    required this.date,
    required this.dayTime,
    required this.remark,
    required this.isDeleted,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cowTagId: json["cow_tag_id"]??'',
    liter: json["liter"].toDouble()??0.0,
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
