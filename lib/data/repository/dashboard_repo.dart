import 'package:get/get.dart';
import 'package:lcmobileapp/data/api/api_client.dart';
import 'package:lcmobileapp/models/vessel_voyage_model.dart';
import 'package:lcmobileapp/utils/app_constants.dart';

class DashboardRepo extends GetxService {
  final ApiClient apiClient;
  DashboardRepo({required this.apiClient});

  Future<Response> getVesselVoyages() async {
    return await apiClient.getData(AppContants.VESSEL_VOYAGE_URI);
  }

  Future<Response> getStatisticData(
      String vesselVoyageId, String fromDate, String toDate) async {
    return await apiClient.postData(AppContants.DASHBOARD_STATISTIC, {
      "VesselVoyageId": vesselVoyageId,
      "FromDate": fromDate,
      "ToDate": toDate
    });
  }

  Future<Response> getFilterDate() async {
    return await apiClient.getData(AppContants.FILTER_DATE);
  }

  Future<Response> getStatisticDeliveryDetail(
      String vesselVoyageId, String fromDate, String toDate) async {
    return await apiClient.postData(AppContants.DELIVERY_DETAIL_STATISTIC, {
      "VesselVoyageId": vesselVoyageId,
      "FromDate": fromDate,
      "ToDate": toDate
    });
  }
}
