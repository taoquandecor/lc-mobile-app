import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/controller/dashboard_controller.dart';
import 'package:lcmobileapp/controller/delivery_detail_controller.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/models/filter_date_model.dart';
import 'package:lcmobileapp/models/statistic_model.dart';
import 'package:lcmobileapp/models/token_timeout_model.dart';
import 'package:lcmobileapp/models/vessel_voyage_model.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:lcmobileapp/widgets/small_text.dart';

class MainPage2 extends StatefulWidget {
  const MainPage2({super.key});

  @override
  State<MainPage2> createState() => _MainPage2State();
}

class _MainPage2State extends State<MainPage2> {
  String _selectedVoyageValue = "";
  String _selectedFilterDateValue = "Today";
  String _fromdate = "";
  String _toDate = "";

  //var _searchDate = TextEditingController();

  late TokenTimeOut _tokenTimeOut;
  List<VesselVoyageModel> _vesselVoyageList = [];
  List<StatisticModel> _statisticDataList = [];

  List<FilterDateModel> _filterDateList = [];

  var formatInteger = NumberFormat(AppContants.FORMAT_NUMER);
  var formatDecimal = NumberFormat(AppContants.FORMAT_DECIMAL);

  String formatDate(String date, String sqlFormat, String outFormat) {
    var outputDate = DateTime.now().toString();

    DateTime parseDate = DateFormat(sqlFormat).parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat(outFormat);
    outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  void getDateRange(String code) {
    FilterDateModel _filterDateModel =
        _filterDateList.where((element) => element.code == code).first;
    _fromdate = formatDate(_filterDateModel.fromDate.toString(),
        AppContants.SQL_DATETIME_FORMAT, AppContants.SQL_DATETIME_FORMAT);
    _toDate = formatDate(_filterDateModel.toDate.toString(),
        AppContants.SQL_DATETIME_FORMAT, AppContants.SQL_DATETIME_FORMAT);
  }

  Future<void> _loadResources() async {
    await Get.find<DashboardController>().getVesselVoyages();
    _vesselVoyageList = Get.find<DashboardController>().vessleVoyageList;
    _tokenTimeOut = Get.find<DeliveryDetailController>().tokenTimeOut;

    if (_tokenTimeOut.isTimeOut) {
      Get.find<UserController>().clearSharedData();
      Get.offNamed(RouteHelper.getLoginPage());
      Get.snackbar("Token", AppMessage.ERROR_MESSAGE5);
    }

    await Get.find<DashboardController>().getFilterDate();
    _filterDateList = Get.find<DashboardController>().filterDateList;

    if (_vesselVoyageList.isNotEmpty && _filterDateList.isNotEmpty) {
      _selectedVoyageValue = _vesselVoyageList[0].vesselVoyageId.toString();
      getDateRange(_selectedFilterDateValue);
      await Get.find<DashboardController>()
          .getStatisticData(_selectedVoyageValue, _fromdate, _toDate);
      _statisticDataList = Get.find<DashboardController>().statisticDataList;
    }
  }

  Future<void> _reloadResource(DashboardController dashboardController,
      String voyage, String fromDate, String toDate) async {
    await dashboardController.getStatisticData(
        _selectedVoyageValue, _fromdate, _toDate);
    setState(() {
      _statisticDataList = dashboardController.statisticDataList;
    });
  }

  @override
  void initState() {
    _selectedFilterDateValue = "Today";

    super.initState();
    _loadResources();
  }

  @override
  void dispose() {
    _selectedVoyageValue = "";
    //_searchDate.text = "";
    _selectedFilterDateValue = "Today";
    super.dispose();
    _vesselVoyageList = [];
    _statisticDataList = [];
    _filterDateList = [];
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
          text: "DASHBOARD",
          size: Dimensions.fontSize14,
          color: AppColor.mainColor,
        ),
      ),
      body: Column(
        children: [
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(left: Dimensions.width10),
              height: Dimensions.height50,
              child: GetBuilder<DashboardController>(
                builder: (dashboardController) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: Dimensions.height45,
                        width: Dimensions.screenWidth / 2 - Dimensions.width10,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: Dimensions.width10,
                                horizontal: Dimensions.width10),
                          ),
                          value: _selectedVoyageValue == ""
                              ? null
                              : _selectedVoyageValue,
                          iconSize: Dimensions.iconSize24,
                          isExpanded: true,
                          hint: Text(
                            AppMessage.SELECT_VESSEL,
                            style: TextStyle(fontSize: Dimensions.fontSize12),
                          ),
                          items:
                              dashboardController.vessleVoyageList.map((item) {
                            return DropdownMenuItem<String>(
                              value: item.vesselVoyageId.toString(),
                              child: Text(item.vesselCode.toString(),
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSize12)),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedVoyageValue = value.toString();
                            });
                            getDateRange(_selectedFilterDateValue);
                            _reloadResource(dashboardController,
                                _selectedVoyageValue, _fromdate, _toDate);
                          },
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      SizedBox(
                        height: Dimensions.height45,
                        width: Dimensions.screenWidth / 2 - Dimensions.width10,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: Dimensions.width10,
                                horizontal: Dimensions.width10),
                          ),
                          value: _selectedFilterDateValue.toString(),
                          iconSize: Dimensions.iconSize24,
                          isExpanded: true,
                          hint: Text(AppMessage.CHOOSE_DATE,
                              style:
                                  TextStyle(fontSize: Dimensions.fontSize12)),
                          items: dashboardController.filterDateList.map((item) {
                            return DropdownMenuItem<String>(
                              value: item.code.toString(),
                              child: Text(
                                item.name.toString(),
                                style: TextStyle(
                                  fontSize: Dimensions.fontSize12,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedFilterDateValue = value.toString();
                            });
                            getDateRange(_selectedFilterDateValue);
                            _reloadResource(dashboardController,
                                _selectedVoyageValue, _fromdate, _toDate);
                          },
                        ),
                      ),
                    ],
                  );
                },
              )),
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: GetBuilder<DashboardController>(
                builder: (dashboardController) {
                  return dashboardController.isLoaded
                      ? Container(
                          color: AppColor.backgroundWhiteColor,
                          margin: EdgeInsets.only(
                              top: Dimensions.height10 / 5,
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: Column(
                            children: [
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
                                      () async {
                                        getDateRange(_selectedFilterDateValue);
                                        await dashboardController
                                            .getStatisticData(
                                                _selectedVoyageValue,
                                                _fromdate,
                                                _toDate);
                                        setState(() {
                                          _statisticDataList =
                                              dashboardController
                                                  .statisticDataList;
                                        });
                                      },
                                    );
                                  },
                                  child: ListView.builder(
                                    itemCount: _statisticDataList.length,
                                    itemBuilder: (context, index) {
                                      var item = _statisticDataList[index];
                                      var splittedShift =
                                          item.shift.toString().split('-');
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                            RouteHelper.getDeliveryDetailPage(
                                                _selectedVoyageValue,
                                                "${item.operationDate} ${splittedShift[0]}:00",
                                                "${item.operationDate} ${splittedShift[1]}:00"),
                                          );
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
                                                    // Ngày ca làm việc
                                                    Row(
                                                      children: [
                                                        BigText(
                                                          text: formatDate(
                                                              item.operationDate
                                                                  .toString(),
                                                              AppContants
                                                                  .SQL_DATE_FORMAT,
                                                              AppContants
                                                                  .SHORT_DATE_FORMAT),
                                                          size: Dimensions
                                                              .fontSize14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColor
                                                              .mainColor,
                                                        ),
                                                        SmallText(
                                                          text:
                                                              " (${item.shift.toString()})",
                                                          size: Dimensions
                                                              .fontSize10,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10 /
                                                              5,
                                                    ),
                                                    BigText(
                                                      text:
                                                          item.serviceTypeName ??
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

                                                    BigText(
                                                      text: AppMessage
                                                          .NUM_OF_TURN,
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
                                                    BigText(
                                                      text:
                                                          item.cargoName ?? "",
                                                      size:
                                                          Dimensions.fontSize10,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10 /
                                                              5,
                                                    ),
                                                    BigText(
                                                      text:
                                                          "${formatDecimal.format(double.parse(item.operationVolumne ?? "0.00"))} (${AppMessage.TONS})",
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
                                                    BigText(
                                                      text:
                                                          "${item.numOfTurn ?? "0"} (${AppMessage.TURN})",
                                                      size:
                                                          Dimensions.fontSize10,
                                                      color: Colors.black,
                                                    ),
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
                        )
                      : const CustomLoader();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
