class RetardDioModel {
  String id;
  String tempoName;
  int tempoValue;

  RetardDioModel({
    this.id = '',
    this.tempoName = '',
    this.tempoValue = 1,
  });

  factory RetardDioModel.fromDocument(doc) {
    return RetardDioModel(
      id: doc['_id'],
      tempoName: doc['tempoName'],
      tempoValue: doc['tempoValue'],
    );
  }

  factory RetardDioModel.fromJson(Map<String, dynamic> json) {
    return RetardDioModel(
      id: json['_id'],
      tempoName: json['tempoName'],
      tempoValue: json['tempoValue'],
    );
  }

  toJson(RetardDioModel doc) => {
        "id": doc.id,
        "tempoName": doc.tempoName,
        "tempoValue": doc.tempoValue,
      };
}
