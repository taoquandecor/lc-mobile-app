import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/controller/delivery_detail_controller.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/models/delivery_detail_body_model.dart';
import 'package:lcmobileapp/models/delivery_detail_model.dart';
import 'package:lcmobileapp/models/token_timeout_model.dart';
import 'package:lcmobileapp/pages/home/home_page.dart';
import 'package:lcmobileapp/pages/tally/first_weight_page.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/app_icon.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/cargo_direct_widget.dart';
import 'package:lcmobileapp/widgets/edit_box_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FirstWeightDetailPage extends StatefulWidget {
  int pageId;
  FirstWeightDetailPage({super.key, required this.pageId});

  @override
  State<FirstWeightDetailPage> createState() => _FirstWeightDetailPageState();
}

class _FirstWeightDetailPageState extends State<FirstWeightDetailPage> {
  var _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    var weightController = TextEditingController();
    var remarkController = TextEditingController();

    DeliveryDetailModel _deliveryDetail =
        Get.find<DeliveryDetailController>().registerTicketList[widget.pageId];

    String vehiclePrimaryId = _deliveryDetail.vehiclePrimaryId!;
    String vehicleSecondaryId = _deliveryDetail.vehicleSecondaryId!;

    List<DeliveryDetailModel> _historyWeightEmptyList = [];

    var f = NumberFormat(AppContants.FORMAT_NUMER);

