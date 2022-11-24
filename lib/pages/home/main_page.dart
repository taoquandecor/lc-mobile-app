import 'package:flutter/material.dart';
import 'package:lcmobileapp/pages/operation/operation_by_shift.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/app_icon.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/edit_box_widget.dart';
import 'package:lcmobileapp/widgets/info_widget.dart';
import 'package:lcmobileapp/widgets/progress_widget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  String _selectedOperationValue = "";
  String _selectedVesselValue = "";
  String _selectedConsigneelValue = "";
  String _selectedCargoValue = "";
  var _fromDate = TextEditingController();
  var _toDate = TextEditingController();

  String formatDate(String date) {
    var outputDate = DateTime.now().toString();

    DateTime parseDate =
        DateFormat(AppContants.SQL_DATETIME_FORMAT).parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat(AppContants.DATE_FORMAT);
    outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  void _showModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.radius20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Container(
          height: Dimensions.pageBottomModel,
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width15, right: Dimensions.width15),
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.height45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          iconSize: Dimensions.iconSize24,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                  ),
                  // Điểm khai thác
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
                      value: _selectedOperationValue == ""
                          ? null
                          : _selectedOperationValue,
                      iconSize: Dimensions.height20 + Dimensions.height10,
                      isExpanded: true,
                      hint: const Text(AppMessage.SELECT_OPERATION_TERMINAL),
                      // items: _bargeVoyageList.map((item) {
                      //   return DropdownMenuItem<String>(
                      //     value: item.id.toString(),
                      //     child: Text(item.bargeCode.toString()),
                      //   );
                      // }).toList(),
                      items: [],
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOperationValue = value.toString();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 2,
                  ),
                  // Chọn tầu
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
                      value: _selectedVesselValue == ""
                          ? null
                          : _selectedVesselValue,
                      iconSize: Dimensions.height20 + Dimensions.height10,
                      isExpanded: true,
                      hint: const Text(AppMessage.SELECT_VESSEL),
                      // items: _bargeVoyageList.map((item) {
                      //   return DropdownMenuItem<String>(
                      //     value: item.id.toString(),
                      //     child: Text(item.bargeCode.toString()),
                      //   );
                      // }).toList(),
                      items: [],
                      onChanged: (String? value) {
                        setState(() {
                          _selectedVesselValue = value.toString();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 2,
                  ),
                  // Chọn chủ hàng
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
                      value: _selectedConsigneelValue == ""
                          ? null
                          : _selectedConsigneelValue,
                      iconSize: Dimensions.height20 + Dimensions.height10,
                      isExpanded: true,
                      hint: const Text(AppMessage.SELECT_CONSIGNEE),
                      // items: _bargeVoyageList.map((item) {
                      //   return DropdownMenuItem<String>(
                      //     value: item.id.toString(),
                      //     child: Text(item.bargeCode.toString()),
                      //   );
                      // }).toList(),
                      items: [],
                      onChanged: (String? value) {
                        setState(() {
                          _selectedConsigneelValue = value.toString();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 2,
                  ),
                  // Chọn loại hàng
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
                      value: _selectedCargoValue == ""
                          ? null
                          : _selectedCargoValue,
                      iconSize: Dimensions.height20 + Dimensions.height10,
                      isExpanded: true,
                      hint: const Text(AppMessage.SELECT_CARGO),
                      // items: _bargeVoyageList.map((item) {
                      //   return DropdownMenuItem<String>(
                      //     value: item.id.toString(),
                      //     child: Text(item.bargeCode.toString()),
                      //   );
                      // }).toList(),
                      items: [],
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCargoValue = value.toString();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 2,
                  ),
                  // từ ngày đến ngày
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 180,
                        child: TextFormField(
                          controller: _fromDate,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2018, 3, 5),
                                    maxTime: DateTime(2030, 6, 7),
                                    onChanged: (date) {
                                  setState(() {
                                    _fromDate.text =
                                        formatDate(date.toString());
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi);
                              },
                              icon: const Icon(Icons.calendar_month),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: Dimensions.width10,
                                horizontal: Dimensions.width10),
                            hintText: "Từ ngày",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: TextFormField(
                          controller: _toDate,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2018, 3, 5),
                                    maxTime: DateTime(2030, 6, 7),
                                    onChanged: (date) {
                                  setState(() {
                                    _toDate.text = formatDate(date.toString());
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi);
                              },
                              icon: const Icon(Icons.calendar_month),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: Dimensions.width10,
                                horizontal: Dimensions.width10),
                            hintText: "Đến ngày",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 2,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.mainColor),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                side: BorderSide(color: AppColor.mainColor))),
                      ),
                      child: BigText(
                        text: AppMessage.SEARCH,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.backgroundWhiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.backgroundWhiteColor,
          toolbarHeight: Dimensions.height10 / 2,
          elevation: 0,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            unselectedLabelColor: AppColor.backgroundColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: AppIcon(
                  icon: Icons.people_sharp,
                  iconColor:
                      _currentIndex == 0 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.iconSize24,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: AppMessage.CONSIGNEE,
                    size: Dimensions.fontSize16,
                    color:
                        _currentIndex == 0 ? AppColor.mainColor : Colors.grey,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                  icon: Icons.directions_boat_outlined,
                  iconColor:
                      _currentIndex == 1 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.iconSize24,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: BigText(
                      text: AppMessage.BARGE,
                      size: Dimensions.fontSize16,
                      color:
                          _currentIndex == 1 ? AppColor.mainColor : Colors.grey,
                    )),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(Dimensions.width10 / 2.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppIcon(
                          icon: Icons.directions_boat_rounded,
                          iconSize: Dimensions.iconSize16,
                          backgroundColor: AppColor.backgroundWhiteColor,
                        ),
                        BigText(
                          text: "NORD.POLLUX",
                          size: Dimensions.fontSize12,
                        ),
                        AppIcon(
                          icon: Icons.location_on,
                          iconSize: Dimensions.iconSize16,
                          backgroundColor: AppColor.backgroundWhiteColor,
                        ),
                        BigText(
                          text: "Cảng Trường An-Hải Dương",
                          size: Dimensions.fontSize12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showModalBottomSheet(context);
                          },
                          child: AppIcon(
                            icon: Icons.filter_alt_sharp,
                            iconSize: Dimensions.iconSize16,
                            backgroundColor: AppColor.backgroundWhiteColor,
                            iconColor: AppColor.mainColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Dimensions.height10 / 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppIcon(
                          icon: Icons.calendar_month_sharp,
                          iconSize: Dimensions.iconSize16,
                          backgroundColor: AppColor.backgroundWhiteColor,
                        ),
                        BigText(
                          text: "06:00 22/09 - 18:00 25/09",
                          size: Dimensions.fontSize12,
                        ),
                      ],
                    ),
                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height10 / 2,
                          left: Dimensions.width10,
                          right: Dimensions.width10,
                          bottom: Dimensions.height10 / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const InfoWiget(
                              text: "KẾ HOẠCH",
                              color: Colors.green,
                              quantity: "15,220.93 (tấn)"),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          const InfoWiget(
                              text: "ĐÃ DỠ",
                              color: Colors.blue,
                              quantity: "15,220.93 (tấn)"),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          const InfoWiget(
                              text: "CÒN LẠI",
                              color: Colors.orange,
                              quantity: "15,220.93 (tấn)")
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        AppIcon(
                          icon: Icons.calendar_month_sharp,
                          iconSize: Dimensions.iconSize16,
                          backgroundColor: AppColor.backgroundWhiteColor,
                          iconColor: AppColor.mainColor,
                        ),
                        BigText(
                          text: "Kế hoạch",
                          size: Dimensions.fontSize14,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10 / 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width10 / 2,
                          right: Dimensions.width10 / 2),
                      margin: EdgeInsets.only(
                          left: Dimensions.width10 / 2,
                          right: Dimensions.width10 / 2),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: ((context, index) {
                          return const ProgressWidget(
                            progress: 1900,
                            limit: 4290,
                            text: "JAPFACOMFEED - Khô đậu/ SBM Argentine",
                          );
                        }),
                      ),
                    ),
                    Row(
                      children: [
                        AppIcon(
                          icon: Icons.bar_chart_outlined,
                          iconSize: Dimensions.iconSize16,
                          backgroundColor: AppColor.backgroundWhiteColor,
                          iconColor: AppColor.mainColor,
                        ),
                        BigText(
                          text: "Năng suất theo ca",
                          size: Dimensions.fontSize14,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    const OperationByShift(),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(Dimensions.width10 / 2.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppIcon(
                          icon: Icons.directions_boat_rounded,
                          iconSize: Dimensions.iconSize16,
                          backgroundColor: AppColor.backgroundColor,
                        ),
                        BigText(
                          text: "NORD.POLLUX",
                          size: Dimensions.fontSize12,
                        ),
                        AppIcon(
                          icon: Icons.location_on,
                          iconSize: Dimensions.iconSize16,
                          backgroundColor: AppColor.backgroundColor,
                        ),
                        BigText(
                          text: "Cảng Trường An-Hải Dương",
                          size: Dimensions.fontSize12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showModalBottomSheet(context);
                          },
                          child: AppIcon(
                            icon: Icons.filter_alt_sharp,
                            iconSize: Dimensions.iconSize16,
                            backgroundColor: AppColor.backgroundColor,
                            iconColor: AppColor.mainColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppIcon(
                          icon: Icons.calendar_month_sharp,
                          iconSize: Dimensions.iconSize16,
                          backgroundColor: AppColor.backgroundColor,
                        ),
                        BigText(
                          text: "06:00 22/09 - 18:00 25/09",
                          size: Dimensions.fontSize12,
                        ),
                      ],
                    ),
                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: const EdgeInsets.only(top: 0),
                      color: AppColor.lineColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10 / 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width10, right: Dimensions.width10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const InfoWiget(
                              text: "KẾ HOẠCH",
                              color: Colors.green,
                              quantity: "15,220.93 (tấn)"),
                          SizedBox(
                            height: Dimensions.width10 / 2,
                          ),
                          const InfoWiget(
                              text: "ĐÃ DỠ",
                              color: Colors.blue,
                              quantity: "15,220.93 (tấn)"),
                          SizedBox(
                            height: Dimensions.width10 / 2,
                          ),
                          const InfoWiget(
                              text: "CÒN LẠI",
                              color: Colors.orange,
                              quantity: "15,220.93 (tấn)")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10 / 2,
                    ),
                    Row(
                      children: [
                        AppIcon(
                          icon: Icons.calendar_month_sharp,
                          iconSize: Dimensions.iconSize16,
                          backgroundColor: AppColor.backgroundColor,
                          iconColor: AppColor.mainColor,
                        ),
                        BigText(
                          text: "Kế hoạch",
                          size: Dimensions.fontSize14,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10 / 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width10 / 2,
                          right: Dimensions.width10 / 2),
                      margin: EdgeInsets.only(
                          left: Dimensions.width10 / 2,
                          right: Dimensions.width10 / 2),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: ((context, index) {
                          return const ProgressWidget(
                            progress: 1900,
                            limit: 4290,
                            text: "JAPFACOMFEED - Khô đậu/ SBM Argentine",
                          );
                        }),
                      ),
                    ),
                    Row(
                      children: [
                        AppIcon(
                          icon: Icons.bar_chart_outlined,
                          iconSize: Dimensions.iconSize16,
                          backgroundColor: AppColor.backgroundColor,
                          iconColor: AppColor.mainColor,
                        ),
                        BigText(
                          text: "Năng suất theo ca",
                          size: Dimensions.fontSize14,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    const OperationByShift(),
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
