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
  String? deliveryDetailId;
  String? workFlowId;
  String? deliveryOrderId;
  String? wFCode;
  String? wFName;
  String? sequence;
  String? createdBy;
  String? createdDate;
  String? remark;

  DeliveryDetailWorkFlowModel(
      {this.deliveryDetailId,
      this.deliveryOrderId,
      this.sequence,
      this.workFlowId,
      this.remark,
      this.createdDate,
      this.createdBy,
      this.wFCode,
      this.wFName});

  DeliveryDetailWorkFlowModel.fromJson(Map<String, dynamic> json) {
    deliveryDetailId = json['DeliveryDetailId'];
    sequence = json['Sequence'];
    workFlowId = json['WorkFlowId'];
    remark = json['Remark'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
    wFCode = json['WFCode'];
    wFName = json['WFName'];
    deliveryOrderId = json['DeliveryOrderId'];
  }
}
