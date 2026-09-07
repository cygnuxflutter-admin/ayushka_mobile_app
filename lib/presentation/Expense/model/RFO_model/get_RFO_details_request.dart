import 'dart:convert';

GetRfoDetailsRequest getRfoDetailsRequestFromJson(String str) => GetRfoDetailsRequest.fromJson(json.decode(str));

String getRfoDetailsRequestToJson(GetRfoDetailsRequest data) => json.encode(data.toJson());

class GetRfoDetailsRequest {
  final String rfoNo;

  GetRfoDetailsRequest({
    required this.rfoNo,
  });

  factory GetRfoDetailsRequest.fromJson(Map<String, dynamic> json) => GetRfoDetailsRequest(
    rfoNo: json["RFO_no"],
  );

  Map<String, dynamic> toJson() => {
    "RFO_no": rfoNo,
  };
}
