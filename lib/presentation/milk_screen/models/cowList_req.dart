import 'dart:convert';

CowListReq cowListReqFromJson(String str) => CowListReq.fromJson(json.decode(str));

String cowListReqToJson(CowListReq data) => json.encode(data.toJson());

class CowListReq {
  final Query query;
  final Options options;
  final bool isCountOnly;

  CowListReq({
    required this.query,
    required this.options,
    required this.isCountOnly,
  });

  factory CowListReq.fromJson(Map<String, dynamic> json) => CowListReq(
    query: Query.fromJson(json["query"]),
    options: Options.fromJson(json["options"]),
    isCountOnly: json["isCountOnly"],
  );

  Map<String, dynamic> toJson() => {
    "query": query.toJson()??{},
    "options": options.toJson(),
    "isCountOnly": isCountOnly,
  };
}

class Options {
  final List<String> select;
  final String collation;
  final String sort;
  final String populate;
  final String projection;
  final bool lean;
  final bool leanWithId;
  final int offset;
  final int page;
  final int limit;
  final bool pagination;
  final bool useEstimatedCount;
  final bool useCustomCountFn;
  final bool forceCountFn;
  final Query read;
  final Query options;

  Options({
    required this.select,
    required this.collation,
    required this.sort,
    required this.populate,
    required this.projection,
    required this.lean,
    required this.leanWithId,
    required this.offset,
    required this.page,
    required this.limit,
    required this.pagination,
    required this.useEstimatedCount,
    required this.useCustomCountFn,
    required this.forceCountFn,
    required this.read,
    required this.options,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
    select: List<String>.from(json["select"].map((x) => x)),
    collation: json["collation"],
    sort: json["sort"],
    populate: json["populate"],
    projection: json["projection"],
    lean: json["lean"],
    leanWithId: json["leanWithId"],
    offset: json["offset"],
    page: json["page"],
    limit: json["limit"],
    pagination: json["pagination"],
    useEstimatedCount: json["useEstimatedCount"],
    useCustomCountFn: json["useCustomCountFn"],
    forceCountFn: json["forceCountFn"],
    read: Query.fromJson(json["read"]),
    options: Query.fromJson(json["options"]),
  );

  Map<String, dynamic> toJson() => {
    "select": List<dynamic>.from(select.map((x) => x)),
    "collation": collation,
    "sort": sort,
    "populate": populate,
    "projection": projection,
    "lean": lean,
    "leanWithId": leanWithId,
    "offset": offset,
    "page": page,
    "limit": limit,
    "pagination": pagination,
    "useEstimatedCount": useEstimatedCount,
    "useCustomCountFn": useCustomCountFn,
    "forceCountFn": forceCountFn,
    "read": read.toJson(),
    "options": options.toJson(),
  };
}

class Query {
  Query();

  factory Query.fromJson(Map<String, dynamic> json) => Query(
  );

  Map<String, dynamic> toJson() => {
  };
}
