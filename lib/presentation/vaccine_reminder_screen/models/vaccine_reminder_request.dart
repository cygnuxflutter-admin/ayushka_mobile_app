import 'dart:convert';

VaccineReminderRequest vaccineReminderRequestFromJson(String str) => VaccineReminderRequest.fromJson(json.decode(str));

String vaccineReminderRequestToJson(VaccineReminderRequest data) => json.encode(data.toJson());

class VaccineReminderRequest {
  VaccineReminderRequest({
    required this.query,
    required this.options,
  });

  Query query;
  Options options;

  factory VaccineReminderRequest.fromJson(Map<String, dynamic> json) => VaccineReminderRequest(
        query: Query.fromJson(json["query"]),
        options: Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "query": query.toJson(),
        "options": options.toJson(),
      };
}

class Options {
  Options({
    required this.page,
    required this.limit,
    required this.pagination,
  });

  int page;
  int limit;
  bool pagination;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        page: json["page"],
        limit: json["limit"],
        pagination: json["pagination"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "pagination": pagination,
      };
}

class Query {
  Query({
    this.tagId,
  });

  String? tagId;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        tagId: json["tag_id"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tagId != null && tagId!.isNotEmpty) {
      data["tag_id"] = tagId;
    }
    return data;
  }
}
