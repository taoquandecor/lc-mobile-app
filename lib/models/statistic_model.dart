class Statistics {
  int? code;
  String? serverTime;
  String? message;
  late Data _data;
  Data get data => _data;

  Statistics(
      {required code, required serverTime, required message, required data}) {
    code = code;
    serverTime = serverTime;
    message = message;
    _data = data;
  }

  Statistics.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    serverTime = json['ServerTime'];
    message = json['Message'];
    _data = Data.fromJson(json['Data']);
  }
}

class Data {
  late List<StatisticModel> _statisticModel;
  List<StatisticModel> get statisticModel => _statisticModel;

  Data({required statisticModel}) {
    _statisticModel = statisticModel;
  }
  Data.fromJson(Map<String, dynamic> json) {
    if (json['Statistics'] != null) {
      _statisticModel = <StatisticModel>[];
      json['Statistics'].forEach((v) {
        _statisticModel.add(StatisticModel.fromJson(v));
      });
    }
  }
}

class StatisticModel {
  String? operationDate;
  String? shift;
  String? cargoId;
  String? cargoName;
  String? operationVolumne;
  String? terminalId;
  String? numOfTurn;
  String? serviceTypeName;

  StatisticModel(
      {this.operationDate,
      this.shift,
      this.cargoId,
      this.cargoName,
      this.operationVolumne,
      this.terminalId,
      this.numOfTurn,
      this.serviceTypeName});

  StatisticModel.fromJson(Map<String, dynamic> json) {
    operationDate = json['OperationDate'];
    shift = json['Shift'];
    cargoId = json['CargoId'];
    cargoName = json['CargoName'];
    operationVolumne = json['OperationVolumne'];
    terminalId = json['TerminalId'];
    numOfTurn = json['NumOfTurn'];
    serviceTypeName = json['ServiceTypeName'];
  }
}
