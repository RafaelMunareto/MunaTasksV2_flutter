class SettingsUserModel {
  String user;
  bool emailInicial;
  bool emailFinal;
  bool mobile;

  SettingsUserModel({
    this.user = '',
    this.emailInicial = true,
    this.emailFinal = true,
    this.mobile = true,
  });

  factory SettingsUserModel.fromDocument(doc) {
    return SettingsUserModel(
      user: doc['user'],
      emailInicial: doc['emailInicial'],
      emailFinal: doc['emailFinal'],
      mobile: doc['mobile'],
    );
  }

  factory SettingsUserModel.fromJson(json) {
    return SettingsUserModel(
      user: json['user'],
      emailInicial: json['emailInicial'],
      emailFinal: json['emailFinal'],
      mobile: json['mobile'],
    );
  }

  toJson(SettingsUserModel model) => {
        "user": model.user,
        "emailInicial": model.emailInicial,
        "emailFinal": model.emailFinal,
        "mobile": model.mobile,
      };
}
