import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lcmobileapp/data/repository/dashboard_repo.dart';
import 'package:lcmobileapp/models/delivery_detail_model.dart';
import 'package:lcmobileapp/models/filter_date_model.dart';
import 'package:lcmobileapp/models/statistic_model.dart';
import 'package:lcmobileapp/models/token_timeout_model.dart';
import 'package:lcmobileapp/models/vessel_voyage_model.dart';
import 'package:lcmobileapp/utils/app_color.dart';

class DashboardController extends GetxController implements GetxService {
  final DashboardRepo dashboardRepo;
  DashboardController({required this.dashboardRepo});

  List<VesselVoyageModel> _vessleVoyageList = [];
  List<VesselVoyageModel> get vessleVoyageList => _vessleVoyageList;

  List<StatisticModel> _statisticDataList = [];
  List<StatisticModel> get statisticDataList => _statisticDataList;

  List<FilterDateModel> _filterDateList = [];
  List<FilterDateModel> get filterDateList => _filterDateList;

  List<DeliveryDetailModel> _deliveryDetailList = [];
  List<DeliveryDetailModel> get deliveryDetailList => _deliveryDetailList;

  TokenTimeOut _tokenTimeOut = TokenTimeOut(isTimeOut: false);
  TokenTimeOut get tokenTimeOut => _tokenTimeOut;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  /*
    Lấy danh sách chuyến tầu đang làm hàng
  */
  Future<void> getVesselVoyages() async {
    Response response = await dashboardRepo.getVesselVoyages();

    try {
      if (response.statusCode == 200) {
        if (response.body["Code"] == 406) {
          // token timeout(
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
        } else {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          _vessleVoyageList = [];
          _vessleVoyageList
              .addAll(VesselVoyages.fromJson(response.body).data.vesselVoyages);
          _isLoaded = true;
          update();
        }
      } else {
        Get.snackbar(
          "Dashboard",
          response.statusText.toString(),
          backgroundColor: AppColor.errorColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _vessleVoyageList = [];
      Get.snackbar(
        "Dashboard",
        e.toString(),
        backgroundColor: AppColor.errorColor,
        colorText: Colors.white,
      );
    }
  }

  /*
    Lấy danh sách khoảng thời gian 
  */
  Future<void> getFilterDate() async {
    Response response = await dashboardRepo.getFilterDate();

    try {
      if (response.statusCode == 200) {
        if (response.body["Code"] == 406) {
          // token timeout(
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
        } else {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          _filterDateList = [];
          _filterDateList
              .addAll(FilterDates.fromJson(response.body).data.filterDates);
          _isLoaded = true;
          update();
        }
      } else {
        Get.snackbar(
          "Dashboard",
          response.statusText.toString(),
          backgroundColor: AppColor.errorColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _vessleVoyageList = [];
      Get.snackbar(
        "Dashboard",
        e.toString(),
        backgroundColor: AppColor.errorColor,
        colorText: Colors.white,
      );
    }
  }

  // Lấy danh sách thống kê theo tầu
  Future<void> getStatisticData(
      String vesselVoyageId, String fromDate, String toDate) async {
    Response response =
        await dashboardRepo.getStatisticData(vesselVoyageId, fromDate, toDate);
    _statisticDataList = [];
    try {
      if (response.statusCode == 200) {
        if (response.body["Code"] == 406) {
          // token timeout(
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
        } else if (response.body["Code"] == 200) {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          _statisticDataList
              .addAll(Statistics.fromJson(response.body).data.statisticModel);
          _isLoaded = true;
          update();
        } else {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          Get.snackbar(
            "Dashboard",
            response.body["Errors"],
            backgroundColor: AppColor.errorColor,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Dashboard",
          response.statusText.toString(),
          backgroundColor: AppColor.errorColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Dashboard",
        e.toString(),
        backgroundColor: AppColor.errorColor,
        colorText: Colors.white,
      );
    }
  }

  // Lấy danh sách phiếu cân theo tầu, nơi khai thác, khoảng thời gian
  Future<void> getStatisticDeliveryDetail(
      String vesselVoyageId, String fromDate, String toDate) async {
    Response response = await dashboardRepo.getStatisticDeliveryDetail(
        vesselVoyageId, fromDate, toDate);
    _deliveryDetailList = [];
    try {
      if (response.statusCode == 200) {
        if (response.body["Code"] == 406) {
          // token timeout(
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
        } else if (response.body["Code"] == 200) {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          _deliveryDetailList.addAll(
              DeliveryDetails.fromJson(response.body).data.deliveryDetails);
          _isLoaded = true;
          update();
        } else {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          Get.snackbar(
            "Dashboard",
            response.body["Errors"],
            backgroundColor: AppColor.errorColor,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Dashboard",
          response.statusText.toString(),
          backgroundColor: AppColor.errorColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Dashboard",
        e.toString(),
        backgroundColor: AppColor.errorColor,
        colorText: Colors.white,
      );
    }
  }
}
