import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/controller/delivery_detail_controller.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/models/delivery_detail_model.dart';
import 'package:lcmobileapp/models/token_timeout_model.dart';
import 'package:lcmobileapp/pages/home/home_page.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/app_icon.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/cargo_direct_widget.dart';
import 'package:lcmobileapp/widgets/display_row_data_widget.dart';
import 'package:lcmobileapp/widgets/display_vehicle_widget.dart';
import 'package:lcmobileapp/widgets/edit_box_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dotted_line/dotted_line.dart';

class FirstWeightDetailPage extends StatefulWidget {
  int pageId;
  FirstWeightDetailPage({super.key, required this.pageId});

  @override
  State<FirstWeightDetailPage> createState() => _FirstWeightDetailPageState();
}

class _FirstWeightDetailPageState extends State<FirstWeightDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var weightController = TextEditingController();
    var remarkController = TextEditingController();

    DeliveryDetailModel _deliveryDetail =
        Get.find<DeliveryDetailController>().registerTicketList[widget.pageId];

    String vehiclePrimaryId = _deliveryDetail.vehiclePrimaryId!;
    String vehicleSecondaryId = _deliveryDetail.vehicleSecondaryId ?? "";

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
          // Loading ho???c import th?? c??n v??o l?? gross
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
            grossWeight: number, // s??? c??n
            weightingType: _deliveryDetail.weightingType,
            manifestId: _deliveryDetail.manifestId,
            secondTerminalId: _deliveryDetail.secondTerminalId,
            vesselHoldId: _deliveryDetail.vesselHoldId,
            craneId: _deliveryDetail.craneId,
            printCount: _deliveryDetail.printCount,
            driverName: _deliveryDetail.driverName,
            driverMobile: _deliveryDetail.driverMobile,
            remark: remark, // ghi ch??
            bargeVoyageId: _deliveryDetail.bargeVoyageId,
            destinationId: _deliveryDetail.destinationId,
            sourceId: _deliveryDetail.sourceId,
            workFlowCode: AppContants.GROSS_WF,
          );
        } else if (cargoDirection == AppContants.UNLOADING ||
            cargoDirection == AppContants.STORAGE_EXPORT) {
          // d??? h??ng ho???c xu???t kho th?? c??n v??o l?? empty
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
            grossWeight: "0", // s??? c??n
            weightingType: _deliveryDetail.weightingType,
            manifestId: _deliveryDetail.manifestId,
            secondTerminalId: _deliveryDetail.secondTerminalId,
            vesselHoldId: _deliveryDetail.vesselHoldId,
            craneId: _deliveryDetail.craneId,
            printCount: _deliveryDetail.printCount,
            driverName: _deliveryDetail.driverName,
            driverMobile: _deliveryDetail.driverMobile,
            remark: remark, // ghi ch??
            bargeVoyageId: _deliveryDetail.bargeVoyageId,
            destinationId: _deliveryDetail.destinationId,
            sourceId: _deliveryDetail.sourceId,
            workFlowCode: AppContants.TARE_WF,
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
            controller: _tabController,
            onTap: (index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: AppIcon(
                    icon: Icons.info_outline,
                    iconColor: _currentTabIndex == 0
                        ? AppColor.mainColor
                        : Colors.grey,
                    iconSize: Dimensions.fontSize20,
                    backgroundColor: AppColor.backgroundWhiteColor),
                iconMargin: EdgeInsets.only(
                    top: Dimensions.height10 + Dimensions.height5),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: AppMessage.DETAIL_TAB,
                    size: Dimensions.fontSize12,
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
                    iconSize: Dimensions.fontSize20,
                    backgroundColor: AppColor.backgroundWhiteColor),
                iconMargin: EdgeInsets.only(
                    top: Dimensions.height10 + Dimensions.height5),
                child: Align(
                    alignment: Alignment.center,
                    child: BigText(
                      text: AppMessage.HISTORY_TAB,
                      size: Dimensions.fontSize12,
                      color: _currentTabIndex == 1
                          ? AppColor.mainColor
                          : Colors.grey,
                    )),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height10,
                    left: Dimensions.width10,
                    right: Dimensions.width10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // T???u-s?? lan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.VESSEL_BARGE,
                          size: Dimensions.fontSize12,
                        ),
                        DisplayRowDataWidget(
                          firstField: _deliveryDetail.vesselCode.toString(),
                          secondField: _deliveryDetail.bargeCode ?? "",
                          firstSize: Dimensions.fontSize12,
                          secondSize: Dimensions.fontSize12,
                          firstColor: AppColor.mainColor,
                          secondColor: Colors.black,
                        )
                      ],
                    ),
                    DottedLine(
                      dashColor: AppColor.dotColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // Xe / mooc (l?????t)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.VEHICLE_MOOC_TURN,
                          size: Dimensions.fontSize12,
                        ),
                        DisplayVehicleWidget(
                          primaryCode:
                              _deliveryDetail.vehiclePrimaryCode.toString(),
                          secondaryCode:
                              _deliveryDetail.vehicleSecondaryCode ?? "",
                          numOfTurn: _deliveryDetail.numOfTurn.toString(),
                          actualOfTurn: _deliveryDetail.actualTurn.toString(),
                          size: Dimensions.fontSize12,
                        )
                      ],
                    ),

                    DottedLine(
                      dashColor: AppColor.dotColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // Ch??? h??ng / ?????i di???n
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.CONSIGNEE_DELEGATE,
                          size: Dimensions.fontSize12,
                        ),
                        DisplayRowDataWidget(
                          firstField:
                              _deliveryDetail.manifestConsigneeCode.toString(),
                          secondField:
                              _deliveryDetail.manifestDelegateCode ?? "",
                          firstColor: Colors.black,
                          secondColor: Colors.black,
                          firstSize: Dimensions.fontSize10,
                          secondSize: Dimensions.fontSize10,
                          char: "/",
                          fontWeight1: FontWeight.normal,
                          fontWeight2: FontWeight.normal,
                        )
                      ],
                    ),

                    DottedLine(
                      dashColor: AppColor.dotColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // B??n nh???n / ???y th??c
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.RECEIVE_DELEGATE,
                          size: Dimensions.fontSize12,
                        ),
                        DisplayRowDataWidget(
                          firstField: _deliveryDetail.consigneeCode.toString(),
                          secondField: _deliveryDetail.delegateCode ?? "",
                          firstColor: Colors.black,
                          secondColor: Colors.black,
                          firstSize: Dimensions.fontSize10,
                          secondSize: Dimensions.fontSize10,
                          char: "/",
                          fontWeight1: FontWeight.normal,
                          fontWeight2: FontWeight.normal,
                        )
                      ],
                    ),

                    DottedLine(
                      dashColor: AppColor.dotColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // Lo???i h??ng
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.CARGO_CODE,
                          size: Dimensions.fontSize12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.cargoName ?? "",
                              size: Dimensions.fontSize10,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    ),

                    DottedLine(
                      dashColor: AppColor.dotColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // V???n ????n
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.BILLOFLANGDING,
                          size: Dimensions.fontSize12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.billOfLading ?? "",
                              size: Dimensions.fontSize10,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    ),

                    DottedLine(
                      dashColor: AppColor.dotColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // V???n ????n
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.SERVICE,
                          size: Dimensions.fontSize12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.serviceTypeName ?? "",
                              size: Dimensions.fontSize10,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    ),

                    DottedLine(
                      dashColor: AppColor.dotColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // H?????ng h??ng
                    CargoDirectWiget(
                        cargoDirectId: _deliveryDetail.cargoDirection ?? ""),
                    DottedLine(
                      dashColor: AppColor.dotColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    //??i???m khai th??c
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.OPERATION_TERMINAL,
                          size: Dimensions.fontSize12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.operationTerminalName ?? "",
                              size: Dimensions.fontSize10,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    ),

                    DottedLine(
                      dashColor: AppColor.dotColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    //H??ng c??n l???i
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.REMAIN_CARGO,
                          size: Dimensions.fontSize12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text:
                                  "${f.format(int.parse(_deliveryDetail.remainQuantity ?? "0"))} (Kg)",
                              size: Dimensions.fontSize12,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        )
                      ],
                    ),
                    DottedLine(
                      dashColor: AppColor.dotColor,
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
                          // nh???p s??? c??n
                          EditBoxWidget(
                            hint: AppMessage.INPUT_WEIGHT_NUMBER,
                            controller: weightController,
                            textAlign: TextAlign.right,
                            showClearIcon: true,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          // ghi ch??
                          EditBoxWidget(
                            hint: AppMessage.REMARK,
                            controller: remarkController,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          // ch???p nh???n
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
                              size: Dimensions.fontSize12,
                            )),
                        Container(
                            margin: EdgeInsets.all(Dimensions.width10),
                            child: BigText(
                              text: AppMessage.GROSS_WEIGHT,
                              size: Dimensions.fontSize12,
                            )),
                        Container(
                            margin: EdgeInsets.all(Dimensions.width10),
                            child: BigText(
                              text: AppMessage.WEIGHT_TIME,
                              size: Dimensions.fontSize12,
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
                          size: Dimensions.fontSize12,
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
                                          // c??n b??
                                          Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.width10),
                                            child: SmallText(
                                              text: f.format(int.parse(
                                                  deliveryDetailController
                                                      .historyWeightList[index]
                                                      .tareWeight!)),
                                              size: Dimensions.fontSize12,
                                            ),
                                          ),
                                          // c??n c??? h??ng
                                          Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.width10),
                                            child: SmallText(
                                              text: f.format(int.parse(
                                                  deliveryDetailController
                                                      .historyWeightList[index]
                                                      .grossWeight!)),
                                              size: Dimensions.fontSize12,
                                            ),
                                          ),
                                          // th???i gian c??n
                                          Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.width10),
                                            child: timeWidget(index),
                                          ),
                                        ],
                                      ),
                                      DottedLine(
                                        dashColor: AppColor.dotColor,
                                      ),
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
