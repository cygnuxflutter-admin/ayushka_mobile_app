import 'dart:convert';

ChangeGuashalaRequest changeGuashalaRequestFromJson(String str) => ChangeGuashalaRequest.fromJson(json.decode(str));

String changeGuashalaRequestToJson(ChangeGuashalaRequest data) => json.encode(data.toJson());

class ChangeGuashalaRequest {
  final String changeGaushalaId;

  ChangeGuashalaRequest({
    required this.changeGaushalaId,
  });

  factory ChangeGuashalaRequest.fromJson(Map<String, dynamic> json) => ChangeGuashalaRequest(
    changeGaushalaId: json["change_gaushala_id"],
  );

  Map<String, dynamic> toJson() => {
    "change_gaushala_id": changeGaushalaId,
  };
}
