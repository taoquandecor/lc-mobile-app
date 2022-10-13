import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/small_text.dart';

class OperationByShift extends StatelessWidget {
  const OperationByShift({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height50 * 3,
      padding: EdgeInsets.only(
          top: Dimensions.height10 / 2,
          left: Dimensions.width10,
          right: Dimensions.width10,
          bottom: Dimensions.height10 / 2),
      child: ListView.builder(
        itemCount: 10,
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
                            size: Dimensions.fontSize14,
                            color: AppColor.mainColor,
                          ),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          SmallText(
                            text: "06:00-18:00",
                            size: Dimensions.fontSize10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10 / 2,
                      ),
                      BigText(
                        text: "Sà lan - Xe tải",
                        size: Dimensions.fontSize12,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: Dimensions.height10 / 2,
                      ),
                      BigText(
                        text: "Số chuyến",
                        size: Dimensions.fontSize12,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BigText(
                        text: "Ngô / Corn Argentine",
                        size: Dimensions.fontSize12,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: Dimensions.height10 / 2,
                      ),
                      BigText(
                        text: "1,006.55 (tons)",
                        size: Dimensions.fontSize12,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: Dimensions.height10 / 2,
                      ),
                      BigText(
                        text: "33 (Chuyến)",
                        size: Dimensions.fontSize12,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: Dimensions.screenWidth - Dimensions.width15 * 2,
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
    );
  }
}
