class SettingsUserModel {
  String user;
  bool emailInicial;
  bool emailFinal;
  bool mobile;
  bool theme;

  SettingsUserModel({
    this.user = '',
    this.emailInicial = true,
    this.emailFinal = true,
    this.mobile = true,
    this.theme = false,
  });

  factory SettingsUserModel.fromDocument(doc) {
    return SettingsUserModel(
      user: doc['user'],
      emailInicial: doc['emailInicial'],
      emailFinal: doc['emailFinal'],
      mobile: doc['mobile'],
      theme: doc['theme'],
    );
  }

  factory SettingsUserModel.fromJson(json) {
    return SettingsUserModel(
      user: json['user'],
      emailInicial: json['emailInicial'],
      emailFinal: json['emailFinal'],
      mobile: json['mobile'],
      theme: json['theme'],
    );
  }

  toJson(SettingsUserModel model) => {
        "user": model.user,
        "emailInicial": model.emailInicial,
        "emailFinal": model.emailFinal,
        "mobile": model.mobile,
        "theme": model.theme,
      };
}
