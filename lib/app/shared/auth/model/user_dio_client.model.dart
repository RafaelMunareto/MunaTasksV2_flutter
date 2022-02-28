class UserDioClientModel {
  String id;
  String name;
  String email;

  UserDioClientModel({
    this.id = '',
    this.name = '',
    this.email = '',
  });

  factory UserDioClientModel.fromDocument(doc) {
    return UserDioClientModel(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
    );
  }

  factory UserDioClientModel.fromMap(Map<String, dynamic> map) {
    return UserDioClientModel(
      id: map["id"] as String,
      name: map["name"] as String,
      email: map["email"] as String,
    );
  }
  toMap() => {
        "id": id,
        "name": name,
        "email": email,
      };

  factory UserDioClientModel.fromJson(Map<String, dynamic> json) {
    return UserDioClientModel(
        id: json['id'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
