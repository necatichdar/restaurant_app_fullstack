class AllParameters {
  int? id;
  String? title;
  String? description;
  String? role;

  AllParameters({this.id, this.title, this.description, this.role});

  AllParameters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['role'] = role;
    return data;
  }
}
