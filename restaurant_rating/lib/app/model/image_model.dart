
class Images {
  int? id;
  String? imagePath;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? restoranId;

  Images(
      {this.id,
      this.imagePath,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.restoranId});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['image_path'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['user_id'];
    restoranId = json['restoran_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image_path'] = imagePath;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['user_id'] = userId;
    data['restoran_id'] = restoranId;
    return data;
  }
}
