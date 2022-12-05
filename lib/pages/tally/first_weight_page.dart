import 'package:flutter/gestures.dart';
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
import 'package:lcmobileapp/widgets/app_icon.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/display_row_data_widget.dart';
import 'package:lcmobileapp/widgets/display_vehicle_widget.dart';
import 'package:lcmobileapp/widgets/manifest_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lcmobileapp/widgets/small_text.dart';

class FirstWeightPage extends StatefulWidget {
  const FirstWeightPage({super.key});

  @override
  State<FirstWeightPage> createState() => _FirstWeightPageState();
}

class _FirstWeightPageState extends State<FirstWeightPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  List<DeliveryDetailModel> _registerTicketList = [];
  List<DeliveryDetailModel> _tempRegisterTicketList = [];
  List<DeliveryDetailModel> _pendingTicketList = [];
  List<DeliveryDetailModel> _tempPendingTicketList = [];

  List<DeliveryDetailModel> _ticketList = [];
  List<DeliveryDetailModel> _tempTicketList = [];

  late TokenTimeOut _tokenTimeOut;
  var f = NumberFormat(AppContants.FORMAT_NUMER);

  var _searchRegisterController = TextEditingController();
  var _searchTicketController = TextEditingController();
  var _searchPendingController = TextEditingController();

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
    // Lấy danh sách phiếu cân kế hoạch
    await Get.find<DeliveryDetailController>().getRegistrationTicketList();
    _registerTicketList =
        Get.find<DeliveryDetailController>().registerTicketList;
    _tempRegisterTicketList = _registerTicketList;

    _tokenTimeOut = Get.find<DeliveryDetailController>().tokenTimeOut;

    if (_tokenTimeOut.isTimeOut) {
      Get.find<UserController>().clearSharedData();
      Get.offNamed(RouteHelper.getLoginPage());
      Get.snackbar("Token", AppMessage.ERROR_MESSAGE5);
    }

    // lấy danh sách phiếu cân
    await Get.find<DeliveryDetailController>().getTicketList();
    _ticketList = Get.find<DeliveryDetailController>().ticketList;
    _tempTicketList = _ticketList;

    // lấy danh sách phiếu cân chờ chốt
    await Get.find<DeliveryDetailController>().getPendingTicketList();

    _pendingTicketList = Get.find<DeliveryDetailController>().pendingTicketList;
    _tempPendingTicketList = _pendingTicketList;
  }

  @override
  void initState() {
    _searchRegisterController.addListener(() {
      _searchRegisterController.text;
    });
    _searchTicketController.addListener(() {
      _searchTicketController.text;
    });
    _searchPendingController.addListener(() {
      _searchPendingController.text;
    });

    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    _loadResources();
  }

  @override
  void dispose() {
    _searchRegisterController.dispose();
    _searchTicketController.dispose();
    _searchPendingController.dispose();
    _tabController.dispose();
    super.dispose();
    _registerTicketList = [];
    _ticketList = [];
    _pendingTicketList = [];
  }

  void onSearchTextChanged(String text) {
    List<DeliveryDetailModel> results = [];
    if (_currentIndex == 0) {
      // tab kế hoạch
      if (text.isEmpty) {
        results = _tempRegisterTicketList;
      } else {
        results = _registerTicketList
            .where((search) => search.vehiclePrimaryCode!.contains(text))
            .toList();
      }
      setState(() {
        _registerTicketList = results;
      });
    } else if (_currentIndex == 1) {
      // tab phiếu cân
      if (text.isEmpty) {
        results = _tempTicketList;
      } else {
        results = _ticketList
            .where((search) => search.vehiclePrimaryCode!.contains(text))
            .toList();
      }
      setState(() {
        _ticketList = results;
      });
    } else if (_currentIndex == 2) {
      // tab cân chốt
      if (text.isEmpty) {
        results = _tempPendingTicketList;
      } else {
        results = _pendingTicketList
            .where((search) => search.vehiclePrimaryCode!.contains(text))
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
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.backgroundWhiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: BigText(
            text: AppMessage.TALLY_WEIGHT_BOT,
            size: Dimensions.fontSize14,
            color: AppColor.mainColor,
          ),
          backgroundColor: AppColor.backgroundWhiteColor,
          toolbarHeight: Dimensions.height20 + Dimensions.height10,
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              // Kế hoạch
              Tab(
                icon: AppIcon(
                  icon: Icons.list,
                  iconColor:
                      _currentIndex == 0 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize20,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                iconMargin: EdgeInsets.only(
                    top: Dimensions.height10 + Dimensions.height5),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: BigText(
                    text: AppMessage.WEIGHT_PLAN_TAB,
                    size: Dimensions.fontSize12,
                    color:
                        _currentIndex == 0 ? AppColor.mainColor : Colors.grey,
                  ),
                ),
              ),
              // Phiếu cân
              Tab(
                icon: AppIcon(
                  icon: Icons.note,
                  iconColor:
                      _currentIndex == 1 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize20,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                iconMargin: EdgeInsets.only(
                    top: Dimensions.height10 + Dimensions.height5),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: BigText(
                    text: AppMessage.WEIGHT_TICKET,
                    size: Dimensions.fontSize12,
                    color:
                        _currentIndex == 1 ? AppColor.mainColor : Colors.grey,
                  ),
                ),
              ),
              // Cân chốt
              Tab(
                icon: AppIcon(
                    icon: Icons.monitor_weight_outlined,
                    iconColor:
                        _currentIndex == 2 ? AppColor.mainColor : Colors.grey,
                    iconSize: Dimensions.fontSize20,
                    backgroundColor: AppColor.backgroundWhiteColor),
                iconMargin: EdgeInsets.only(
                    top: Dimensions.height10 + Dimensions.height5),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: BigText(
                      text: AppMessage.WEIGHT_NET_TAB,
                      size: Dimensions.fontSize12,
                      color:
                          _currentIndex == 2 ? AppColor.mainColor : Colors.grey,
                    )),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Kế hoạch
            GetBuilder<DeliveryDetailController>(
              builder: (deliveryDetailController) {
                return deliveryDetailController.isLoaded
                    ? SingleChildScrollView(
                        child: Container(
                          color: AppColor.backgroundWhiteColor,
                          margin: EdgeInsets.only(
                              top: Dimensions.height10 / 5,
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
                                height: Dimensions.height10 / 5,
                              ),
                              Container(
                                height: Dimensions.pageListView,
                                margin: EdgeInsets.only(
                                  top: Dimensions.height10,
                                  left: Dimensions.width10 / 2,
                                  right: Dimensions.width10 / 2,
                                  bottom: Dimensions.height10,
                                ),
                                child: RefreshIndicator(
                                  onRefresh: () {
                                    return Future.delayed(
                                      const Duration(seconds: 1),
                                      () {
                                        setState(() {
                                          deliveryDetailController
                                              .getRegistrationTicketList();
                                          _registerTicketList =
                                              deliveryDetailController
                                                  .registerTicketList;
                                          _tempRegisterTicketList =
                                              _registerTicketList;
                                        });
                                      },
                                    );
                                  },
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
                                                    // Tầu sàlan
                                                    DisplayRowDataWidget(
                                                      firstField:
                                                          _registerTicketList[
                                                                  index]
                                                              .vesselCode
                                                              .toString(),
                                                      secondField:
                                                          _registerTicketList[
                                                                      index]
                                                                  .bargeCode ??
                                                              "",
                                                      firstColor:
                                                          AppColor.mainColor,
                                                      firstSize:
                                                          Dimensions.fontSize14,
                                                      secondSize:
                                                          Dimensions.fontSize12,
                                                      fontWeight2:
                                                          FontWeight.normal,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10 /
                                                              5,
                                                    ),
                                                    // Ben nhan va Uy thac
                                                    DisplayRowDataWidget(
                                                      firstField:
                                                          _registerTicketList[
                                                                  index]
                                                              .consigneeCode
                                                              .toString(),
                                                      firstColor: Colors.green,
                                                      firstSize:
                                                          Dimensions.fontSize10,
                                                      secondSize:
                                                          Dimensions.fontSize10,
                                                      secondField:
                                                          _registerTicketList[
                                                                      index]
                                                                  .delegateCode ??
                                                              "",
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10 /
                                                              5,
                                                    ),

                                                    BigText(
                                                      text: _registerTicketList[
                                                                  index]
                                                              .operationTerminalCode ??
                                                          "",
                                                      size:
                                                          Dimensions.fontSize10,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    // Biển số xe , Biển số Mooc
                                                    DisplayVehicleWidget(
                                                      primaryCode:
                                                          _registerTicketList[
                                                                  index]
                                                              .vehiclePrimaryCode
                                                              .toString(),
                                                      secondaryCode:
                                                          _registerTicketList[
                                                                      index]
                                                                  .vehicleSecondaryCode ??
                                                              "",
                                                      numOfTurn:
                                                          _registerTicketList[
                                                                  index]
                                                              .numOfTurn
                                                              .toString(),
                                                      actualOfTurn:
                                                          _registerTicketList[
                                                                  index]
                                                              .actualTurn
                                                              .toString(),
                                                      size:
                                                          Dimensions.fontSize12,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10 /
                                                              5,
                                                    ),
                                                    BigText(
                                                      text: _registerTicketList[
                                                                  index]
                                                              .serviceTypeName ??
                                                          "",
                                                      size:
                                                          Dimensions.fontSize10,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10 /
                                                              5,
                                                    ),
                                                    // chủ hàng ủy thác loại hàng billoflading
                                                    ManifestWidget(
                                                      billOfLading:
                                                          _registerTicketList[
                                                                      index]
                                                                  .billOfLading ??
                                                              "",
                                                      consigneeCode:
                                                          _registerTicketList[
                                                                      index]
                                                                  .manifestConsigneeCode ??
                                                              "",
                                                      cargoCode:
                                                          _registerTicketList[
                                                                      index]
                                                                  .cargoCode ??
                                                              "",
                                                      delegrateCode:
                                                          _registerTicketList[
                                                                      index]
                                                                  .delegateCode ??
                                                              "",
                                                      size:
                                                          Dimensions.fontSize10,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10 / 5,
                                            ),
                                            Container(
                                              width: Dimensions.screenWidth,
                                              height: 1.2,
                                              margin:
                                                  const EdgeInsets.only(top: 0),
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
            // Phiếu cân
            GetBuilder<DeliveryDetailController>(builder: (ticketController) {
              return ticketController.isLoaded
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
                                controller: _searchTicketController,
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
                                        _searchTicketController.text = "";
                                      });
                                      onSearchTextChanged('');
                                    },
                                    child: const Icon(Icons.clear),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10 / 5,
                            ),
                            Container(
                              height: Dimensions.pageListView,
                              padding: EdgeInsets.only(
                                  top: Dimensions.height10 / 2,
                                  left: Dimensions.width10 / 2,
                                  right: Dimensions.width10 / 2,
                                  bottom: Dimensions.height10),
                              child: RefreshIndicator(
                                onRefresh: () {
                                  return Future.delayed(
                                    const Duration(seconds: 1),
                                    () {
                                      setState(() {
                                        ticketController.getTicketList();
                                        _ticketList =
                                            ticketController.ticketList;
                                        _tempTicketList = _ticketList;
                                      });
                                    },
                                  );
                                },
                                child: ListView.builder(
                                  itemCount: _ticketList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            RouteHelper.getUploadTicketPage(
                                                index));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                        _ticketList[index]
                                                            .vesselCode
                                                            .toString(),
                                                    secondField:
                                                        _ticketList[index]
                                                                .bargeCode ??
                                                            "",
                                                    firstColor:
                                                        AppColor.mainColor,
                                                    firstSize:
                                                        Dimensions.fontSize14,
                                                    secondSize:
                                                        Dimensions.fontSize12,
                                                    fontWeight2:
                                                        FontWeight.normal,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.height10 / 5,
                                                  ),
                                                  // Ben nhan va Uy thac
                                                  DisplayRowDataWidget(
                                                    firstField:
                                                        _ticketList[index]
                                                            .consigneeCode
                                                            .toString(),
                                                    firstColor: Colors.green,
                                                    firstSize:
                                                        Dimensions.fontSize10,
                                                    secondSize:
                                                        Dimensions.fontSize10,
                                                    secondField:
                                                        _ticketList[index]
                                                                .delegateCode ??
                                                            "",
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.height10 / 5,
                                                  ),
                                                  BigText(
                                                    text: _ticketList[index]
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
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          BigText(
                                                            text: _ticketList[
                                                                        index]
                                                                    .vehiclePrimaryCode ??
                                                                "",
                                                            size: Dimensions
                                                                .fontSize12,
                                                            color: AppColor
                                                                .mainColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          BigText(
                                                            text: _ticketList[
                                                                            index]
                                                                        .vehicleSecondaryCode
                                                                        .toString() ==
                                                                    "null"
                                                                ? ""
                                                                : "/ ${_ticketList[index].vehicleSecondaryCode ?? ""}",
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
                                                            text: _ticketList[
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
                                                    height:
                                                        Dimensions.height10 / 5,
                                                  ),
                                                  BigText(
                                                    text: _ticketList[index]
                                                        .serviceTypeName!,
                                                    size: Dimensions.fontSize10,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.height10 / 5,
                                                  ),
                                                  // chủ hàng ủy thác loại hàng billoflading
                                                  ManifestWidget(
                                                    billOfLading:
                                                        _ticketList[index]
                                                                .billOfLading ??
                                                            "",
                                                    consigneeCode: _ticketList[
                                                                index]
                                                            .manifestConsigneeCode ??
                                                        "",
                                                    cargoCode:
                                                        _ticketList[index]
                                                                .cargoCode ??
                                                            "",
                                                    delegrateCode:
                                                        _ticketList[index]
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
                                                text: "TL vào:",
                                                size: Dimensions.fontSize10,
                                                color: Colors.black,
                                              ),
                                              BigText(
                                                text:
                                                    "${f.format(int.parse(_ticketList[index].tareWeight.toString()))} (Kg) ",
                                                size: Dimensions.fontSize10,
                                                color: AppColor.mainColor,
                                              ),
                                              BigText(
                                                text:
                                                    " ${AppMessage.AT} ${formatDateTime(_ticketList[index].tareTime.toString())} ${AppMessage.FOR} ${_ticketList[index].tareAccountDisplayName}",
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
                                            margin:
                                                const EdgeInsets.only(top: 0),
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
                            )
                          ],
                        ),
                      ),
                    )
                  : const CustomLoader();
            }),
            // Cân chốt
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
                              height: Dimensions.height10 / 5,
                            ),
                            Container(
                              height: Dimensions.pageListView,
                              padding: EdgeInsets.only(
                                  top: Dimensions.height10 / 2,
                                  left: Dimensions.width10 / 2,
                                  right: Dimensions.width10 / 2,
                                  bottom: Dimensions.height10),
                              child: RefreshIndicator(
                                onRefresh: () {
                                  return Future.delayed(
                                    const Duration(seconds: 1),
                                    () {
                                      setState(() {
                                        deliveryDetailController
                                            .getPendingTicketList();
                                        _pendingTicketList =
                                            deliveryDetailController
                                                .pendingTicketList;
                                        _tempPendingTicketList =
                                            _pendingTicketList;
                                      });
                                    },
                                  );
                                },
                                child: ListView.builder(
                                  itemCount: _pendingTicketList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(RouteHelper
                                            .getSecondWeightDetailPage(index));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                        _pendingTicketList[
                                                                index]
                                                            .vesselCode
                                                            .toString(),
                                                    secondField:
                                                        _pendingTicketList[
                                                                    index]
                                                                .bargeCode ??
                                                            "",
                                                    firstColor:
                                                        AppColor.mainColor,
                                                    firstSize:
                                                        Dimensions.fontSize14,
                                                    secondSize:
                                                        Dimensions.fontSize12,
                                                    fontWeight2:
                                                        FontWeight.normal,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.height10 / 5,
                                                  ),
                                                  // Ben nhan va Uy thac
                                                  DisplayRowDataWidget(
                                                    firstField:
                                                        _pendingTicketList[
                                                                index]
                                                            .consigneeCode
                                                            .toString(),
                                                    firstColor: Colors.green,
                                                    firstSize:
                                                        Dimensions.fontSize10,
                                                    secondSize:
                                                        Dimensions.fontSize10,
                                                    secondField:
                                                        _pendingTicketList[
                                                                    index]
                                                                .delegateCode ??
                                                            "",
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.height10 / 5,
                                                  ),
                                                  BigText(
                                                    text: _pendingTicketList[
                                                                index]
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
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          BigText(
                                                            text: _pendingTicketList[
                                                                        index]
                                                                    .vehiclePrimaryCode ??
                                                                "",
                                                            size: Dimensions
                                                                .fontSize12,
                                                            color: AppColor
                                                                .mainColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          BigText(
                                                            text: _pendingTicketList[
                                                                            index]
                                                                        .vehicleSecondaryCode
                                                                        .toString() ==
                                                                    "null"
                                                                ? ""
                                                                : "/ ${_pendingTicketList[index].vehicleSecondaryCode ?? ""}",
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
                                                            text: _pendingTicketList[
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
                                                    height:
                                                        Dimensions.height10 / 5,
                                                  ),
                                                  BigText(
                                                    text: _pendingTicketList[
                                                            index]
                                                        .serviceTypeName!,
                                                    size: Dimensions.fontSize10,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.height10 / 5,
                                                  ),
                                                  // chủ hàng ủy thác loại hàng billoflading
                                                  ManifestWidget(
                                                    billOfLading:
                                                        _pendingTicketList[
                                                                    index]
                                                                .billOfLading ??
                                                            "",
                                                    consigneeCode:
                                                        _pendingTicketList[
                                                                    index]
                                                                .manifestConsigneeCode ??
                                                            "",
                                                    cargoCode:
                                                        _pendingTicketList[
                                                                    index]
                                                                .cargoCode ??
                                                            "",
                                                    delegrateCode:
                                                        _pendingTicketList[
                                                                    index]
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
                                                text: "TL vào:",
                                                size: Dimensions.fontSize10,
                                                color: Colors.black,
                                              ),
                                              BigText(
                                                text:
                                                    "${f.format(int.parse(_pendingTicketList[index].tareWeight.toString()))} (Kg) ",
                                                size: Dimensions.fontSize10,
                                                color: AppColor.mainColor,
                                              ),
                                              BigText(
                                                text:
                                                    " ${AppMessage.AT} ${formatDateTime(_pendingTicketList[index].tareTime.toString())} ${AppMessage.FOR} ${_pendingTicketList[index].tareAccountDisplayName}",
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
                                            margin:
                                                const EdgeInsets.only(top: 0),
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
                            )
                          ],
                        ),
                      ),
                    )
                  : const CustomLoader();
            }),
          ],
        ),
      ),
    );
  }
}
