class DeliveryDetails {
  int? code;
  String? serverTime;
  String? message;
  late Data _data;
  Data get data => _data;

  DeliveryDetails(
      {required code, required serverTime, required message, required data}) {
    code = code;
    serverTime = serverTime;
    message = message;
    _data = data;
  }

  DeliveryDetails.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    serverTime = json['ServerTime'];
    message = json['Message'];
    _data = Data.fromJson(json['Data']);
  }
}

class Data {
  late List<DeliveryDetailModel> _deliveryDetails;
  List<DeliveryDetailModel> get deliveryDetails => _deliveryDetails;

  Data({required deliveryDetails}) {
    _deliveryDetails = deliveryDetails;
  }

  Data.fromJson(Map<String, dynamic> json) {
    if (json['DeliveryDetails'] != null) {
      _deliveryDetails = <DeliveryDetailModel>[];
      json['DeliveryDetails'].forEach((v) {
        deliveryDetails.add(DeliveryDetailModel.fromJson(v));
      });
    }
  }
}

class DeliveryDetailModel {
  String? id;
  String? code;
  String? siteId;
  String? operationTerminalId;
  String? vesselVoyageId;
  String? deliveryOrderId;
  String? requestId;
  String? vehiclePrimaryId;
  String? vehicleSecondaryId;
  String? vehicleType;
  String? parentId;
  String? serviceTypeId;
  String? cargoDirection;
  String? planQuantity;
  String? cargoId;
  String? unitId;
  String? consigneeId;
  String? delegateId;
  String? expiredDate;
  String? tareWeight;
  String? grossWeight;
  String? tareTime;
  String? grossTime;
  String? tareScaleId;
  String? grossScaleId;
  String? userTareId;
  String? userGrossId;
  String? weightingType;
  String? manifestId;
  String? secondTerminalId;
  String? vesselHoldId;
  String? craneId;
  String? printCount;
  String? driverName;
  String? driverMobile;
  String? remark;
  String? status;
  String? deleted;
  String? createdDate;
  String? createdBy;
  String? changedDate;
  String? changedBy;
  String? bargeVoyageId;
  String? destinationId;
  String? sourceId;
  String? vesselDischargePlanId;
  String? quantity;
  String? paymentMethod;
  String? actualQty;
  String? apprPlanQty;
  String? waitPlanQty;
  String? paidAmount;
  String? amount;
  String? operationTerminalCode;
  String? operationTerminalName;
  String? inVoyage;
  String? outVoyage;
  String? vesselCode;
  String? vehiclePrimaryCode;
  String? vehiclePrimaryType;
  String? vehicleSecondaryCode;
  String? vehicleSecondaryType;
  String? serviceTypeCode;
  String? serviceTypeName;
  String? cargoCode;
  String? cargoName;
  String? unitCode;
  String? unitName;
  String? consigneeCode;
  String? consigneeName;
  String? delegateCode;
  String? delegateName;
  String? tareScaleCode;
  String? grossScaleCode;
  String? tareAccountDisplayName;
  String? grossAccountDisplayName;
  String? actualQuantity;
  String? billOfLading;
  String? secondTerminalCode;
  String? vesselHoldCode;
  String? bargeCode;
  String? createdByName;
  String? changedByName;
  String? cargoType;
  String? holdStatus;
  String? remainQuantity;
  String? bargeInVoyage;
  String? bargeOutVoyage;
  String? doRescale;
  String? rescale;
  String? berthNote;
  String? organizationOwnerId;
  String? numOfTurn;
  String? actualTurn;
  String? manifestConsigneeId;
  String? manifestDelegateId;
  String? vesselVoyageStatus;
  String? manifestConsigneeCode;
  String? manifestDelegateCode;
  String? customsDeclarationNo;
  String? cargoCondition;
  String? deliveryOrderCode;
  String? workFlowCode;

