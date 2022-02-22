class User {
  int? userId;
  String? username;
  String? mail;
  String? password;
  String? role;
  bool? status;
  String? createdAt;
  String? updatedAt;

  User(
      {this.userId,
      this.username,
      this.mail,
      this.password,
      this.role,
      this.status,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    mail = json['mail'];
    password = json['password'];
    status = json['status'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['mail'] = mail;
    data['password'] = password;
    data['role'] = role;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
