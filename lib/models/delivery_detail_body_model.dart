class DeliveryDetailBody {
  int grossWeight;
  int tareWeight;
  String tareScaleId;
  String grossScaleId;
  String remark;
  String workflowCode;

  DeliveryDetailBody(
      {required this.grossWeight,
      required this.tareWeight,
      required this.tareScaleId,
      required this.grossScaleId,
      required this.remark,
      required this.workflowCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TareWeight'] = tareWeight;
    data['GrossWeight'] = grossWeight;
    data['Remark'] = remark;
    data['TareScaleId'] = tareScaleId;
    data['GrossScaleId'] = grossScaleId;
    data['WorkFlowCode'] = workflowCode;
    return data;
  }
}
