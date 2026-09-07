import 'dart:convert';

AddBulkMilkRequest addBulkMilkRequestFromJson(String str) => AddBulkMilkRequest.fromJson(json.decode(str));

String addBulkMilkRequestToJson(AddBulkMilkRequest data) => json.encode(data.toJson());

class AddBulkMilkRequest {
  final List<bulkMIlkData> data;

  AddBulkMilkRequest({
    required this.data,
  });

  factory AddBulkMilkRequest.fromJson(Map<String, dynamic> json) => AddBulkMilkRequest(
    data: List<bulkMIlkData>.from(json["data"].map((x) => bulkMIlkData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class bulkMIlkData {
  final String cowTagId;
  final double liter;
  final String date;
  final String dayTime;
  final String remark;
  final String empRemarks;

  bulkMIlkData({
    required this.cowTagId,
    required this.liter,
    required this.date,
    required this.dayTime,
    required this.remark,
    required this.empRemarks,
  });

  factory bulkMIlkData.fromJson(Map<String, dynamic> json) => bulkMIlkData(
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
