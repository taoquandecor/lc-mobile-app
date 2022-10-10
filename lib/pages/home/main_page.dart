import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/app_icon.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/dropdown_widget.dart';
import 'package:lcmobileapp/widgets/info_widget.dart';
import 'package:lcmobileapp/widgets/progress_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          toolbarHeight: Dimensions.height10,
          elevation: 0,
          bottom: TabBar(
            unselectedLabelColor: AppColor.backgroundColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: AppIcon(
                  icon: Icons.people_sharp,
                  iconColor: AppColor.mainColor,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: "Chủ hàng",
                    size: Dimensions.fontSize16,
                    color: AppColor.mainColor,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                  icon: Icons.directions_boat_outlined,
                  iconColor: AppColor.mainColor,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundColor,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: BigText(
                      text: "Sà lan",
                      size: Dimensions.fontSize16,
                      color: AppColor.mainColor,
                    )),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              height: Dimensions.height10,
              margin: EdgeInsets.only(
                  top: Dimensions.height10 / 2,
                  bottom: Dimensions.height10 / 2),
              padding: EdgeInsets.only(
                  top: Dimensions.height10 / 2,
                  left: Dimensions.width10 / 2,
                  right: Dimensions.width10 / 2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        size: Dimensions.fontSize14,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: Dimensions.height20,
                                          left: Dimensions.width10 / 4,
                                          right: Dimensions.width10 / 4),
                                      margin: EdgeInsets.only(
                                          top: Dimensions.height20,
                                          left: Dimensions.width10 / 4,
                                          right: Dimensions.width10 / 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              DropDownWidget(
                                                hint: "Điểm khai thác",
                                                value: "item3",
                                                dropdownItems: [
                                                  "item1",
                                                  "item2",
                                                  "item3"
                                                ],
                                              ),
                                              SizedBox(
                                                height: Dimensions.height20,
                                              ),
                                              DropDownWidget(
                                                hint: "Chọn tầu",
                                                value: "item3",
                                                dropdownItems: [
                                                  "item1",
                                                  "item2",
                                                  "item3"
                                                ],
                                              ),
                                              SizedBox(
                                                height: Dimensions.height20,
                                              ),
                                              DropDownWidget(
                                                hint: "Chủ hàng",
                                                value: "item3",
                                                dropdownItems: [
                                                  "item1",
                                                  "item2",
                                                  "item3"
                                                ],
                                              ),
                                              SizedBox(
                                                height: Dimensions.height20,
                                              ),
                                              DropDownWidget(
                                                hint: "Loại hàng",
                                                value: "item3",
                                                dropdownItems: [
                                                  "item1",
                                                  "item2",
                                                  "item3"
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: const Text('Tìm kiếm'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
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
                    children: [
                      AppIcon(
                        icon: Icons.calendar_month_sharp,
                        iconSize: Dimensions.iconSize16,
                        backgroundColor: AppColor.backgroundColor,
                      ),
                      BigText(
                        text: "06:00 22/09 - 18:00 25/09",
                        size: Dimensions.fontSize14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 2,
                  ),
                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: EdgeInsets.only(top: 0),
                    color: Color(0xFFFccc7c5),
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoWiget(
                          text: "KẾ HOẠCH",
                          color: Colors.green,
                          quantity: "15,220.93 (tấn)"),
                      InfoWiget(
                          text: "ĐÃ DỠ",
                          color: Colors.blue,
                          quantity: "15,220.93 (tấn)"),
                      InfoWiget(
                          text: "CÒN LẠI",
                          color: Colors.orange,
                          quantity: "15,220.93 (tấn)")
                    ],
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
                        size: Dimensions.fontSize16,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 2,
                  ),
                  Container(
                    height: Dimensions.height50 * 2,
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
                        size: Dimensions.fontSize16,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  Container(
                    height: Dimensions.height50 * 3,
                    padding: EdgeInsets.only(
                        top: Dimensions.height10 / 2,
                        left: Dimensions.width10 / 2,
                        right: Dimensions.width10 / 2,
                        bottom: Dimensions.height10),
                    margin: EdgeInsets.only(
                        top: Dimensions.height10 / 2,
                        left: Dimensions.width10 / 2,
                        right: Dimensions.width10 / 2,
                        bottom: Dimensions.height10),
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        BigText(
                                          text: "22/09",
                                          size: Dimensions.fontSize16,
                                          color: AppColor.mainColor,
                                        ),
                                        SizedBox(
                                          width: Dimensions.width10 / 2,
                                        ),
                                        SmallText(text: "06:00-18:00"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    BigText(
                                      text: "Sà lan - Xe tải",
                                      size: Dimensions.fontSize14,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    BigText(
                                      text: "Số chuyến",
                                      size: Dimensions.fontSize14,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    BigText(
                                      text: "Ngô / Corn Argentine",
                                      size: Dimensions.fontSize14,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    BigText(
                                      text: "1,006.55 (tons)",
                                      size: Dimensions.fontSize14,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    BigText(
                                      text: "33 (Chuyến)",
                                      size: Dimensions.fontSize14,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: Dimensions.screenWidth -
                                      Dimensions.width15 * 2,
                                  height: 1.2,
                                  margin: EdgeInsets.only(top: 0),
                                  color: Color(0xFFFccc7c5),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimensions.height10,
              margin: EdgeInsets.only(
                  top: Dimensions.height10 / 2,
                  bottom: Dimensions.height10 / 2),
              padding: EdgeInsets.only(
                  top: Dimensions.height10 / 2,
                  left: Dimensions.width10 / 2,
                  right: Dimensions.width10 / 2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        size: Dimensions.fontSize14,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: Dimensions.height20 * 15,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text('Modal BottomSheet Chủ hàng'),
                                      ElevatedButton(
                                        child: const Text('Tìm kiếm'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
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
                    children: [
                      AppIcon(
                        icon: Icons.calendar_month_sharp,
                        iconSize: Dimensions.iconSize16,
                        backgroundColor: AppColor.backgroundColor,
                      ),
                      BigText(
                        text: "06:00 22/09 - 18:00 25/09",
                        size: Dimensions.fontSize14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 2,
                  ),
                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: EdgeInsets.only(top: 0),
                    color: Color(0xFFFccc7c5),
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoWiget(
                          text: "KẾ HOẠCH",
                          color: Colors.green,
                          quantity: "15,220.93 (tấn)"),
                      InfoWiget(
                          text: "ĐÃ DỠ",
                          color: Colors.blue,
                          quantity: "15,220.93 (tấn)"),
                      InfoWiget(
                          text: "CÒN LẠI",
                          color: Colors.orange,
                          quantity: "15,220.93 (tấn)")
                    ],
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
                        size: Dimensions.fontSize16,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 2,
                  ),
                  Container(
                    height: Dimensions.height50 * 2,
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
                        size: Dimensions.fontSize16,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  Container(
                    height: Dimensions.height50 * 3,
                    padding: EdgeInsets.only(
                        top: Dimensions.height10 / 2,
                        left: Dimensions.width10 / 2,
                        right: Dimensions.width10 / 2,
                        bottom: Dimensions.height10),
                    margin: EdgeInsets.only(
                        top: Dimensions.height10 / 2,
                        left: Dimensions.width10 / 2,
                        right: Dimensions.width10 / 2,
                        bottom: Dimensions.height10),
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        BigText(
                                          text: "22/09",
                                          size: Dimensions.fontSize16,
                                          color: AppColor.mainColor,
                                        ),
                                        SizedBox(
                                          width: Dimensions.width10 / 2,
                                        ),
                                        SmallText(text: "06:00-18:00"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    BigText(
                                      text: "Sà lan - Xe tải",
                                      size: Dimensions.fontSize14,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    BigText(
                                      text: "Số chuyến",
                                      size: Dimensions.fontSize14,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    BigText(
                                      text: "Ngô / Corn Argentine",
                                      size: Dimensions.fontSize14,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    BigText(
                                      text: "1,006.55 (tons)",
                                      size: Dimensions.fontSize14,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    BigText(
                                      text: "33 (Chuyến)",
                                      size: Dimensions.fontSize14,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: Dimensions.screenWidth -
                                      Dimensions.width15 * 2,
                                  height: 1.2,
                                  margin: EdgeInsets.only(top: 0),
                                  color: Color(0xFFFccc7c5),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