  DeliveryDetailModel({
    this.id,
    this.code,
    this.siteId,
    this.operationTerminalId,
    this.vesselVoyageId,
    this.deliveryOrderId,
    this.requestId,
    this.vehiclePrimaryId,
    this.vehicleSecondaryId,
    this.vehicleType,
    this.parentId,
    this.serviceTypeId,
    this.cargoDirection,
    this.planQuantity,
    this.cargoId,
    this.unitId,
    this.consigneeId,
    this.delegateId,
    this.expiredDate,
    this.tareWeight,
    this.grossWeight,
    this.tareTime,
    this.grossTime,
    this.tareScaleId,
    this.grossScaleId,
    this.userTareId,
    this.userGrossId,
    this.weightingType,
    this.manifestId,
    this.secondTerminalId,
    this.vesselHoldId,
    this.craneId,
    this.printCount,
    this.driverName,
    this.driverMobile,
    this.remark,
    this.status,
    this.deleted,
    this.createdDate,
    this.createdBy,
    this.changedDate,
    this.changedBy,
    this.bargeVoyageId,
    this.destinationId,
    this.sourceId,
    this.vesselDischargePlanId,
    this.quantity,
    this.paymentMethod,
    this.actualQty,
    this.apprPlanQty,
    this.waitPlanQty,
    this.paidAmount,
    this.amount,
    this.operationTerminalCode,
    this.operationTerminalName,
    this.inVoyage,
    this.outVoyage,
    this.vesselCode,
    this.vehiclePrimaryCode,
    this.vehiclePrimaryType,
    this.vehicleSecondaryCode,
    this.vehicleSecondaryType,
    this.serviceTypeCode,
    this.serviceTypeName,
    this.cargoCode,
    this.cargoName,
    this.unitCode,
    this.unitName,
    this.consigneeCode,
    this.consigneeName,
    this.delegateCode,
    this.delegateName,
    this.tareScaleCode,
    this.grossScaleCode,
    this.tareAccountDisplayName,
    this.grossAccountDisplayName,
    this.actualQuantity,
    this.billOfLading,
    this.secondTerminalCode,
    this.vesselHoldCode,
    this.bargeCode,
    this.createdByName,
    this.changedByName,
    this.cargoType,
    this.holdStatus,
    this.remainQuantity,
    this.bargeInVoyage,
    this.bargeOutVoyage,
    this.doRescale,
    this.rescale,
    this.berthNote,
    this.organizationOwnerId,
    this.numOfTurn,
    this.actualTurn,
    this.manifestConsigneeId,
    this.manifestDelegateId,
    this.vesselVoyageStatus,
    this.manifestConsigneeCode,
    this.manifestDelegateCode,
    this.customsDeclarationNo,
    this.cargoCondition,
    this.deliveryOrderCode,
    this.workFlowCode,
  });

  DeliveryDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    siteId = json['SiteId'];
    operationTerminalId = json['OperationTerminalId'];
    vesselVoyageId = json['VesselVoyageId'];
    deliveryOrderId = json['DeliveryOrderId'];
    requestId = json['RequestId'];
    vehiclePrimaryId = json['VehiclePrimaryId'];
    vehicleSecondaryId = json['VehicleSecondaryId'];
    vehicleType = json['VehicleType'];
    parentId = json['ParentId'];
    serviceTypeId = json['ServiceTypeId'];
    cargoDirection = json['CargoDirection'];
    planQuantity = json['PlanQuantity'];
    cargoId = json['CargoId'];
    unitId = json['UnitId'];
    consigneeId = json['ConsigneeId'];
    delegateId = json['DelegateId'];
    expiredDate = json['ExpiredDate'];
    tareWeight = json['TareWeight'];
    grossWeight = json['GrossWeight'];
    tareTime = json['TareTime'];
    grossTime = json['GrossTime'];
    tareScaleId = json['TareScaleId'];
    grossScaleId = json['GrossScaleId'];
    userTareId = json['UserTareId'];
    userGrossId = json['UserGrossId'];
    weightingType = json['WeightingType'];
    manifestId = json['ManifestId'];
    secondTerminalId = json['SecondTerminalId'];
    vesselHoldId = json['VesselHoldId'];
    craneId = json['CraneId'];
    printCount = json['PrintCount'];
    driverName = json['DriverName'];
    driverMobile = json['DriverMobile'];
    remark = json['Remark'];
    status = json['Status'];
    deleted = json['Deleted'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
    changedDate = json['ChangedDate'];
    changedBy = json['ChangedBy'];
    bargeVoyageId = json['BargeVoyageId'];
    destinationId = json['DestinationId'];
    sourceId = json['SourceId'];
    vesselDischargePlanId = json['VesselDischargePlanId'];
    quantity = json['Quantity'];
    paymentMethod = json['PaymentMethod'];
    actualQty = json['ActualQty'];
    apprPlanQty = json['ApprPlanQty'];
    waitPlanQty = json['WaitPlanQty'];
    paidAmount = json['PaidAmount'];
    amount = json['Amount'];
    operationTerminalCode = json['OperationTerminalCode'];
    operationTerminalName = json['OperationTerminalName'];
    inVoyage = json['InVoyage'];
    outVoyage = json['OutVoyage'];
    vesselCode = json['VesselCode'];
    vehiclePrimaryCode = json['VehiclePrimaryCode'];
    vehiclePrimaryType = json['VehiclePrimaryType'];
    vehicleSecondaryCode = json['VehicleSecondaryCode'];
    vehicleSecondaryType = json['VehicleSecondaryType'];
    serviceTypeCode = json['ServiceTypeCode'];
    serviceTypeName = json['ServiceTypeName'];
    cargoCode = json['CargoCode'];
    cargoName = json['CargoName'];
    unitCode = json['UnitCode'];
    unitName = json['UnitName'];
    consigneeCode = json['ConsigneeCode'];
    consigneeName = json['ConsigneeName'];
    delegateCode = json['DelegateCode'];
    delegateName = json['DelegateName'];
    tareScaleCode = json['TareScaleCode'];
    grossScaleCode = json['GrossScaleCode'];
    tareAccountDisplayName = json['TareAccountDisplayName'];
    grossAccountDisplayName = json['GrossAccountDisplayName'];
    actualQuantity = json['ActualQuantity'];
    billOfLading = json['BillOfLading'];
    secondTerminalCode = json['SecondTerminalCode'];
    vesselHoldCode = json['VesselHoldCode'];
    bargeCode = json['BargeCode'];
    createdByName = json['CreatedByName'];
    changedByName = json['ChangedByName'];
    cargoType = json['CargoType'];
    holdStatus = json['HoldStatus'];
    remainQuantity = json['RemainQuantity'];
    bargeInVoyage = json['BargeInVoyage'];
    bargeOutVoyage = json['BargeOutVoyage'];
    doRescale = json['DoRescale'];
    rescale = json['Rescale'];
    berthNote = json['BerthNote'];
    organizationOwnerId = json['OrganizationOwnerId'];
    numOfTurn = json['NumOfTurn'];
    actualTurn = json['ActualTurn'];
    manifestConsigneeId = json['ManifestConsigneeId'];
    manifestDelegateId = json['ManifestDelegateId'];
    vesselVoyageStatus = json['VesselVoyageStatus'];
    manifestConsigneeCode = json['ManifestConsigneeCode'];
    manifestDelegateCode = json['ManifestDelegateCode'];
    customsDeclarationNo = json['CustomsDeclarationNo'];
    cargoCondition = json['CargoCondition'];
    deliveryOrderCode = json['DeliveryOrderCode'];
    workFlowCode = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Code'] = code;
    data['SiteId'] = siteId;
    data['OperationTerminalId'] = operationTerminalId;
    data['VesselVoyageId'] = vesselVoyageId;
    data['DeliveryOrderId'] = deliveryOrderId;
    data['RequestId'] = requestId;
    data['VehiclePrimaryId'] = vehiclePrimaryId;
    data['VehicleSecondaryId'] = vehicleSecondaryId;
    data['VehicleType'] = vehicleType;
    data['ParentId'] = parentId;
    data['ServiceTypeId'] = serviceTypeId;
    data['CargoDirection'] = cargoDirection;
    data['PlanQuantity'] = planQuantity;
    data['CargoId'] = cargoId;
    data['UnitId'] = unitId;
    data['ConsigneeId'] = consigneeId;
    data['DelegateId'] = delegateId;
    data['ExpiredDate'] = expiredDate;
    data['TareWeight'] = tareWeight;
    data['GrossWeight'] = grossWeight;
    data['TareTime'] = tareTime;
    data['GrossTime'] = grossTime;
    data['TareScaleId'] = tareScaleId;
    data['GrossScaleId'] = grossScaleId;
    data['UserTareId'] = userTareId;
    data['UserGrossId'] = userGrossId;
    data['WeightingType'] = weightingType;
    data['ManifestId'] = manifestId;
    data['SecondTerminalId'] = secondTerminalId;
    data['VesselHoldId'] = vesselHoldId;
    data['CraneId'] = craneId;
    data['PrintCount'] = printCount;
    data['DriverName'] = driverName;
    data['DriverMobile'] = driverMobile;
    data['Remark'] = remark;
    data['Status'] = status;
    data['Deleted'] = deleted;
    data['CreatedDate'] = createdDate;
    data['CreatedBy'] = createdBy;
    data['ChangedDate'] = changedDate;
    data['ChangedBy'] = changedBy;
    data['BargeVoyageId'] = bargeVoyageId;
    data['DestinationId'] = destinationId;
    data['SourceId'] = sourceId;
    data['VesselDischargePlanId'] = vesselDischargePlanId;
    data['Quantity'] = quantity;
    data['PaymentMethod'] = paymentMethod;
    data['ActualQty'] = actualQty;
    data['ApprPlanQty'] = apprPlanQty;
    data['WaitPlanQty'] = waitPlanQty;
    data['PaidAmount'] = paidAmount;
    data['Amount'] = amount;
    data['OperationTerminalCode'] = operationTerminalCode;
    data['OperationTerminalName'] = operationTerminalName;
    data['InVoyage'] = inVoyage;
    data['OutVoyage'] = outVoyage;
    data['VesselCode'] = vesselCode;
    data['VehiclePrimaryCode'] = vehiclePrimaryCode;
    data['VehiclePrimaryType'] = vehiclePrimaryType;
    data['VehicleSecondaryCode'] = vehicleSecondaryCode;
    data['VehicleSecondaryType'] = vehicleSecondaryType;
    data['ServiceTypeCode'] = serviceTypeCode;
    data['ServiceTypeName'] = serviceTypeName;
    data['CargoCode'] = cargoCode;
    data['CargoName'] = cargoName;
    data['UnitCode'] = unitCode;
    data['UnitName'] = unitName;
    data['ConsigneeCode'] = consigneeCode;
    data['ConsigneeName'] = consigneeName;
    data['DelegateCode'] = delegateCode;
    data['DelegateName'] = delegateName;
    data['TareScaleCode'] = tareScaleCode;
    data['GrossScaleCode'] = grossScaleCode;
    data['TareAccountDisplayName'] = tareAccountDisplayName;
    data['GrossAccountDisplayName'] = grossAccountDisplayName;
    data['ActualQuantity'] = actualQuantity;
    data['BillOfLading'] = billOfLading;
    data['SecondTerminalCode'] = secondTerminalCode;
    data['VesselHoldCode'] = vesselHoldCode;
    data['BargeCode'] = bargeCode;
    data['CreatedByName'] = createdByName;
    data['ChangedByName'] = changedByName;
    data['CargoType'] = cargoType;
    data['HoldStatus'] = holdStatus;
    data['RemainQuantity'] = remainQuantity;
    data['BargeInVoyage'] = bargeInVoyage;
    data['BargeOutVoyage'] = bargeOutVoyage;
    data['DoRescale'] = doRescale;
    data['Rescale'] = rescale;
    data['BerthNote'] = berthNote;
    data['OrganizationOwnerId'] = organizationOwnerId;
    data['NumOfTurn'] = numOfTurn;
    data['ActualTurn'] = actualTurn;
    data['ManifestConsigneeId'] = manifestConsigneeId;
    data['ManifestDelegateId'] = manifestDelegateId;
    data['VesselVoyageStatus'] = vesselVoyageStatus;
    data['ManifestConsigneeCode'] = manifestConsigneeCode;
    data['ManifestDelegateCode'] = manifestDelegateCode;
    data['CustomsDeclarationNo'] = customsDeclarationNo;
    data['CargoCondition'] = cargoCondition;
    data['DeliveryOrderCode'] = deliveryOrderCode;
    data['WorkFlowCode'] = workFlowCode;
    return data;
  }
}
