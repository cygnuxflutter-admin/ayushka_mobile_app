import 'dart:convert';

MonthlyReportRequest monthlyReportRequestFromJson(String str) => MonthlyReportRequest.fromJson(json.decode(str));

String monthlyReportRequestToJson(MonthlyReportRequest data) => json.encode(data.toJson());

class MonthlyReportRequest {
  final List<String> mail;
  final String reqYear;
  final String reqMonth;

  MonthlyReportRequest({
    required this.mail,
    required this.reqYear,
    required this.reqMonth,
  });

  factory MonthlyReportRequest.fromJson(Map<String, dynamic> json) => MonthlyReportRequest(
    mail: List<String>.from(json["mail"].map((x) => x)),
    reqYear: json["reqYear"],
    reqMonth: json["reqMonth"],
  );

  Map<String, dynamic> toJson() => {
    "mail": List<dynamic>.from(mail.map((x) => x)),
    "reqYear": reqYear,
    "reqMonth": reqMonth,
  };
}
