import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/app_icon.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/button_widget.dart';
import 'package:lcmobileapp/widgets/edit_box_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:timelines/timelines.dart';

class SecondWeightDetailPage extends StatelessWidget {
  const SecondWeightDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var weightController = TextEditingController();
    var remarkController = TextEditingController();

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: AppColor.mainColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: BigText(
            text: "Cân chốt",
            color: AppColor.mainColor,
            size: Dimensions.fontSize25,
          ),
          backgroundColor: AppColor.backgroundColor,
          elevation: 5,
          bottom: TabBar(
            unselectedLabelColor: AppColor.backgroundColor,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabs: [
              Tab(
                icon: AppIcon(
                  icon: Icons.info_outline,
                  iconColor: AppColor.mainColor,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: "Chi tiết",
                    size: Dimensions.fontSize14,
                    color: AppColor.mainColor,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                  icon: Icons.airplane_ticket,
                  iconColor: AppColor.mainColor,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: "Phiếu cân",
                    size: Dimensions.fontSize14,
                    color: AppColor.mainColor,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                  icon: Icons.scale_outlined,
                  iconColor: AppColor.mainColor,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: "Cân chốt",
                    size: Dimensions.fontSize14,
                    color: AppColor.mainColor,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                  icon: Icons.list_sharp,
                  iconColor: AppColor.mainColor,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: "Trình tự",
                    size: Dimensions.fontSize14,
                    color: AppColor.mainColor,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                  icon: Icons.history,
                  iconColor: AppColor.mainColor,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundColor,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: BigText(
                      text: "Lịch sử bì",
                      size: Dimensions.fontSize14,
                      color: AppColor.mainColor,
                    )),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width10,
                  right: Dimensions.width10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width10,
                  right: Dimensions.width10,
                  bottom: Dimensions.height10),
              height: Dimensions.height50,
              child: Column(
                children: const [
                  ButtonWidget(
                    text: "Thêm ảnh",
                    textColor: Colors.white,
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
                child: Column(children: [
                  Container(
                    height: Dimensions.height50 * 4.5,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius15 / 3),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/no_data.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
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
                            text: "14,010 (Kg)",
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
                  //Hàng
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: "Hàng",
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: "34,720 (Kg)",
                            size: Dimensions.fontSize16,
                            color: Colors.green,
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

                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10 / 5,
                        right: Dimensions.width10 / 5),
                    child: Column(
                      children: [
                        EditBoxWidget(
                          hint: "Nhập số cân",
                          controller: weightController,
                          textAlign: TextAlign.right,
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
                ]),
              ),
            ),
            Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    bottom: Dimensions.height10),
                child: Timeline.builder(
                  itemCount: 5,
                  itemBuilder: ((context, index) {
                    return TimelineTile(
                      oppositeContents: Padding(
                        padding: EdgeInsets.only(
                          left: Dimensions.width10,
                          right: Dimensions.width10,
                        ),
                        child: BigText(
                          text: '16:34 - 25/09',
                          size: Dimensions.fontSize14,
                        ),
                      ),
                      contents: Card(
                        child: Container(
                          padding: EdgeInsets.all(Dimensions.width10),
                          height: 100,
                          child: const Text(
                            'W.TARE - Tally cân bì 13,240 (Kg) - bởi canlemon Remark: Xe có dấu hiệu làm bì',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 20,
                          ),
                        ),
                      ),
                      node: TimelineNode(
                        indicator: DotIndicator(
                          color: AppColor.mainColor,
                        ),
                        startConnector: SolidLineConnector(
                          color: AppColor.lineColor,
                        ),
                        endConnector: SolidLineConnector(
                          color: AppColor.lineColor,
                        ),
                      ),
                    );
                  }),
                )),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width10,
                  right: Dimensions.width10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: Dimensions.height10 / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(Dimensions.width10 / 5),
                            width: 100.0,
                            child: BigText(
                              text: "Cân bì",
                              size: Dimensions.fontSize16,
                            )),
                        Container(
                            padding: EdgeInsets.all(Dimensions.width10 / 5),
                            width: 100.0,
                            child: BigText(
                              text: "Cả hàng",
                              size: Dimensions.fontSize16,
                            )),
                        Container(
                            padding: EdgeInsets.all(Dimensions.width10 / 5),
                            width: 100.0,
                            child: BigText(
                              text: "Thời gian",
                              size: Dimensions.fontSize16,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.all(Dimensions.width10 / 2),
                                    width: 100.0,
                                    child: SmallText(
                                      text: "13,990",
                                      size: Dimensions.fontSize16,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.all(Dimensions.width10 / 2),
                                    width: 100.0,
                                    child: SmallText(
                                      text: "34,100",
                                      size: Dimensions.fontSize16,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.all(Dimensions.width10 / 2),
                                    width: 100.0,
                                    child: SmallText(
                                      text: "25/09/2022",
                                      size: Dimensions.fontSize16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: Dimensions.screenWidth -
                                        Dimensions.width20 * 2,
                                    height: 1.2,
                                    margin: const EdgeInsets.only(top: 0),
                                    color: AppColor.lineColor,
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
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
