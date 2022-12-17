import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/controller/dashboard_controller.dart';
import 'package:lcmobileapp/models/delivery_detail_model.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:lcmobileapp/widgets/display_row_data_widget.dart';
import 'package:lcmobileapp/widgets/display_vehicle_widget.dart';
import 'package:lcmobileapp/widgets/manifest_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:intl/intl.dart';

class DeliveryDetailPage extends StatefulWidget {
  String vesselVoyageId;
  String fromDate;
  String toDate;
  DeliveryDetailPage(
      {super.key,
      required this.vesselVoyageId,
      required this.fromDate,
      required this.toDate});

  @override
  State<DeliveryDetailPage> createState() => _DeliveryDetailPageState();
}

class _DeliveryDetailPageState extends State<DeliveryDetailPage> {
  List<DeliveryDetailModel> _deliveryDetailList = [];

  var f = NumberFormat(AppContants.FORMAT_NUMER);

  String formatDateTime(String weightTime) {
    var outputDate = DateTime.now().toString();

    DateTime parseDate =
        DateFormat(AppContants.SQL_DATETIME_FORMAT).parse(weightTime);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat(AppContants.DATE_FORMAT2);
    outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  Future<void> _loadResources() async {
    await Get.find<DashboardController>().getStatisticDeliveryDetail(
        widget.vesselVoyageId, widget.fromDate, widget.toDate);
    _deliveryDetailList = Get.find<DashboardController>().deliveryDetailList;
  }

  int sumNetWeight(List<DeliveryDetailModel> deliveryDetailList) {
    int sum = 0;
    for (var element in deliveryDetailList) {
      sum += int.parse(element.grossWeight ?? "0") -
          int.parse(element.tareWeight ?? "0");
    }
    return sum;
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
  }

  @override
  void dispose() {
    _deliveryDetailList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundWhiteColor,
        appBar: AppBar(
          leading: BackButton(
            color: AppColor.mainColor,
            onPressed: () => Get.back(),
          ),
          title: BigText(
            text: AppMessage.DELIVERY_DETAIL_LIST,
            size: Dimensions.fontSize14,
            color: AppColor.mainColor,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColor.backgroundWhiteColor,
        ),
        body: GetBuilder<DashboardController>(
          builder: (dashboardController) {
            return dashboardController.isLoaded
                ? SingleChildScrollView(
                    child: Container(
                      color: AppColor.backgroundWhiteColor,
                      margin: EdgeInsets.only(
                          top: Dimensions.height10 / 5,
                          left: Dimensions.width10,
                          right: Dimensions.width10),
                      child: Column(
                        children: [
                          Container(
                            height: Dimensions.pageListView,
                            margin: EdgeInsets.only(
                              top: Dimensions.height10 / 2,
                              left: Dimensions.width10,
                              right: Dimensions.width10,
                              bottom: Dimensions.height10,
                            ),
                            child: ListView.builder(
                              itemCount: _deliveryDetailList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        RouteHelper.getTicketDetailPage(index));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Tầu sàlan
                                              DisplayRowDataWidget(
                                                firstField:
                                                    _deliveryDetailList[index]
                                                        .vesselCode
                                                        .toString(),
                                                secondField:
                                                    _deliveryDetailList[index]
                                                            .bargeCode ??
                                                        "",
                                                firstColor: AppColor.mainColor,
                                                firstSize:
                                                    Dimensions.fontSize14,
                                                secondSize:
                                                    Dimensions.fontSize12,
                                                fontWeight2: FontWeight.normal,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 5,
                                              ),
                                              // Ben nhan va Uy thac
                                              DisplayRowDataWidget(
                                                firstField:
                                                    _deliveryDetailList[index]
                                                        .consigneeCode
                                                        .toString(),
                                                firstColor: Colors.green,
                                                firstSize:
                                                    Dimensions.fontSize10,
                                                secondSize:
                                                    Dimensions.fontSize10,
                                                secondField:
                                                    _deliveryDetailList[index]
                                                            .delegateCode ??
                                                        "",
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 5,
                                              ),
                                              BigText(
                                                text: _deliveryDetailList[index]
                                                        .serviceTypeCode ??
                                                    "",
                                                size: Dimensions.fontSize10,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      BigText(
                                                        text: _deliveryDetailList[
                                                                    index]
                                                                .vehiclePrimaryCode ??
                                                            "",
                                                        size: Dimensions
                                                            .fontSize12,
                                                        color:
                                                            AppColor.mainColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      BigText(
                                                        text: _deliveryDetailList[
                                                                        index]
                                                                    .vehicleSecondaryCode
                                                                    .toString() ==
                                                                "null"
                                                            ? ""
                                                            : "/ ${_deliveryDetailList[index].vehicleSecondaryCode ?? ""}",
                                                        size: Dimensions
                                                            .fontSize12,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SmallText(
                                                        text:
                                                            _deliveryDetailList[
                                                                        index]
                                                                    .code ??
                                                                "",
                                                        size: Dimensions
                                                                .fontSize12 -
                                                            4,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.height10 / 5,
                                                  ),
                                                  BigText(
                                                    text: _deliveryDetailList[
                                                                index]
                                                            .operationTerminalCode ??
                                                        "",
                                                    size: Dimensions.fontSize10,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          // chủ hàng ủy thác loại hàng billoflading
                                          ManifestWidget(
                                            billOfLading:
                                                _deliveryDetailList[index]
                                                        .billOfLading ??
                                                    "",
                                            consigneeCode: _deliveryDetailList[
                                                        index]
                                                    .manifestConsigneeCode ??
                                                "",
                                            cargoCode:
                                                _deliveryDetailList[index]
                                                        .cargoCode ??
                                                    "",
                                            delegrateCode:
                                                _deliveryDetailList[index]
                                                        .manifestDelegateCode ??
                                                    "",
                                            size: Dimensions.fontSize10,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          BigText(
                                            text: "${AppMessage.NET_WEIGHT}: ",
                                            size: Dimensions.fontSize10,
                                            color: Colors.black,
                                          ),
                                          BigText(
                                            text:
                                                "${f.format(int.parse(_deliveryDetailList[index].grossWeight ?? "0") - int.parse(_deliveryDetailList[index].tareWeight ?? "0"))} (kg)",
                                            size: Dimensions.fontSize10,
                                            color: AppColor.mainColor,
                                          ),
                                          BigText(
                                            text: " ${AppMessage.AT} ",
                                            size: Dimensions.fontSize10,
                                            color: Colors.black,
                                          ),
                                          BigText(
                                            text:
                                                "${formatDateTime(_deliveryDetailList[index].grossTime.toString())}",
                                            size: Dimensions.fontSize10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          BigText(
                                            text: " ${AppMessage.FOR} ",
                                            size: Dimensions.fontSize10,
                                            color: Colors.black,
                                          ),
                                          BigText(
                                            text:
                                                "${_deliveryDetailList[index].grossAccountDisplayName}",
                                            size: Dimensions.fontSize10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: Dimensions.screenWidth,
                                        height: 1.2,
                                        margin: const EdgeInsets.only(top: 0),
                                        color: AppColor.lineColor,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const CustomLoader();
          },
        ),
        bottomNavigationBar: GetBuilder<DashboardController>(
          builder: (dashboardController) {
            return Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              height: Dimensions.height45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BigText(
                    text: "${AppMessage.COUNT_TICKET}:",
                    size: Dimensions.fontSize12,
                    color: AppColor.mainColor,
                  ),
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                  BigText(
                    text:
                        "${f.format(dashboardController.deliveryDetailList.length)} ${AppMessage.TICKET}",
                    size: Dimensions.fontSize12,
                  ),
                  SizedBox(
                    width: Dimensions.width20,
                  ),
                  BigText(
                    text: "${AppMessage.SUMMARY_NET_WEIGHT}:",
                    size: Dimensions.fontSize12,
                    color: AppColor.mainColor,
                  ),
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                  BigText(
                    text:
                        "${f.format(sumNetWeight(dashboardController.deliveryDetailList))} (Kg)",
                    size: Dimensions.fontSize12,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
