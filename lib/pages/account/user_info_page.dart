import 'package:flutter/material.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:get/get.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width10,
            right: Dimensions.width10,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: BigText(
                    text: "Back",
                    size: Dimensions.fontSize16,
                    color: AppColor.mainColor,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20 * 2.5,
                ),
                BigText(
                  text: "Thông tin người dùng",
                  size: Dimensions.fontSize25,
                  color: AppColor.mainColor,
                )
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height50 * 2.5,
            left: Dimensions.height10,
            right: Dimensions.height10,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(
                    text: "Tên đăng nhập",
                    size: Dimensions.fontSize14,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  TextFormField(
                    initialValue: "quan.tran",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SmallText(
                    text: "Nhóm quyền",
                    size: Dimensions.fontSize14,
                  ),
                  TextFormField(
                    initialValue: "Supper Admin",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SmallText(
                    text: "Email",
                    size: Dimensions.fontSize14,
                  ),
                  TextFormField(
                    initialValue: "quan.tran@cict.com.vn",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SmallText(
                    text: "Tên đầy đủ",
                    size: Dimensions.fontSize14,
                  ),
                  TextFormField(
                    initialValue: "Trần Hồng Quân",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SmallText(
                    text: "Số điện thoại",
                    size: Dimensions.fontSize14,
                  ),
                  TextFormField(
                    initialValue: "0372776820",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SizedBox(
                    height: Dimensions.height20 * 3,
                    width: Dimensions.screenWidth,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: BigText(
                        text: "Cập nhật",
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
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