    void storeWeightNumber() {
      String number = weightController.text.trim();
      String remark = remarkController.text.trim();
      if (number.isEmpty) {
        showCustomSnackBar(AppMessage.ERROR_MESSAGE1,
            title: AppMessage.WEIGHT_INPUT);
      } else if (!GetUtils.isNum(number)) {
        showCustomSnackBar(AppMessage.ERROR_MESSAGE2,
            title: AppMessage.WEIGHT_INPUT);
      } else if (remark.length > 30) {
        showCustomSnackBar(AppMessage.ERROR_MESSAGE3,
            title: AppMessage.WEIGHT_INPUT);
      } else {
        String cargoDirection = _deliveryDetail.cargoDirection!;
        late DeliveryDetailModel deliveryDetailModel;
        if (cargoDirection == AppContants.LOADING ||
            cargoDirection == AppContants.STORAGE_IMPORT) {
          // Loading hoặc import thì cân vào là gross
          deliveryDetailModel = DeliveryDetailModel(
            operationTerminalId: _deliveryDetail.operationTerminalId,
            vesselVoyageId: _deliveryDetail.vesselVoyageId,
            deliveryOrderId: _deliveryDetail.deliveryOrderId,
            requestId: _deliveryDetail.requestId,
            vehiclePrimaryId: _deliveryDetail.vehiclePrimaryId,
            vehicleSecondaryId: _deliveryDetail.vehicleSecondaryId,
            vehicleType: _deliveryDetail.vehicleType,
            parentId: _deliveryDetail.parentId,
            serviceTypeId: _deliveryDetail.serviceTypeId,
            cargoDirection: _deliveryDetail.cargoDirection,
            planQuantity: _deliveryDetail.planQuantity,
            cargoId: _deliveryDetail.cargoId,
            unitId: _deliveryDetail.unitId,
            consigneeId: _deliveryDetail.consigneeId,
            delegateId: _deliveryDetail.delegateId,
            expiredDate: _deliveryDetail.expiredDate,
            tareWeight: "0",
            grossWeight: number, // số cân
            weightingType: _deliveryDetail.weightingType,
            manifestId: _deliveryDetail.manifestId,
            secondTerminalId: _deliveryDetail.secondTerminalId,
            vesselHoldId: _deliveryDetail.vesselHoldId,
            craneId: _deliveryDetail.craneId,
            printCount: _deliveryDetail.printCount,
            driverName: _deliveryDetail.driverName,
            driverMobile: _deliveryDetail.driverMobile,
            remark: remark, // ghi chú
            bargeVoyageId: _deliveryDetail.bargeVoyageId,
            destinationId: _deliveryDetail.destinationId,
            sourceId: _deliveryDetail.sourceId,
          );
        } else if (cargoDirection == AppContants.UNLOADING ||
            cargoDirection == AppContants.STORAGE_EXPORT) {
          // dỡ hàng hoặc xuất kho thì cân vào là empty
          deliveryDetailModel = DeliveryDetailModel(
            operationTerminalId: _deliveryDetail.operationTerminalId,
            vesselVoyageId: _deliveryDetail.vesselVoyageId,
            deliveryOrderId: _deliveryDetail.deliveryOrderId,
            requestId: _deliveryDetail.requestId,
            vehiclePrimaryId: _deliveryDetail.vehiclePrimaryId,
            vehicleSecondaryId: _deliveryDetail.vehicleSecondaryId,
            vehicleType: _deliveryDetail.vehicleType,
            parentId: _deliveryDetail.parentId,
            serviceTypeId: _deliveryDetail.serviceTypeId,
            cargoDirection: _deliveryDetail.cargoDirection,
            planQuantity: _deliveryDetail.planQuantity,
            cargoId: _deliveryDetail.cargoId,
            unitId: _deliveryDetail.unitId,
            consigneeId: _deliveryDetail.consigneeId,
            delegateId: _deliveryDetail.delegateId,
            expiredDate: _deliveryDetail.expiredDate,
            tareWeight: number,
            grossWeight: "0", // số cân
            weightingType: _deliveryDetail.weightingType,
            manifestId: _deliveryDetail.manifestId,
            secondTerminalId: _deliveryDetail.secondTerminalId,
            vesselHoldId: _deliveryDetail.vesselHoldId,
            craneId: _deliveryDetail.craneId,
            printCount: _deliveryDetail.printCount,
            driverName: _deliveryDetail.driverName,
            driverMobile: _deliveryDetail.driverMobile,
            remark: remark, // ghi chú
            bargeVoyageId: _deliveryDetail.bargeVoyageId,
            destinationId: _deliveryDetail.destinationId,
            sourceId: _deliveryDetail.sourceId,
          );
        }

        Get.find<DeliveryDetailController>()
            .storeWeight(deliveryDetailModel)
            .then(
          (status) {
            if (status.isSuccess) {
              Get.to(() => const HomePage(), arguments: "FirstWeight");
              Get.snackbar(
                  AppMessage.WEIGHT_INPUT, AppMessage.SUCCESS_MESSAGE1);
            } else {
              TokenTimeOut _tokenTimeOut =
                  Get.find<DeliveryDetailController>().tokenTimeOut;
              if (_tokenTimeOut.isTimeOut) {
                Get.find<UserController>().clearSharedData();
                Get.offNamed(RouteHelper.getLoginPage());
                Get.snackbar("Token", AppMessage.ERROR_MESSAGE5);
              } else {
                Get.snackbar(AppMessage.WEIGHT_INPUT, status.message);
              }
            }
          },
        );
      }
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.backgroundWhiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.backgroundWhiteColor,
          leading: BackButton(
            color: AppColor.mainColor,
            onPressed: () => Get.back(),
          ),
          centerTitle: true,
          title: BigText(
            text: AppMessage.WEIGHT_INPUT,
            color: AppColor.mainColor,
            size: Dimensions.fontSize25,
          ),
          elevation: 0,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
            unselectedLabelColor: AppColor.backgroundColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: AppIcon(
                    icon: Icons.info_outline,
                    iconColor: _currentTabIndex == 0
                        ? AppColor.mainColor
                        : Colors.grey,
                    iconSize: Dimensions.fontSize25,
                    backgroundColor: AppColor.backgroundWhiteColor),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: AppMessage.DETAIL_TAB,
                    size: Dimensions.fontSize16,
                    color: _currentTabIndex == 0
                        ? AppColor.mainColor
                        : Colors.grey,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                    icon: Icons.history,
                    iconColor: _currentTabIndex == 1
                        ? AppColor.mainColor
                        : Colors.grey,
                    iconSize: Dimensions.fontSize25,
                    backgroundColor: AppColor.backgroundWhiteColor),
                child: Align(
                    alignment: Alignment.center,
                    child: BigText(
                      text: AppMessage.HISTORY_TAB,
                      size: Dimensions.fontSize16,
                      color: _currentTabIndex == 1
                          ? AppColor.mainColor
                          : Colors.grey,
                    )),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width10,
                    right: Dimensions.width10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Tầu-sà lan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.VESSEL_BARGE,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.vesselCode!,
                              size: Dimensions.fontSize14,
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                            BigText(
                              text: "- ${_deliveryDetail.bargeCode}",
                              size: Dimensions.fontSize14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        )
                      ],
                    ),

                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // Xe / mooc (lượt)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.VEHICLE_MOOC_TURN,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.vehiclePrimaryCode!,
                              size: Dimensions.fontSize14,
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                            BigText(
                              text:
                                  " / ${_deliveryDetail.vehicleSecondaryCode!}",
                              size: Dimensions.fontSize14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            SmallText(
                              text:
                                  " (${_deliveryDetail.numOfTurn}/${_deliveryDetail.actualTurn})",
                              size: Dimensions.fontSize14,
                            )
                          ],
                        )
                      ],
                    ),

                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // Chủ hàng / Đại diện
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.CONSIGNEE_DELEGATE,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text:
                                  "${_deliveryDetail.manifestConsigneeCode} / ${_deliveryDetail.manifestDelegateCode}",
                              size: Dimensions.fontSize14,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    ),

                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // Bên nhận / Ủy thác
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.RECEIVE_DELEGATE,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.consigneeCode!,
                              size: Dimensions.fontSize14,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    ),

                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // Loại hàng
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.CARGO_CODE,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.cargoName!,
                              size: Dimensions.fontSize14,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    ),

                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // Vận đơn
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.BILLOFLANGDING,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.billOfLading!,
                              size: Dimensions.fontSize14,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    ),

                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // Vận đơn
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.SERVICE,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.serviceTypeName!,
                              size: Dimensions.fontSize14,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    ),

                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // Hướng hàng
                    CargoDirectWiget(
                        cargoDirectId: _deliveryDetail.cargoDirection!),
                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    //Điểm khai thác
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.OPERATION_TERMINAL,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.operationTerminalName!,
                              size: Dimensions.fontSize14,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    ),

                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    //Hàng còn lại
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.REMAIN_CARGO,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text:
                                  "${f.format(int.parse(_deliveryDetail.remainQuantity!))} (Kg)",
                              size: Dimensions.fontSize16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width10 / 5,
                          right: Dimensions.width10 / 5),
                      child: Column(
                        children: [
                          // nhập số cân
                          EditBoxWidget(
                            hint: AppMessage.INPUT_WEIGHT_NUMBER,
                            controller: weightController,
                            textAlign: TextAlign.right,
                            showClearIcon: true,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          // ghi chú
                          EditBoxWidget(
                            hint: AppMessage.REMARK,
                            controller: remarkController,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          // chấp nhận
                          Container(
                            margin: EdgeInsets.only(
                                top: Dimensions.height10,
                                left: Dimensions.width10,
                                right: Dimensions.width10),
                            child: SizedBox(
                              height: Dimensions.height20 * 2,
                              width:
                                  Dimensions.screenWidth - Dimensions.height20,
                              child: ElevatedButton(
                                onPressed: () {
                                  storeWeightNumber();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColor.mainColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius15),
                                          side: BorderSide(
                                              color: AppColor.mainColor))),
                                ),
                                child: BigText(
                                  text: AppMessage.ACCEPT,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width10,
                  right: Dimensions.width10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: Dimensions.height10 / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.all(Dimensions.width10),
                            child: BigText(
                              text: AppMessage.TARE_WEIGHT,
                              size: Dimensions.fontSize16,
                            )),
                        Container(
                            margin: EdgeInsets.all(Dimensions.width10),
                            child: BigText(
                              text: AppMessage.GROSS_WEIGHT,
                              size: Dimensions.fontSize16,
                            )),
                        Container(
                            margin: EdgeInsets.all(Dimensions.width10),
                            child: BigText(
                              text: AppMessage.WEIGHT_TIME,
                              size: Dimensions.fontSize16,
                            )),
                      ],
                    ),
                  ),
                  Expanded(child: GetBuilder<DeliveryDetailController>(
                    builder: (deliveryDetailController) {
                      deliveryDetailController.getHistoryWeight(
                          vehiclePrimaryId, vehicleSecondaryId);

                      Widget timeWidget(int index) {
                        var outputDate = DateTime.now().toString();
                        if (index <
                            deliveryDetailController.historyWeightList.length) {
                          DateTime parseDate =
                              DateFormat(AppContants.SQL_DATETIME_FORMAT).parse(
                                  deliveryDetailController
                                      .historyWeightList[index].grossTime!);
                          var inputDate = DateTime.parse(parseDate.toString());
                          var outputFormat =
                              DateFormat(AppContants.DATE_FORMAT);
                          outputDate = outputFormat.format(inputDate);
                        }
                        return SmallText(
                          text: outputDate,
                          size: Dimensions.fontSize16,
                        );
                      }

                      return ListView.builder(
                          itemCount:
                              deliveryDetailController.historyWeightList.length,
                          itemBuilder: (context, index) {
                            return deliveryDetailController.isLoaded
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // cân bì
                                          Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.width10),
                                            child: SmallText(
                                              text: f.format(int.parse(
                                                  deliveryDetailController
                                                      .historyWeightList[index]
                                                      .tareWeight!)),
                                              size: Dimensions.fontSize16,
                                            ),
                                          ),
                                          // cân cả hàng
                                          Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.width10),
                                            child: SmallText(
                                              text: f.format(int.parse(
                                                  deliveryDetailController
                                                      .historyWeightList[index]
                                                      .grossWeight!)),
                                              size: Dimensions.fontSize16,
                                            ),
                                          ),
                                          // thời gian cân
                                          Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.width10),
                                            child: timeWidget(index),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Dimensions.screenWidth -
                                                Dimensions.width20 * 2,
                                            height: 1.2,
                                            margin: EdgeInsets.only(
                                                top: 0,
                                                left: Dimensions.width10,
                                                right: Dimensions.width10),
                                            color: AppColor.lineColor,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : const CustomLoader();
                          });
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
