class BargeVoyages {
  int? code;
  String? serverTime;
  String? message;
  late Data _data;
  Data get data => _data;

  BargeVoyages(
      {required code, required serverTime, required message, required data}) {
    code = code;
    serverTime = serverTime;
    message = message;
    _data = data;
  }

  BargeVoyages.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    serverTime = json['ServerTime'];
    message = json['Message'];
    _data = Data.fromJson(json['Data']);
  }
}

class Data {
  late List<BargeVoyageModel> _bargeVoyages;
  List<BargeVoyageModel> get bargeVoyages => _bargeVoyages;

  Data({required bargeVoyages}) {
    _bargeVoyages = _bargeVoyages;
  }
  Data.fromJson(Map<String, dynamic> json) {
    if (json['BargeVoyages'] != null) {
      _bargeVoyages = <BargeVoyageModel>[];
      json['BargeVoyages'].forEach((v) {
        _bargeVoyages.add(BargeVoyageModel.fromJson(v));
      });
    }
  }
}

class BargeVoyageModel {
  String? id;
  String? parentId;
  String? shipperId;
  String? siteId;
  String? vesselId;
  String? callYear;
  String? callSeq;
  String? inVoyage;
  String? outVoyage;
  String? dischargeQty;
  String? loadingQty;
  String? actualDischargeQty;
  String? actualLoadingQty;
  String? sourceId;
  String? destinationId;
  String? status;
  String? remark;
  String? deleted;
  String? createdDate;
  String? createdBy;
  String? changedDate;
  String? changedBy;
  String? vesselBargeQty;
  String? vesselTruckQty;
  String? fullPackageQty;
  String? warehouseQty;
  String? eTA;
  String? eTB;
  String? eTC;
  String? eTF;
  String? eTD;
  String? aTA;
  String? aTB;
  String? aTC;
  String? aTF;
  String? aTD;
  String? allowOverWeight;
  String? code;
  String? warehouseId;
  String? type;
  String? keepPercent;
  String? organizationOwnerId;
  String? cargoDirection;
  String? referenceId;
  String? haveUnloading;
  String? direction;
  String? bargeCode;

  BargeVoyageModel(
      {this.id,
      this.parentId,
      this.shipperId,
      this.siteId,
      this.vesselId,
      this.callYear,
      this.callSeq,
      this.inVoyage,
      this.outVoyage,
      this.dischargeQty,
      this.loadingQty,
      this.actualDischargeQty,
      this.actualLoadingQty,
      this.sourceId,
      this.destinationId,
      this.status,
      this.remark,
      this.deleted,
      this.createdDate,
      this.createdBy,
      this.changedDate,
      this.changedBy,
      this.vesselBargeQty,
      this.vesselTruckQty,
      this.fullPackageQty,
      this.warehouseQty,
      this.eTA,
      this.eTB,
      this.eTC,
      this.eTF,
      this.eTD,
      this.aTA,
      this.aTB,
      this.aTC,
      this.aTF,
      this.aTD,
      this.allowOverWeight,
      this.code,
      this.warehouseId,
      this.type,
      this.keepPercent,
      this.organizationOwnerId,
      this.cargoDirection,
      this.referenceId,
      this.haveUnloading,
      this.direction,
      this.bargeCode});

  BargeVoyageModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    parentId = json['ParentId'];
    shipperId = json['ShipperId'];
    siteId = json['SiteId'];
    vesselId = json['VesselId'];
    callYear = json['CallYear'];
    callSeq = json['CallSeq'];
    inVoyage = json['InVoyage'];
    outVoyage = json['OutVoyage'];
    dischargeQty = json['DischargeQty'];
    loadingQty = json['LoadingQty'];
    actualDischargeQty = json['ActualDischargeQty'];
    actualLoadingQty = json['ActualLoadingQty'];
    sourceId = json['SourceId'];
    destinationId = json['DestinationId'];
    status = json['Status'];
    remark = json['Remark'];
    deleted = json['Deleted'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
    changedDate = json['ChangedDate'];
    changedBy = json['ChangedBy'];
    vesselBargeQty = json['VesselBargeQty'];
    vesselTruckQty = json['VesselTruckQty'];
    fullPackageQty = json['FullPackageQty'];
    warehouseQty = json['WarehouseQty'];
    eTA = json['ETA'];
    eTB = json['ETB'];
    eTC = json['ETC'];
    eTF = json['ETF'];
    eTD = json['ETD'];
    aTA = json['ATA'];
    aTB = json['ATB'];
    aTC = json['ATC'];
    aTF = json['ATF'];
    aTD = json['ATD'];
    allowOverWeight = json['AllowOverWeight'];
    code = json['Code'];
    warehouseId = json['WarehouseId'];
    type = json['Type'];
    keepPercent = json['KeepPercent'];
    organizationOwnerId = json['OrganizationOwnerId'];
    cargoDirection = json['CargoDirection'];
    referenceId = json['ReferenceId'];
    haveUnloading = json['HaveUnloading'];
    direction = json['Direction'];
    bargeCode = json['BargeCode'];
  }
}
