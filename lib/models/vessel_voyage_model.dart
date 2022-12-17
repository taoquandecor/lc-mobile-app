class VesselVoyages {
  int? code;
  String? serverTime;
  String? message;
  late Data _data;
  Data get data => _data;

  VesselVoyages(
      {required code, required serverTime, required message, required data}) {
    code = code;
    serverTime = serverTime;
    message = message;
    _data = data;
  }

  VesselVoyages.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    serverTime = json['ServerTime'];
    message = json['Message'];
    _data = Data.fromJson(json['Data']);
  }
}

class Data {
  late List<VesselVoyageModel> _vesselVoyages;
  List<VesselVoyageModel> get vesselVoyages => _vesselVoyages;

  Data({required vesselVoyages}) {
    _vesselVoyages = vesselVoyages;
  }
  Data.fromJson(Map<String, dynamic> json) {
    if (json['VesselVoyages'] != null) {
      _vesselVoyages = <VesselVoyageModel>[];
      json['VesselVoyages'].forEach((v) {
        _vesselVoyages.add(VesselVoyageModel.fromJson(v));
      });
    }
  }
}

class VesselVoyageModel {
  String? vesselVoyageId;
  String? terminalId;
  String? code;
  String? commencedTime;
  String? vesselCode;
  String? shipperCode;
  String? terminalType;

  VesselVoyageModel(
      {this.vesselVoyageId,
      this.terminalId,
      this.code,
      this.commencedTime,
      this.vesselCode,
      this.shipperCode,
      this.terminalType});

  VesselVoyageModel.fromJson(Map<String, dynamic> json) {
    vesselVoyageId = json['VesselVoyageId'];
    terminalId = json['TerminalId'];
    code = json['Code'];
    commencedTime = json['CommencedTime'];
    vesselCode = json['VesselCode'];
    shipperCode = json['ShipperCode'];
    terminalType = json['TerminalType'];
  }
}
