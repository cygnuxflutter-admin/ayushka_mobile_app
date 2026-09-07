import 'dart:convert';

PartialUpdateRequest partialUpdateRequestFromJson(String str) =>
    PartialUpdateRequest.fromJson(json.decode(str));

String partialUpdateRequestToJson(PartialUpdateRequest data) =>
    json.encode(data.toJson());

class PartialUpdateRequest {
  final bool isActive;

  PartialUpdateRequest({
    required this.isActive,
  });

  factory PartialUpdateRequest.fromJson(Map<String, dynamic> json) =>
      PartialUpdateRequest(
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
      };
}
