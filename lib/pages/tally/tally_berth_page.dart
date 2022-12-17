import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/controller/delivery_detail_controller.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/models/delivery_detail_model.dart';
import 'package:lcmobileapp/models/token_timeout_model.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lcmobileapp/widgets/display_row_data_widget.dart';
import 'package:lcmobileapp/widgets/manifest_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';

class TallyBerthPage extends StatefulWidget {
  const TallyBerthPage({super.key});

  @override
  State<TallyBerthPage> createState() => TallyBerthPageState();
}

class TallyBerthPageState extends State<TallyBerthPage> {
  var _searchController = TextEditingController();

  List<DeliveryDetailModel> _tallyTicketList = [];
  List<DeliveryDetailModel> _tempTallyTicketList = [];

  var f = NumberFormat(AppContants.FORMAT_NUMER);

  late TokenTimeOut _tokenTimeOut;

  Future<void> _loadResources() async {
    await Get.find<DeliveryDetailController>().getTallyBerthTicketList();

    _tokenTimeOut = Get.find<DeliveryDetailController>().tokenTimeOut;
    if (_tokenTimeOut.isTimeOut) {
      Get.find<UserController>().clearSharedData();
      Get.offNamed(RouteHelper.getLoginPage());
      Get.snackbar("Token", AppMessage.ERROR_MESSAGE5);
    }

    _tallyTicketList =
        Get.find<DeliveryDetailController>().tallyBerthTicketList;
    _tempTallyTicketList = _tallyTicketList;
  }

  void onSearchTextChanged(String text) {
    List<DeliveryDetailModel> results = [];

    // tab kế hoạch
    if (text.isEmpty) {
      results = _tempTallyTicketList;
    } else {
      results = _tallyTicketList
          .where((search) => search.vehiclePrimaryCode!.contains(text))
          .toList();
    }
    setState(() {
      _tallyTicketList = results;
    });
  }

  String formatDateTime(String weightTime) {
    var outputDate = DateTime.now().toString();

    DateTime parseDate =
        DateFormat(AppContants.SQL_DATETIME_FORMAT).parse(weightTime);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat(AppContants.DATE_FORMAT3);
    outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  @override
  void initState() {
    _searchController.addListener(() {
      _searchController.text;
    });

    super.initState();
    _loadResources();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
    _tallyTicketList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundWhiteColor,
        centerTitle: true,
        elevation: 0,
        title: BigText(
          text: AppMessage.TALLY_WEIGHT_BERTH,
          color: AppColor.mainColor,
        ),
      ),
      body: GetBuilder<DeliveryDetailController>(
        builder: (deliveryDetailController) {
          return deliveryDetailController.isLoaded
              ? SingleChildScrollView(
                  child: Container(
                    color: AppColor.backgroundWhiteColor,
                    margin: EdgeInsets.only(
                        top: Dimensions.height10,
                        left: Dimensions.width10,
                        right: Dimensions.width10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.height10 / 2,
                        ),
                        SizedBox(
                          height: Dimensions.height45,
                          child: TextFormField(
                            controller: _searchController,
                            onChanged: (value) {
                              onSearchTextChanged(value);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: Dimensions.width10,
                                  horizontal: Dimensions.width10),
                              hintText: AppMessage.HINT_TEXT_TALLY_WEIGHT_BOT,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _searchController.text = "";
                                  });
                                  onSearchTextChanged('');
                                },
                                child: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Container(
                          height: Dimensions.pageListView,
                          padding: EdgeInsets.only(
                              top: Dimensions.height10,
                              left: Dimensions.width10 / 2,
                              right: Dimensions.width10 / 2,
                              bottom: Dimensions.height10),
                          child: RefreshIndicator(
                            onRefresh: () {
                              return Future.delayed(
                                const Duration(seconds: 1),
                                () async {
                                  await deliveryDetailController
                                      .getTallyBerthTicketList();
                                  setState(() {
                                    _tallyTicketList = deliveryDetailController
                                        .tallyBerthTicketList;
                                    _tempTallyTicketList = _tallyTicketList;
                                  });
                                },
                              );
                            },
                            child: ListView.builder(
                              itemCount: _tallyTicketList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        RouteHelper.getTallyBerthDetailPage(
                                            index));
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
                                                    _tallyTicketList[index]
                                                        .vesselCode
                                                        .toString(),
                                                secondField:
                                                    _tallyTicketList[index]
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
                                                    _tallyTicketList[index]
                                                        .consigneeCode
                                                        .toString(),
                                                firstColor: Colors.green,
                                                firstSize:
                                                    Dimensions.fontSize10,
                                                secondSize:
                                                    Dimensions.fontSize10,
                                                secondField:
                                                    _tallyTicketList[index]
                                                            .delegateCode ??
                                                        "",
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 5,
                                              ),
                                              BigText(
                                                text: _tallyTicketList[index]
                                                        .operationTerminalCode ??
                                                    "",
                                                size: Dimensions.fontSize10,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
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
                                                        text: _tallyTicketList[
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
                                                        text: _tallyTicketList[
                                                                        index]
                                                                    .vehicleSecondaryCode
                                                                    .toString() ==
                                                                "null"
                                                            ? ""
                                                            : "/ ${_tallyTicketList[index].vehicleSecondaryCode ?? ""}",
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
                                                        text: _tallyTicketList[
                                                                    index]
                                                                .code ??
                                                            "",
                                                        size: Dimensions
                                                                .fontSize12 -
                                                            4,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 5,
                                              ),
                                              BigText(
                                                text: _tallyTicketList[index]
                                                    .serviceTypeName!,
                                                size: Dimensions.fontSize10,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 5,
                                              ),
                                              // chủ hàng ủy thác loại hàng billoflading
                                              ManifestWidget(
                                                billOfLading:
                                                    _tallyTicketList[index]
                                                            .billOfLading ??
                                                        "",
                                                consigneeCode: _tallyTicketList[
                                                            index]
                                                        .manifestConsigneeCode ??
                                                    "",
                                                cargoCode:
                                                    _tallyTicketList[index]
                                                            .cargoCode ??
                                                        "",
                                                delegrateCode:
                                                    _tallyTicketList[index]
                                                            .delegateCode ??
                                                        "",
                                                size: Dimensions.fontSize10,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10 / 5,
                                      ),
                                      Row(
                                        children: [
                                          BigText(
                                            text: AppMessage.WEIGHT_IN,
                                            size: Dimensions.fontSize10,
                                            color: Colors.black,
                                          ),
                                          BigText(
                                            text:
                                                "${f.format(int.parse(_tallyTicketList[index].tareWeight.toString()))} (Kg) ",
                                            size: Dimensions.fontSize10,
                                            color: AppColor.mainColor,
                                          ),
                                          BigText(
                                            text:
                                                " ${AppMessage.AT} ${formatDateTime(_tallyTicketList[index].tareTime.toString())} ${AppMessage.FOR} ${_tallyTicketList[index].tareAccountDisplayName}",
                                            size: Dimensions.fontSize10,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10 / 5,
                                      ),
                                      Container(
                                        width: Dimensions.screenWidth,
                                        height: 1.2,
                                        margin: const EdgeInsets.only(top: 0),
                                        color: AppColor.lineColor,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10 / 5,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
