import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/controller/delivery_detail_controller.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/models/delivery_detail_model.dart';
import 'package:lcmobileapp/models/token_timeout_model.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/app_icon.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:get/get.dart';

class FirstWeightPage extends StatefulWidget {
  const FirstWeightPage({super.key});

  @override
  State<FirstWeightPage> createState() => _FirstWeightPageState();
}

class _FirstWeightPageState extends State<FirstWeightPage> {
  int _currentIndex = 0;

  List<DeliveryDetailModel> _registerTicketList = [];
  List<DeliveryDetailModel> _pendingTicketList = [];

  late TokenTimeOut _tokenTimeOut;

  var _searchRegisterController = TextEditingController();
  var _searchPendingController = TextEditingController();

  Future<void> _loadResources() async {
    await Get.find<DeliveryDetailController>().getRegistrationTicketList();
    _registerTicketList =
        Get.find<DeliveryDetailController>().registerTicketList;

    _tokenTimeOut = Get.find<DeliveryDetailController>().tokenTimeOut;

    if (_tokenTimeOut.isTimeOut) {
      Get.find<UserController>().clearSharedData();
      Get.offNamed(RouteHelper.getLoginPage());
      Get.snackbar("Token", AppMessage.ERROR_MESSAGE5);
    }

    await Get.find<DeliveryDetailController>().getPendingTicketList();

    _pendingTicketList = Get.find<DeliveryDetailController>().pendingTicketList;
  }

  @override
  void initState() {
    _searchRegisterController.addListener(() {
      _searchRegisterController.text;
    });
    _searchPendingController.addListener(() {
      _searchPendingController.text;
    });

    super.initState();
    _loadResources();
  }

  @override
  void dispose() {
    _searchRegisterController.dispose();
    _searchPendingController.dispose();
    super.dispose();
    _registerTicketList = [];
    _pendingTicketList = [];
  }

