class RetardDioModel {
  String tempoName;
  int tempoValue;

  RetardDioModel({
    this.tempoName = '',
    this.tempoValue = 1,
  });

  factory RetardDioModel.fromDocument(doc) {
    return RetardDioModel(
      tempoName: doc['tempoName'],
      tempoValue: doc['tempoValue'],
    );
  }

  factory RetardDioModel.fromJson(Map<String, dynamic> json) {
    return RetardDioModel(
      tempoName: json['tempoName'],
      tempoValue: json['tempoValue'],
    );
  }

  toJson(RetardDioModel doc) => {
        "tempoName": doc.tempoName,
        "tempoValue": doc.tempoValue,
      };
}
