import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lcmobileapp/data/repository/delivery_detail_repo.dart';
import 'package:lcmobileapp/models/barge_voyage_model.dart';
import 'package:lcmobileapp/models/delivery_detail_body_model.dart';
import 'package:lcmobileapp/models/delivery_detail_model.dart';
import 'package:lcmobileapp/models/delivery_detail_work_flow_model.dart';
import 'package:lcmobileapp/models/history_weight_model.dart';
import 'package:lcmobileapp/models/response_model.dart';
import 'package:lcmobileapp/models/token_timeout_model.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_message.dart';

class DeliveryDetailController extends GetxController implements GetxService {
  final DeliveryDetailRepo deliveryDetailRepo;
  DeliveryDetailController({required this.deliveryDetailRepo});

  List<DeliveryDetailModel> _registerTicketList = [];
  List<DeliveryDetailModel> get registerTicketList => _registerTicketList;

  List<DeliveryDetailModel> _pendingTicketList = [];
  List<DeliveryDetailModel> get pendingTicketList => _pendingTicketList;

  List<HistoryWeightModel> _historyWeightList = [];
  List<HistoryWeightModel> get historyWeightList => _historyWeightList;

  List<BargeVoyageModel> _bargeVoyageList = [];
  List<BargeVoyageModel> get bargeVoyageList => _bargeVoyageList;

  List<DeliveryDetailWorkFlowModel> _deliveryDetailWFList = [];
  List<DeliveryDetailWorkFlowModel> get deliveryDetailWFList =>
      _deliveryDetailWFList;

