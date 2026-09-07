
class NodeModel {
  String id;
  String label;
  String gender;
  String type;
  String breed;

  NodeModel({
    required this.id,
    required this.label,
    required this.gender,
    required this.type,
    required this.breed,
  });

  factory NodeModel.fromJson(Map<String, dynamic> json) {
    return NodeModel(
      id: json['id'],
      label: json['label'],
      gender: json['gender'],
      type: json['type'],
      breed: json['breed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'gender': gender,
      'type': type,
      'breed':breed,
    };
  }
}

class EdgeModel {
  String from;
  String to;

  EdgeModel({required this.from, required this.to});

  factory EdgeModel.fromJson(Map<String, dynamic> json) {
    return EdgeModel(from: json['from'], to: json['to']);
  }

  Map<String, dynamic> toJson() {
    return {'from': from, 'to': to};
  }
}
