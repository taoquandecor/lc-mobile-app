class DeliveryDetailWorkFlows {
  int? code;
  String? serverTime;
  String? message;
  late Data _data;
  Data get data => _data;

  DeliveryDetailWorkFlows(
      {required code, required serverTime, required message, required data}) {
    code = code;
    serverTime = serverTime;
    message = message;
    _data = data;
  }

  DeliveryDetailWorkFlows.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    serverTime = json['ServerTime'];
    message = json['Message'];
    _data = Data.fromJson(json['Data']);
  }
}

class Data {
  late List<DeliveryDetailWorkFlowModel> _deliveryDetailWorkFlows;
  List<DeliveryDetailWorkFlowModel> get deliveryDetailWorkFlows =>
      _deliveryDetailWorkFlows;

  Data({required deliveryDetailWorkFlows}) {
    _deliveryDetailWorkFlows = deliveryDetailWorkFlows;
  }

  Data.fromJson(Map<String, dynamic> json) {
    if (json['DeliveryDetailWorkFlows'] != null) {
      _deliveryDetailWorkFlows = <DeliveryDetailWorkFlowModel>[];
      json['DeliveryDetailWorkFlows'].forEach((v) {
        _deliveryDetailWorkFlows.add(DeliveryDetailWorkFlowModel.fromJson(v));
      });
    }
  }
}

class DeliveryDetailWorkFlowModel {
  String? id;
  String? deliveryDetailId;
  String? sequence;
  String? workFlowId;
  String? remark;
  String? deleted;
  String? createdDate;
  String? createdBy;
  String? changedDate;
  String? changedBy;
  String? workFlowCode;
  String? siteId;
  String? workFlowName;
  String? createByName;

  DeliveryDetailWorkFlowModel(
      {this.id,
      this.deliveryDetailId,
      this.sequence,
      this.workFlowId,
      this.remark,
      this.deleted,
      this.createdDate,
      this.createdBy,
      this.changedDate,
      this.changedBy,
      this.workFlowCode,
      this.siteId,
      this.workFlowName,
      this.createByName});

  DeliveryDetailWorkFlowModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    deliveryDetailId = json['DeliveryDetailId'];
    sequence = json['Sequence'];
    workFlowId = json['WorkFlowId'];
    remark = json['Remark'];
    deleted = json['Deleted'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
    changedDate = json['ChangedDate'];
    changedBy = json['ChangedBy'];
    workFlowCode = json['WorkFlowCode'];
    siteId = json['SiteId'];
    workFlowName = json['WorkFlowName'];
    createByName = json['CreateByName'];
  }
}
