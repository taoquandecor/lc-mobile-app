import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/controller/delivery_detail_controller.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/models/barge_voyage_model.dart';
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
import 'package:lcmobileapp/widgets/edit_box_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TallyBerthDetailPage extends StatefulWidget {
  final int pageId;
  const TallyBerthDetailPage({super.key, required this.pageId});

  @override
  State<TallyBerthDetailPage> createState() => _TallyBerthDetailPageState();
}

class _TallyBerthDetailPageState extends State<TallyBerthDetailPage> {
  var _currentTabIndex = 0;
  String _vesselVoyageId = "";
  late DeliveryDetailModel _deliveryDetail;
  List<BargeVoyageModel> _bargeVoyageList = [];
  String _selectedValue = "";

  void LoadBargeVoyages() async {
    await Get.find<DeliveryDetailController>().getBargeVoyages(_vesselVoyageId);
    TokenTimeOut _tokenTimeOut =
        Get.find<DeliveryDetailController>().tokenTimeOut;

    if (_tokenTimeOut.isTimeOut) {
      Get.find<UserController>().clearSharedData();
      Get.offNamed(RouteHelper.getLoginPage());
      Get.snackbar("Token", AppMessage.ERROR_MESSAGE5);
    }
  }

  @override
  void initState() {
    super.initState();
    _deliveryDetail =
        Get.find<DeliveryDetailController>().pendingTicketList[widget.pageId];
    _vesselVoyageId = _deliveryDetail.vesselVoyageId.toString();
    LoadBargeVoyages();
  }

  @override
  void dispose() {
    super.dispose();
    _bargeVoyageList = [];
  }