  TokenTimeOut _tokenTimeOut = TokenTimeOut(isTimeOut: false);
  TokenTimeOut get tokenTimeOut => _tokenTimeOut;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  /*
    Lấy danh sách kế hoạch cân
  */
  Future<void> getRegistrationTicketList() async {
    Response response = await deliveryDetailRepo.getDeliveryDetailList(0);
    try {
      if (response.statusCode == 200) {
        if (response.body["Code"] == 406) {
          // token timeout(
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
        } else {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          _registerTicketList = [];
          _registerTicketList.addAll(
              DeliveryDetails.fromJson(response.body).data.deliveryDetails);
          _isLoaded = true;
          update();
        }
      } else {
        Get.snackbar(
          AppMessage.WEIGHT_PLAN_TAB,
          response.statusText.toString(),
          backgroundColor: AppColor.errorColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _registerTicketList = [];
      Get.snackbar(
        AppMessage.WEIGHT_NET_TAB,
        e.toString(),
        backgroundColor: AppColor.errorColor,
        colorText: Colors.white,
      );
    }
  }

  /*
    Lấy danh sách cân chốt (chờ cân)
  */
  Future<void> getPendingTicketList() async {
    Response response = await deliveryDetailRepo.getDeliveryDetailList(1);
    try {
      if (response.statusCode == 200) {
        if (response.body["Code"] == 406) {
          // token timeout(
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
        } else {
          _pendingTicketList = [];
          _pendingTicketList.addAll(
              DeliveryDetails.fromJson(response.body).data.deliveryDetails);
          _isLoaded = true;
          update();
        }
      } else {
        Get.snackbar(
          AppMessage.WEIGHT_NET_TAB,
          response.statusText.toString(),
          backgroundColor: AppColor.errorColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _pendingTicketList = [];
      Get.snackbar(
        AppMessage.WEIGHT_NET_TAB,
        e.toString(),
        backgroundColor: AppColor.errorColor,
        colorText: Colors.white,
      );
    }
  }

  /*
    Lấy lịch sử bì của biển số xe hoặc mooc
  */
  Future<void> getHistoryWeight(
      String vehiclePrimaryId, String vehicleSecondaryId) async {
    Response response = await deliveryDetailRepo.getHistoryWeight(
        vehiclePrimaryId, vehicleSecondaryId);
    try {
      if (response.statusCode == 200) {
        if (response.body["Code"] == 406) {
          // token timeout(
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
        } else {
          _historyWeightList = [];
          _historyWeightList.addAll(
              HistoryWeights.fromJson(response.body).data.historyWeightModels);
          _isLoaded = true;
          update();
        }
      } else {
        Get.snackbar(
          AppMessage.WEIGHT_NET_TAB,
          response.statusText.toString(),
          backgroundColor: AppColor.errorColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _historyWeightList = [];
      Get.snackbar(
        AppMessage.WEIGHT_NET_TAB,
        e.toString(),
        backgroundColor: AppColor.errorColor,
        colorText: Colors.white,
      );
    }
  }

  /*
    Cập nhật số cân theo id của phiếu cân
  */
  Future<ResponseModel> updateWeight(
      DeliveryDetailBody deliveryDetailBody, String id) async {
    ResponseModel responseModel;
    try {
      Response response =
          await deliveryDetailRepo.updateWeight(deliveryDetailBody, id);

      if (response.statusCode == 200) {
        if (response.body["Code"] == 460) {
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
          responseModel = ResponseModel(false, AppMessage.TOKEN_TIMEOUT);
        } else {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          responseModel = ResponseModel(true, response.body["Message"]);
        }
      } else {
        responseModel = ResponseModel(false, response.statusText.toString());
      }
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
    }
    update();
    return responseModel;
  }

  /*
    Cập nhật mã chuyến sà lan theo id của phiếu cân
  */
  Future<ResponseModel> updateBargeVoyage(
      String bargeVoyageId, String remark, String id) async {
    ResponseModel responseModel;
    try {
      Response response =
          await deliveryDetailRepo.updateBargeVoyage(bargeVoyageId, remark, id);

      if (response.statusCode == 200) {
        if (response.body["Code"] == 460) {
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
          responseModel = ResponseModel(false, AppMessage.TOKEN_TIMEOUT);
        } else {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          responseModel = ResponseModel(true, response.body["Message"]);
        }
      } else {
        responseModel = ResponseModel(false, response.statusText.toString());
      }
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
    }
    update();
    return responseModel;
  }

  /*
    Lưu số cân
  */
  Future<ResponseModel> storeWeight(
      DeliveryDetailModel deliveryDetailModel) async {
    ResponseModel responseModel;
    try {
      Response response =
          await deliveryDetailRepo.storeWeight(deliveryDetailModel);

      if (response.statusCode == 200) {
        if (response.body["Code"] == 460) {
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
          responseModel = ResponseModel(false, AppMessage.TOKEN_TIMEOUT);
        } else {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          responseModel = ResponseModel(false, response.body["Message"]);
        }
      } else {
        responseModel = ResponseModel(false, response.statusText.toString());
      }
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
    }
    update();
    return responseModel;
  }

  /*
    Lấy danh sách sà lan theo mã chuyến tầu
  */
  Future<void> getBargeVoyages(String vesselVoyageId) async {
    Response response =
        await deliveryDetailRepo.getBargeVoyages(vesselVoyageId);

    try {
      if (response.statusCode == 200) {
        if (response.body["Code"] == 406) {
          // token timeout(
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
        } else {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          _bargeVoyageList = [];
          _bargeVoyageList
              .addAll(BargeVoyages.fromJson(response.body).data.bargeVoyages);
          _isLoaded = true;
          update();
        }
      } else {
        Get.snackbar(
          AppMessage.TALLY_WEIGHT_BERTH,
          response.statusText.toString(),
          backgroundColor: AppColor.errorColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _bargeVoyageList = [];
      Get.snackbar(
        AppMessage.TALLY_WEIGHT_BERTH,
        e.toString(),
        backgroundColor: AppColor.errorColor,
        colorText: Colors.white,
      );
    }
  }

  /*
    Lấy danh sách workflow theo id của chuyến xe
  */
  Future<void> getTimeLines(String deliveryDetailId) async {
    Response response = await deliveryDetailRepo.getTimeLines(deliveryDetailId);

    try {
      if (response.statusCode == 200) {
        if (response.body["Code"] == 406) {
          // token timeout(
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
        } else {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          _deliveryDetailWFList = [];
          _deliveryDetailWFList.addAll(
              DeliveryDetailWorkFlows.fromJson(response.body)
                  .data
                  .deliveryDetailWorkFlows);
          _isLoaded = true;
          update();
        }
      } else {
        Get.snackbar(
          AppMessage.TALLY_WEIGHT_BERTH,
          response.statusText.toString(),
          backgroundColor: AppColor.errorColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _bargeVoyageList = [];
      Get.snackbar(
        AppMessage.TALLY_WEIGHT_BERTH,
        e.toString(),
        backgroundColor: AppColor.errorColor,
        colorText: Colors.white,
      );
    }
  }
}
