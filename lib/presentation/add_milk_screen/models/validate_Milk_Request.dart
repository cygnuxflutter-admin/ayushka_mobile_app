
import 'dart:convert';

ValidateMilkRequest validateMilkRequestFromJson(String str) => ValidateMilkRequest.fromJson(json.decode(str));

String validateMilkRequestToJson(ValidateMilkRequest data) => json.encode(data.toJson());

class ValidateMilkRequest {
  final String cowTagId;
  final String date;
  final String dayTime;

  ValidateMilkRequest({
    required this.cowTagId,
    required this.date,
    required this.dayTime,
  });

  factory ValidateMilkRequest.fromJson(Map<String, dynamic> json) => ValidateMilkRequest(
    cowTagId: json["cow_tag_id"],
    date: json["date"],
    dayTime: json["day_time"],
  );

  Map<String, dynamic> toJson() => {
    "cow_tag_id": cowTagId,
    "date": date,
    "day_time": dayTime,
  };
}