  @override
  Widget build(BuildContext context) {
    var remarkController = TextEditingController();

    String formatDateTime(String weightTime) {
      var outputDate = DateTime.now().toString();

      DateTime parseDate =
          DateFormat(AppContants.SQL_DATETIME_FORMAT).parse(weightTime);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat(AppContants.DATE_FORMAT2);
      outputDate = outputFormat.format(inputDate);

      return outputDate;
    }

    void updateWeight() {
      String bargeVoyageId = this._selectedValue;
      String remark = remarkController.text.trim();
      if (bargeVoyageId.isEmpty) {
        showCustomSnackBar(AppMessage.SELECT_BARGE);
      } else {
        Get.find<DeliveryDetailController>()
            .updateBargeVoyage(
                bargeVoyageId, remark, _deliveryDetail.id.toString())
            .then((status) {
          if (status.isSuccess) {
            Get.to(() => const HomePage(), arguments: "TallyBerth");
            showCustomSnackBar(AppMessage.SUCCESS_MESSAGE1,
                title: AppMessage.TALLY_WEIGHT_BERTH,
                backColor: Colors.green,
                textColor: Colors.black);
          } else {
            TokenTimeOut _tokenTimeout =
                Get.find<DeliveryDetailController>().tokenTimeOut;
            if (_tokenTimeout.isTimeOut) {
              Get.find<UserController>().clearSharedData();
              Get.offNamed(RouteHelper.getLoginPage());
              Get.snackbar("Token", "Token is expired. Please login again!");
            } else {
              showCustomSnackBar(status.message);
            }
          }
        });
      }
    }

    var f = NumberFormat(AppContants.FORMAT_NUMER);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.backgroundWhiteColor,
        appBar: AppBar(
          leading: BackButton(
            color: AppColor.mainColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: BigText(
            text: AppMessage.TALLY_WEIGHT_BERTH,
            color: AppColor.mainColor,
            size: Dimensions.fontSize25,
          ),
          backgroundColor: AppColor.backgroundWhiteColor,
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
                  iconColor:
                      _currentTabIndex == 0 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
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
                  icon: Icons.phone_android,
                  iconSize: Dimensions.fontSize25,
                  iconColor:
                      _currentTabIndex == 1 ? AppColor.mainColor : Colors.grey,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: BigText(
                      text: AppMessage.TALLY_WEIGHT_BERTH,
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
            // Thông tin chi tiết phiếu cân
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width10,
                    right: Dimensions.width10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.DELIVERY_DETAIL_CODE,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.code ?? "",
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
                              text: _deliveryDetail.vesselCode ?? "",
                              size: Dimensions.fontSize14,
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                            BigText(
                              text: "- ${_deliveryDetail.bargeCode ?? ""}",
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
                    // Xe / mooc
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.VEHICLE_MOOC,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.vehiclePrimaryCode ?? "",
                              size: Dimensions.fontSize14,
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                            BigText(
                              text:
                                  " / ${_deliveryDetail.vehicleSecondaryCode ?? ""}",
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
                                  "${_deliveryDetail.manifestConsigneeCode ?? ""} / ${_deliveryDetail.manifestDelegateCode ?? ""}",
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
                              text:
                                  "${_deliveryDetail.consigneeCode ?? ""} / ${_deliveryDetail.delegateCode ?? ""}",
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
                              text: _deliveryDetail.cargoName ?? "",
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
                              text: _deliveryDetail.billOfLading ?? "",
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
                              text: _deliveryDetail.serviceTypeName ?? "",
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
                        cargoDirectId: _deliveryDetail.cargoDirection ?? ""),

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
                              text: _deliveryDetail.operationTerminalName ?? "",
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
                                  "${f.format(int.parse(_deliveryDetail.remainQuantity ?? "0"))} (Kg)",
                              size: Dimensions.fontSize16,
                              color: AppColor.mainColor,
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
                    //Cân bì
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.TARE_WEIGHT,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text:
                                  "${f.format(int.parse(_deliveryDetail.tareWeight ?? "0"))} (Kg) ${AppMessage.AT} ${formatDateTime(_deliveryDetail.tareTime.toString())}",
                              size: Dimensions.fontSize16,
                              color: AppColor.mainColor,
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
                  ],
                ),
              ),
            ),
            // Tally cầu bến, nhập tên sà lan cho phiếu cân
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    bottom: Dimensions.height10),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    //Cân bì
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.TARE_WEIGHT,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text:
                                  "${f.format(int.parse(_deliveryDetail.tareWeight ?? "0"))} (Kg) ${AppMessage.AT} ${formatDateTime(_deliveryDetail.tareTime.toString())}",
                              size: Dimensions.fontSize16,
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
                    //Cân bởi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.WEIGHT_BY,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text:
                                  _deliveryDetail.tareAccountDisplayName ?? "",
                              size: Dimensions.fontSize16,
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
                    //Lưu ý
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: AppMessage.NOTE,
                          size: Dimensions.fontSize16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: _deliveryDetail.remark ?? "",
                              size: Dimensions.fontSize16,
                              color: AppColor.mainColor,
                              overflow: TextOverflow.ellipsis,
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

                    GetBuilder<DeliveryDetailController>(
                        builder: (deliveryDetailController) {
                      _bargeVoyageList =
                          deliveryDetailController.bargeVoyageList;
                      return Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.height10,
                            left: Dimensions.width10 / 5,
                            right: Dimensions.width10 / 5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Dimensions.height45 * 1.2,
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: Dimensions.width10,
                                      horizontal: Dimensions.width10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Dimensions.radius15),
                                    ),
                                  ),
                                ),
                                value: _selectedValue == ""
                                    ? null
                                    : _selectedValue,
                                iconSize:
                                    Dimensions.height20 + Dimensions.height10,
                                isExpanded: true,
                                hint: const Text(AppMessage.SELECT_BARGE),
                                items: _bargeVoyageList.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id.toString(),
                                    child: Text(item.bargeCode.toString()),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedValue = value.toString();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                            // ghi chú
                            TextFormField(
                              controller: remarkController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        remarkController.text = "";
                                      });
                                    },
                                    icon: const Icon(Icons.clear)),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: Dimensions.width10,
                                    horizontal: Dimensions.width10),
                                hintText: AppMessage.REMARK,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                            // chấp nhận
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.height10,
                                  left: Dimensions.width10 / 5,
                                  right: Dimensions.width10 / 5),
                              child: SizedBox(
                                height: Dimensions.height45,
                                width: Dimensions.screenWidth -
                                    Dimensions.height20,
                                child: ElevatedButton(
                                  onPressed: () {
                                    updateWeight();
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
