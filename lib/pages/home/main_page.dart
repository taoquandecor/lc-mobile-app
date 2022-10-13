import 'package:flutter/material.dart';
import 'package:lcmobileapp/pages/operation/operation_by_shift.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/app_icon.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/drop_down_widget.dart';
import 'package:lcmobileapp/widgets/info_widget.dart';
import 'package:lcmobileapp/widgets/progress_widget.dart';

class MainPage extends StatelessWidget {
  _showModalBottomSheet(context) {
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
          height: 500,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width15, right: Dimensions.width15),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    const DropDownWidget(
                      hint: "Điểm khai thác",
                      value: "0",
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    const DropDownWidget(
                      hint: "Chọn tầu",
                      value: "0",
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    const DropDownWidget(
                      hint: "Chọn chủ hàng",
                      value: "0",
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    const DropDownWidget(
                      hint: "Chọn loại hàng",
                      value: "0",
                    ),
                    // SizedBox(
                    //   height: Dimensions.height10,
                    // ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     EditBoxIconWidget(
                    //         hint: "Từ ngày", icon: Icons.calendar_month),
                    //     EditBoxIconWidget(
                    //         hint: "Đến ngày", icon: Icons.calendar_month),
                    //   ],
                    // ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: BigText(
                        text: "Tìm kiếm",
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.mainColor),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                side: BorderSide(color: AppColor.mainColor))),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          toolbarHeight: Dimensions.height10 / 2,
          elevation: 0,
          bottom: TabBar(
            unselectedLabelColor: AppColor.backgroundColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: AppIcon(
                  icon: Icons.people_sharp,
                  iconColor: AppColor.mainColor,
                  iconSize: Dimensions.fontSize16,
                  backgroundColor: AppColor.backgroundColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: "Chủ hàng",
                    size: Dimensions.fontSize12,
                    color: AppColor.mainColor,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                  icon: Icons.directions_boat_outlined,
                  iconColor: AppColor.mainColor,
                  iconSize: Dimensions.fontSize16,
                  backgroundColor: AppColor.backgroundColor,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: BigText(
                      text: "Sà lan",
                      size: Dimensions.fontSize12,
                      color: AppColor.mainColor,
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
                    SizedBox(
                      width: Dimensions.height10 / 2,
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
