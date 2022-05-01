class FaseDioModel {
  String? id;
  String color;
  String name;
  int icon;
  String status;

  FaseDioModel(
      {this.id = '',
      this.color = '',
      this.name = '',
      this.icon = 0,
      this.status = ''});

  factory FaseDioModel.fromDocument(doc) {
    return FaseDioModel(
      id: doc['id'],
      color: doc['color'],
      name: doc['name'],
      icon: doc['icon'],
      status: doc['status'],
    );
  }

  factory FaseDioModel.fromJson(Map<String, dynamic> json) {
    return FaseDioModel(
      id: json['id'],
      color: json['color'],
      name: json['name'],
      icon: json['icon'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
