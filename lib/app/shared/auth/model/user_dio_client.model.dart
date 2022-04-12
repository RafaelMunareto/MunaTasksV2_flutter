class UserDioClientModel {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic password;

  UserDioClientModel({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  factory UserDioClientModel.fromDocument(doc) {
    return UserDioClientModel(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      password: doc['password'],
    );
  }

  factory UserDioClientModel.fromMap(Map<String, dynamic> map) {
    return UserDioClientModel(
      id: map["_id"],
      name: map["name"],
      email: map["email"],
      password: map["password"],
    );
  }

  factory UserDioClientModel.fromJson(Map<String, dynamic> json) {
    return UserDioClientModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
      };
}
