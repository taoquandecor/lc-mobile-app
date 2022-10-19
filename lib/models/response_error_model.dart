class ResponseErrorModel {
  int? code;
  String? serverTime;
  Map<String, dynamic>? errors;

  ResponseErrorModel({this.code, this.serverTime, this.errors});

  ResponseErrorModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    serverTime = json['ServerTime'];
    errors = json['Errors'] != null
        ? Map<String, dynamic>.from(json['Errors'])
        : null;
  }
}
