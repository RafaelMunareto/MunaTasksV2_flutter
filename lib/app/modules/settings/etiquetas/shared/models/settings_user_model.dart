class SettingsUserModel {
  String user;
  String emailInicial;
  String emailFinal;
  String mobile;

  SettingsUserModel({
    this.user = '',
    this.emailInicial = 's',
    this.emailFinal = 's',
    this.mobile = 's',
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
