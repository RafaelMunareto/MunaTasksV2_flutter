import 'package:cloud_firestore/cloud_firestore.dart';

class UserMenuModel {
  String uid;
  String name;
  String imgUrl;
  UserMenuModel({
    this.uid = '',
    this.name = '',
    this.imgUrl =
        'https://firebasestorage.googleapis.com/v0/b/munatasksv2.appspot.com/o/allPeople.png?alt=media&token=19a38226-7467-4f83-a201-20214af45bc1',
  });

  factory UserMenuModel.fromDocument(DocumentSnapshot doc) {
    return UserMenuModel(
      uid: doc['uid'],
      name: doc['name'],
      imgUrl: doc['imgUrl'],
    );
  }

  factory UserMenuModel.fromJson(Map<String, dynamic> json) {
    return UserMenuModel(
      uid: json['uid'],
      name: json['name'],
      imgUrl: json['imgUrl'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
