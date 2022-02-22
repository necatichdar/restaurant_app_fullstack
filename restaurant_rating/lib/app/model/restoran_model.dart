import 'comment_model.dart';
import 'image_model.dart';

class Restoran {
  int? restoranId;
  String? name;
  String? description;
  String? lat;
  String? long;
  bool? status;
  String? createdAt;
  String? updatedAt;
  List<Comments>? comments;
  List<Images>? images;

  Restoran(
      {this.restoranId,
      this.name,
      this.description,
      this.lat,
      this.long,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.comments,
      this.images});

  Restoran.fromJson(Map<String, dynamic> json) {
    restoranId = json['restoran_id'];
    name = json['name'];
    description = json['description'];
    lat = json['lat'];
    long = json['long'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments?.add(Comments.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['restoran_id'] = restoranId;
    data['name'] = name;
    data['description'] = description;
    data['lat'] = lat;
    data['long'] = long;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (comments != null) {
      data['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
