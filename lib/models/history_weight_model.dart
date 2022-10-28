class HistoryWeights {
  int? code;
  String? serverTime;
  String? message;
  late Data _data;
  Data get data => _data;

  HistoryWeights(
      {required code, required serverTime, required message, required data}) {
    code = code;
    serverTime = serverTime;
    message = message;
    _data = data;
  }

  HistoryWeights.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    serverTime = json['ServerTime'];
    message = json['Message'];
    _data = Data.fromJson(json['Data']);
  }
}

class Data {
  late List<HistoryWeightModel> _historyWeightModels;
  List<HistoryWeightModel> get historyWeightModels => _historyWeightModels;

  Data({required historyWeightModels}) {
    _historyWeightModels = historyWeightModels;
  }

  Data.fromJson(Map<String, dynamic> json) {
    if (json['DeliveryDetails'] != null) {
      _historyWeightModels = <HistoryWeightModel>[];
      json['DeliveryDetails'].forEach((v) {
        _historyWeightModels.add(HistoryWeightModel.fromJson(v));
      });
    }
  }
}

class HistoryWeightModel {
  String? tareWeight;
  String? grossWeight;
  String? grossTime;

  HistoryWeightModel({this.tareWeight, this.grossWeight, this.grossTime});

  HistoryWeightModel.fromJson(Map<String, dynamic> json) {
    tareWeight = json['TareWeight'];
    grossWeight = json['GrossWeight'];
    grossTime = json['GrossTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TareWeight'] = tareWeight;
    data['GrossWeight'] = grossWeight;
    data['GrossTime'] = grossTime;
    return data;
  }
}