  void onSearchTextChanged(String text) {
    List<DeliveryDetailModel> results = [];
    if (_currentIndex == 0) {
      // tab kế hoạch
      if (text.isEmpty) {
        results = _registerTicketList;
      } else {
        results = _registerTicketList
            .where((search) =>
                search.vehiclePrimaryCode!.contains(text) ||
                search.vehicleSecondaryCode!.contains(text) ||
                search.bargeCode!.contains(text) ||
                search.consigneeCode!.contains(text))
            .toList();
      }
      setState(() {
        _registerTicketList = results;
      });
    } else if (_currentIndex == 1) {
      // tab cân chốt
      if (text.isEmpty) {
        results = _pendingTicketList;
      } else {
        results = _pendingTicketList
            .where((search) =>
                search.vehiclePrimaryCode!.contains(text) ||
                search.vehicleSecondaryCode!.contains(text) ||
                search.bargeCode!.contains(text) ||
                search.consigneeCode!.contains(text))
            .toList();
      }
      setState(() {
        _pendingTicketList = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColor.backgroundWhiteColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: BigText(
              text: AppMessage.TALLY_WEIGHT_BOT,
              size: Dimensions.fontSize25,
              color: AppColor.mainColor,
            ),
            backgroundColor: AppColor.backgroundWhiteColor,
            toolbarHeight: Dimensions.height20 * 2,
            elevation: 0,
            bottom: TabBar(
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              labelColor: Colors.black,
              unselectedLabelColor: AppColor.backgroundWhiteColor,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  icon: AppIcon(
                      icon: Icons.list,
                      iconColor:
                          _currentIndex == 0 ? AppColor.mainColor : Colors.grey,
                      iconSize: Dimensions.fontSize25,
                      backgroundColor: AppColor.backgroundWhiteColor),
                  child: Align(
                    alignment: Alignment.center,
                    child: BigText(
                      text: AppMessage.WEIGHT_PLAN_TAB,
                      size: Dimensions.fontSize14,
                      color:
                          _currentIndex == 0 ? AppColor.mainColor : Colors.grey,
                    ),
                  ),
                ),
                Tab(
                  icon: AppIcon(
                      icon: Icons.monitor_weight_outlined,
                      iconColor:
                          _currentIndex == 1 ? AppColor.mainColor : Colors.grey,
                      iconSize: Dimensions.fontSize25,
                      backgroundColor: AppColor.backgroundWhiteColor),
                  child: Align(
                      alignment: Alignment.center,
                      child: BigText(
                        text: AppMessage.WEIGHT_NET_TAB,
                        size: Dimensions.fontSize14,
                        color: _currentIndex == 1
                            ? AppColor.mainColor
                            : Colors.grey,
                      )),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GetBuilder<DeliveryDetailController>(
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
                                    controller: _searchRegisterController,
                                    onChanged: (value) {
                                      onSearchTextChanged(value);
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: Dimensions.width10,
                                          horizontal: Dimensions.width10),
                                      hintText:
                                          AppMessage.HINT_TEXT_TALLY_WEIGHT_BOT,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _searchRegisterController.text = "";
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
                                    itemCount: _registerTicketList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(RouteHelper
                                              .getFirstWeightDetailPage(index));
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        BigText(
                                                          text:
                                                              _registerTicketList[
                                                                      index]
                                                                  .vesselCode!,
                                                          size: Dimensions
                                                              .fontSize14,
                                                          color: AppColor
                                                              .mainColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        BigText(
                                                          text:
                                                              "- ${_registerTicketList[index].bargeCode ?? ""}",
                                                          size: Dimensions
                                                              .fontSize12,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        BigText(
                                                          text: _registerTicketList[
                                                                  index]
                                                              .consigneeCode!,
                                                          size: Dimensions
                                                              .fontSize12,
                                                          color: Colors.green,
                                                        ),
                                                        BigText(
                                                          text:
                                                              "/ ${_registerTicketList[index].delegateCode}",
                                                          size: Dimensions
                                                              .fontSize12,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10,
                                                    ),
                                                    BigText(
                                                      text: _registerTicketList[
                                                              index]
                                                          .cargoName!,
                                                      size:
                                                          Dimensions.fontSize12,
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
                                                          text: _registerTicketList[
                                                                  index]
                                                              .vehiclePrimaryCode!,
                                                          size: Dimensions
                                                              .fontSize12,
                                                          color: AppColor
                                                              .mainColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        BigText(
                                                          text:
                                                              " / ${_registerTicketList[index].vehicleSecondaryCode}",
                                                          size: Dimensions
                                                              .fontSize12,
                                                          color: Colors.black,
                                                        ),
                                                        SmallText(
                                                          text:
                                                              " (${_registerTicketList[index].numOfTurn}/${_registerTicketList[index].actualTurn})",
                                                          size: Dimensions
                                                              .fontSize12,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10,
                                                    ),
                                                    BigText(
                                                      text: _registerTicketList[
                                                              index]
                                                          .serviceTypeName!,
                                                      size:
                                                          Dimensions.fontSize12,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10,
                                                    ),
                                                    BigText(
                                                      text: _registerTicketList[
                                                              index]
                                                          .operationTerminalName!,
                                                      size:
                                                          Dimensions.fontSize12,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10 / 2,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: Dimensions
                                                          .screenWidth -
                                                      Dimensions.width15 * 2,
                                                  height: 1.2,
                                                  margin: const EdgeInsets.only(
                                                      top: 0),
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
              GetBuilder<DeliveryDetailController>(
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
                                  controller: _searchPendingController,
                                  onChanged: (value) {
                                    onSearchTextChanged(value);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: Dimensions.width10,
                                        horizontal: Dimensions.width10),
                                    hintText:
                                        AppMessage.HINT_TEXT_TALLY_WEIGHT_BOT,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15),
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _searchPendingController.text = "";
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
                                  itemCount: _pendingTicketList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(RouteHelper
                                            .getSecondWeightDetailPage(index));
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
                                                        text:
                                                            _pendingTicketList[
                                                                    index]
                                                                .vesselCode!,
                                                        size: Dimensions
                                                            .fontSize14,
                                                        color:
                                                            AppColor.mainColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      BigText(
                                                        text:
                                                            "- ${_pendingTicketList[index].bargeCode}",
                                                        size: Dimensions
                                                            .fontSize12,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      BigText(
                                                        text:
                                                            _pendingTicketList[
                                                                    index]
                                                                .consigneeCode!,
                                                        size: Dimensions
                                                            .fontSize12,
                                                        color: Colors.green,
                                                      ),
                                                      BigText(
                                                        text:
                                                            "/ ${_pendingTicketList[index].delegateCode}",
                                                        size: Dimensions
                                                            .fontSize12,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height10,
                                                  ),
                                                  BigText(
                                                    text: _pendingTicketList[
                                                            index]
                                                        .cargoName!,
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
                                                        text: _pendingTicketList[
                                                                index]
                                                            .vehiclePrimaryCode!,
                                                        size: Dimensions
                                                            .fontSize12,
                                                        color:
                                                            AppColor.mainColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      BigText(
                                                        text:
                                                            " / ${_pendingTicketList[index].vehicleSecondaryCode}",
                                                        size: Dimensions
                                                            .fontSize12,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height10,
                                                  ),
                                                  BigText(
                                                    text: _pendingTicketList[
                                                            index]
                                                        .serviceTypeName!,
                                                    size: Dimensions.fontSize12,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height10,
                                                  ),
                                                  BigText(
                                                    text: _pendingTicketList[
                                                            index]
                                                        .operationTerminalName!,
                                                    size: Dimensions.fontSize12,
                                                    color: Colors.black,
                                                  ),
                                                ],
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
                                                margin: const EdgeInsets.only(
                                                    top: 0),
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
                              )
                            ],
                          ),
                        ),
                      )
                    : const CustomLoader();
              }),
            ],
          )),
    );
  }
}
