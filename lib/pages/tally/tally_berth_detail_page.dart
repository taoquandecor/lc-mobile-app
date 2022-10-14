import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/app_icon.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/button_widget.dart';
import 'package:lcmobileapp/widgets/drop_down_widget.dart';
import 'package:lcmobileapp/widgets/edit_box_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';

class TallyBerthDetailPage extends StatelessWidget {
  const TallyBerthDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var remarkController = TextEditingController();
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
            text: "Tally cầu bến",
            color: AppColor.mainColor,
            size: Dimensions.fontSize25,
          ),
          backgroundColor: AppColor.backgroundWhiteColor,
          elevation: 5,
          bottom: TabBar(
            unselectedLabelColor: AppColor.backgroundColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: AppIcon(
                  icon: Icons.info_outline,
                  iconColor: AppColor.mainColor,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: "Chi tiết",
                    size: Dimensions.fontSize16,
                    color: AppColor.mainColor,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                  icon: Icons.phone_android,
                  iconSize: Dimensions.fontSize25,
                  iconColor: Colors.black.withOpacity(0.4),
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: BigText(
                      text: "Tally cầu bến",
                      size: Dimensions.fontSize16,
                      color: Colors.black.withOpacity(0.4),
                    )),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Container(
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
                      text: "Số phiếu",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "CB202210030001",
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
                      text: "Tàu - sà lan",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "NORD.POLLUX",
                          size: Dimensions.fontSize14,
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                        BigText(
                          text: "- HD0018",
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
                // Xe / mooc (lượt)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallText(
                      text: "Xe / mooc (lượt)",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "36C11765",
                          size: Dimensions.fontSize14,
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                        BigText(
                          text: " / 36R11765",
                          size: Dimensions.fontSize14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        SmallText(
                          text: " (0/1)",
                          size: Dimensions.fontSize14,
                        )
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
                      text: "Chủ hàng / Đại diện",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "NEWHOPEHN / VOSAQN",
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
                      text: "Bên nhận / Ủy thác",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "NEWHOPEHN",
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
                      text: "Loại hàng",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "Ngô / Corn Argentine",
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
                      text: "Vận đơn",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "NPJULAM06",
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
                      text: "Dịch vụ",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "Barge-Truck(Xếp dỡ Sà lan-Xe tải)",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallText(
                      text: "Hướng hàng",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "UNLOADING",
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
                //Điểm khai thác
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallText(
                      text: "Điểm khai thác",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "Cảng Lễ Môn - Thanh Hóa",
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
                      text: "Hàng còn lại",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "96,260 (Kg)",
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
                      text: "Cân bì",
                      size: Dimensions.fontSize16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BigText(
                          text: "14.010 (Kg) lúc 08:30 25/10",
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
                        text: "Cân bì",
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: "14.010 (Kg) lúc 16:34 25/09",
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
                        text: "Cân bởi",
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: "canlemon",
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
                        text: "Lưu ý",
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: "Xe có dấu hiệu làm bì",
                            size: Dimensions.fontSize16,
                            color: AppColor.mainColor,
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

                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        left: Dimensions.width10 / 5,
                        right: Dimensions.width10 / 5),
                    child: Column(
                      children: [
                        DropDownWidget(hint: "Chọn sà lan", value: "0"),
                        SizedBox(
                          height: Dimensions.height10 / 2,
                        ),
                        EditBoxWidget(
                          hint: "Ghi chú",
                          controller: remarkController,
                        ),
                        const ButtonWidget(
                          text: "Chấp nhận",
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
