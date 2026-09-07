import 'dart:convert';

GetLatestAppVersionResponse getLatestAppVersionResponseFromJson(String str) => GetLatestAppVersionResponse.fromJson(json.decode(str));

String getLatestAppVersionResponseToJson(GetLatestAppVersionResponse data) => json.encode(data.toJson());

class GetLatestAppVersionResponse {
  final String status;
  final String message;
  final LatestAppVersionData latestAppVersionData;

  GetLatestAppVersionResponse({required this.status, required this.message, required this.latestAppVersionData});

  factory GetLatestAppVersionResponse.fromJson(Map<String, dynamic> json) => GetLatestAppVersionResponse(
    status: json["status"],
    message: json["message"],
    latestAppVersionData: LatestAppVersionData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"status": status, "message": message, "LatestAppVersionData": latestAppVersionData.toJson()};
}

class LatestAppVersionData {
  final String appVersion;
  final String appLink;
  final String dateTime;
  final int srNo;

  LatestAppVersionData({required this.appVersion, required this.appLink, required this.dateTime, required this.srNo});

  factory LatestAppVersionData.fromJson(Map<String, dynamic> json) => LatestAppVersionData(
    appVersion: json["appVersion"] ?? "",
    appLink: json["appLink"] ?? "",
    dateTime: json["dateTime"] ?? "",
    srNo: json["srNo"] ?? 0,
  );

  Map<String, dynamic> toJson() => {"appVersion": appVersion, "appLink": appLink, "dateTime": dateTime, "srNo": srNo};
}
