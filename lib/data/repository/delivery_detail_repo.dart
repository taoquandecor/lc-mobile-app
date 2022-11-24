import 'package:get/get.dart';
import 'package:lcmobileapp/data/api/api_client.dart';
import 'package:lcmobileapp/models/delivery_detail_body_model.dart';
import 'package:lcmobileapp/models/delivery_detail_model.dart';
import 'package:lcmobileapp/utils/app_constants.dart';

class DeliveryDetailRepo extends GetxService {
  final ApiClient apiClient;

  DeliveryDetailRepo({required this.apiClient});

  Future<Response> getDeliveryDetailList(int type) async {
    String uri = AppContants.REGISTRATION_TICKET;
    if (type == 1) {
      uri = AppContants.PENDING_TICKET;
    }
    return await apiClient.postData(uri, {"TerminalId": apiClient.terminal});
  }

  Future<Response> getHistoryWeight(
      String vehiclePrimaryId, String vehicleSecondaryId) async {
    return await apiClient.postData(AppContants.HISTORY_WEIGHT_EMPTY, {
      "VehiclePrimaryId": vehiclePrimaryId,
      "VehicleSecondaryId": vehicleSecondaryId
    });
  }

  Future<Response> updateWeight(
      DeliveryDetailBody deliveryDetailBody, String id) async {
    return await apiClient.putData(
        AppContants.UPDATE_URI + id, deliveryDetailBody.toJson());
  }

  Future<Response> updateBargeVoyage(
      String bargeVoyageId, String remark, String id) async {
    return await apiClient.putData(AppContants.BARGE_VOYAGE_UPDATE_URI + id,
        {"BargeVoyageId": bargeVoyageId, "Remark": remark});
  }

  Future<Response> storeWeight(DeliveryDetailModel deliveryDetailModel) async {
    return await apiClient.postData(
        AppContants.STORE_URI, deliveryDetailModel.toJson());
  }

  Future<Response> getBargeVoyages(String vesselVoyageId) async {
    return await apiClient
        .getData(AppContants.BARGE_VOYAGE_URI + vesselVoyageId);
  }

  Future<Response> getTimeLines(String deliveryDetailId) async {
    return await apiClient
        .getData(AppContants.TIME_LINES_URI + deliveryDetailId);
  }
}
