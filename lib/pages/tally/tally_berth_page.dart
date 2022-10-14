import 'package:flutter/material.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/edit_box_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:get/get.dart';

class TallyBerthPage extends StatelessWidget {
  const TallyBerthPage({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColor.backgroundWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundWhiteColor,
        centerTitle: true,
        title: BigText(
          text: "Tally cầu bến",
          color: AppColor.mainColor,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: Dimensions.height10 / 2,
          ),
          EditBoxWidget(
              hint: "Biển số xe, sà lan, chủ hàng",
              controller: searchController),
          SizedBox(
            height: Dimensions.height10,
          ),
          Container(
            height: Dimensions.pageListView,
            padding: EdgeInsets.only(
                top: Dimensions.height10,
                left: Dimensions.width10,
                right: Dimensions.width10,
                bottom: Dimensions.height10),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //print("on Tapped");
                    Get.toNamed(RouteHelper.getTallyBerthDetailPage());
                  },
                  child: Column(
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
                                    text: "NORD.POLLUX",
                                    size: Dimensions.fontSize14,
                                    color: AppColor.mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  BigText(
                                    text: "- HD0018",
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
                                    text: "NEWHOPEHN",
                                    size: Dimensions.fontSize12,
                                    color: Colors.green,
                                  ),
                                  BigText(
                                    text: "/ VOSAQN",
                                    size: Dimensions.fontSize12,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              BigText(
                                text: "NPJULAM06 - Ngô / Corn Argentine",
                                size: Dimensions.fontSize12,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  BigText(
                                    text: "36C11765",
                                    size: Dimensions.fontSize12,
                                    color: AppColor.mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  BigText(
                                    text: " / 36R11765",
                                    size: Dimensions.fontSize12,
                                    color: Colors.black,
                                  ),
                                  SmallText(
                                    text: " (0/1)",
                                    size: Dimensions.fontSize12,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              BigText(
                                text: "Barge-Truck(Xếp dỡ Sà lan-Xe tải)",
                                size: Dimensions.fontSize12,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              BigText(
                                text: "Cảng Lệ Môn - Thanh Hóa",
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
                            text: "Bì:",
                            size: Dimensions.fontSize12,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          BigText(
                            text: "14.010 (Kg)",
                            size: Dimensions.fontSize12,
                            color: AppColor.mainColor,
                          ),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          BigText(
                            text: "lúc 08:30 ngày 20/09/2022 bởi canglemon",
                            size: Dimensions.fontSize12,
                            color: Colors.black,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10 / 2,
                      ),
                      Row(
                        children: [
                          Container(
                            width:
                                Dimensions.screenWidth - Dimensions.width15 * 2,
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
          )
        ],
      ),
    );
  }
}
