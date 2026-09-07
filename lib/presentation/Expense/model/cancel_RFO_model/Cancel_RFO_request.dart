import 'dart:convert';

CancelRfoRequest cancelRfoRequestFromJson(String str) => CancelRfoRequest.fromJson(json.decode(str));

String cancelRfoRequestToJson(CancelRfoRequest data) => json.encode(data.toJson());

class CancelRfoRequest {
  final String rfoNo;

  CancelRfoRequest({
    required this.rfoNo,
  });

  factory CancelRfoRequest.fromJson(Map<String, dynamic> json) => CancelRfoRequest(
    rfoNo: json["RFO_no"],
  );

  Map<String, dynamic> toJson() => {
    "RFO_no": rfoNo,
  };
}
