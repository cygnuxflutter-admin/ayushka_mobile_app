import 'dart:convert';

AddMilkRequest addMilkRequestFromJson(String str) => AddMilkRequest.fromJson(json.decode(str));

String addMilkRequestToJson(AddMilkRequest data) => json.encode(data.toJson());

class AddMilkRequest {
  final String cowTagId;
  final double liter;
  final String date;
  final String dayTime;
  final String remark;
  final String empRemarks;

  AddMilkRequest({
    required this.cowTagId,
    required this.liter,
    required this.date,
    required this.dayTime,
    required this.remark,
    required this.empRemarks,
  });

  factory AddMilkRequest.fromJson(Map<String, dynamic> json) => AddMilkRequest(
    cowTagId: json["cow_tag_id"],
    liter: json["liter"],
    date: json["date"],
    dayTime: json["day_time"],
    remark: json["remark"],
    empRemarks: json["emp_remarks"],
  );

  Map<String, dynamic> toJson() => {
    "cow_tag_id": cowTagId,
    "liter": liter,
    "date": date,
    "day_time": dayTime,
    "remark": remark,
    "emp_remarks": empRemarks,
  };
}