class FilterDates {
  int? code;
  String? serverTime;
  String? message;
  late Data _data;
  Data get data => _data;

  FilterDates(
      {required code, required serverTime, required message, required data}) {
    code = code;
    serverTime = serverTime;
    message = message;
    _data = data;
  }

  FilterDates.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    serverTime = json['ServerTime'];
    message = json['Message'];
    _data = Data.fromJson(json['Data']);
  }
}

class Data {
  late List<FilterDateModel> _filterDates;
  List<FilterDateModel> get filterDates => _filterDates;

  Data({required filterDates}) {
    _filterDates = filterDates;
  }
  Data.fromJson(Map<String, dynamic> json) {
    if (json['FilterDates'] != null) {
      _filterDates = <FilterDateModel>[];
      json['FilterDates'].forEach((v) {
        _filterDates.add(FilterDateModel.fromJson(v));
      });
    }
  }
}

class FilterDateModel {
  String? code;
  String? name;
  String? fromDate;
  String? toDate;
  String? sort;
  FilterDateModel(
      {required this.code,
      required this.name,
      required this.fromDate,
      required this.toDate,
      required this.sort});

  FilterDateModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    name = json['Name'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    sort = json['Sort'];
  }
}
