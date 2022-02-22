class Comments {
  int? commentId;
  String? comment;
  double? rating;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? username;
  int? userId;
  int? restoranId;

  Comments(
      {this.commentId,
      this.comment,
      this.rating,
      this.status,
      this.createdAt,
      this.username,
      this.updatedAt,
      this.userId,
      this.restoranId});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    comment = json['comment'];
    rating = double.tryParse(json['rating'].toString());
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    username = json['username'];
    userId = json['user_id'];
    restoranId = json['restoran_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['comment_id'] = commentId;
    data['comment'] = comment;
    data['rating'] = rating;
    data['status'] = status;
    data['username'] = username;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['user_id'] = userId;
    data['restoran_id'] = restoranId;
    return data;
  }
}
