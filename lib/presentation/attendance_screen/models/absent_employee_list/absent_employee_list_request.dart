import 'dart:convert';

AbsentEmployeeListRequest absentEmployeeListRequestFromJson(String str) =>
    AbsentEmployeeListRequest.fromJson(json.decode(str));

String absentEmployeeListRequestToJson(AbsentEmployeeListRequest data) =>
    json.encode(data.toJson());

class AbsentEmployeeListRequest {
  final String date;

  AbsentEmployeeListRequest({
    required this.date,
  });

  factory AbsentEmployeeListRequest.fromJson(Map<String, dynamic> json) =>
      AbsentEmployeeListRequest(
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
      };
}
