import 'dart:convert';

SairDetailRequest sairDetailRequestFromJson(String str) => SairDetailRequest.fromJson(json.decode(str));

String sairDetailRequestToJson(SairDetailRequest data) => json.encode(data.toJson());

class SairDetailRequest {
  final String sairId;

  SairDetailRequest({
    required this.sairId,
  });

  factory SairDetailRequest.fromJson(Map<String, dynamic> json) => SairDetailRequest(
    sairId: json["sair_id"],
  );

  Map<String, dynamic> toJson() => {
    "sair_id": sairId,
  };
}
