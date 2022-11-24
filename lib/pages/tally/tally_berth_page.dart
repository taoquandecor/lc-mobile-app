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

class TallyBerthPage extends StatefulWidget {
  const TallyBerthPage({super.key});

  @override
  State<TallyBerthPage> createState() => TallyBerthPageState();
}

class TallyBerthPageState extends State<TallyBerthPage> {
  var _searchController = TextEditingController();

  List<DeliveryDetailModel> _tallyTicketList = [];

  var f = NumberFormat(AppContants.FORMAT_NUMER);

  late TokenTimeOut _tokenTimeOut;

  Future<void> _loadResources() async {
    await Get.find<DeliveryDetailController>().getPendingTicketList();

    _tokenTimeOut = Get.find<DeliveryDetailController>().tokenTimeOut;
    if (_tokenTimeOut.isTimeOut) {
      Get.find<UserController>().clearSharedData();
      Get.offNamed(RouteHelper.getLoginPage());
      Get.snackbar("Token", AppMessage.ERROR_MESSAGE5);
    }

    _tallyTicketList = Get.find<DeliveryDetailController>().pendingTicketList;
  }

  void onSearchTextChanged(String text) {
    List<DeliveryDetailModel> results = [];

    // tab kế hoạch
    if (text.isEmpty) {
      results = _tallyTicketList;
    } else {
      results = _tallyTicketList
          .where((search) =>
              search.vehiclePrimaryCode!.contains(text) ||
              search.vehicleSecondaryCode!.contains(text) ||
              search.bargeCode!.contains(text) ||
              search.consigneeCode!.contains(text))
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
        elevation: 1,
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
                        top: Dimensions.height10 / 2,
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
                                            Row(
                                              children: [
                                                BigText(
                                                  text: _tallyTicketList[index]
                                                          .vesselCode ??
                                                      "",
                                                  size: Dimensions.fontSize14,
                                                  color: AppColor.mainColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                BigText(
                                                  text:
                                                      "- ${_tallyTicketList[index].bargeCode ?? ""}",
                                                  size: Dimensions.fontSize12,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                            Row(
                                              children: [
                                                BigText(
                                                  text: _tallyTicketList[index]
                                                          .consigneeCode ??
                                                      "",
                                                  size: Dimensions.fontSize12,
                                                  color: Colors.green,
                                                ),
                                                BigText(
                                                  text:
                                                      "/ ${_tallyTicketList[index].delegateCode ?? ""}",
                                                  size: Dimensions.fontSize12,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                            BigText(
                                              text:
                                                  "${_tallyTicketList[index].billOfLading ?? ""} - ${_tallyTicketList[index].cargoName ?? ""}",
                                              size: Dimensions.fontSize12,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                BigText(
                                                  text: _tallyTicketList[index]
                                                          .vehiclePrimaryCode ??
                                                      "",
                                                  size: Dimensions.fontSize12,
                                                  color: AppColor.mainColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                BigText(
                                                  text:
                                                      " / ${_tallyTicketList[index].vehicleSecondaryCode ?? ""}",
                                                  size: Dimensions.fontSize12,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                            BigText(
                                              text: _tallyTicketList[index]
                                                      .serviceTypeName ??
                                                  "",
                                              size: Dimensions.fontSize12,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                            BigText(
                                              text: _tallyTicketList[index]
                                                      .operationTerminalName ??
                                                  "",
                                              size: Dimensions.fontSize12,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Row(
                                      children: [
                                        BigText(
                                          text: AppMessage.TARE,
                                          size: Dimensions.fontSize12,
                                        ),
                                        BigText(
                                          text:
                                              "${f.format(int.parse(_tallyTicketList[index].tareWeight.toString()))} (Kg)",
                                          size: Dimensions.fontSize12,
                                          color: AppColor.mainColor,
                                        ),
                                        BigText(
                                          text:
                                              " ${AppMessage.AT} ${formatDateTime(_tallyTicketList[index].tareTime.toString())} ${AppMessage.FOR} ${_tallyTicketList[index].tareAccountDisplayName}",
                                          size: Dimensions.fontSize12,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: Dimensions.screenWidth -
                                              Dimensions.width15 * 2,
                                          height: 1.2,
                                          margin: const EdgeInsets.only(top: 0),
                                          color: AppColor.lineColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
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
    );
  }
}
