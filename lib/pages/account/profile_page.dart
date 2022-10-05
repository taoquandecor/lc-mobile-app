import 'package:flutter/material.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/icon_and_text_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // print("screen height is " + MediaQuery.of(context).size.height.toString());
    // print("screen width is " + MediaQuery.of(context).size.width.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background color
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: Dimensions.pageProfileView,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Colors.orangeAccent,
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.height10,
            right: Dimensions.height10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  text: "Thiết lập",
                  color: Colors.white,
                  size: Dimensions.fontSize16,
                ),
                BigText(
                  text: "Profile",
                  color: Colors.white,
                  size: Dimensions.fontSize25,
                ),
                BigText(
                    text: "Đăng xuất",
                    color: Colors.white,
                    size: Dimensions.fontSize16)
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height50 * 2,
            left: Dimensions.height50,
            right: Dimensions.height50,
            child: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  SizedBox(
                    height: Dimensions.height50,
                  ),
                  Center(
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius80),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/emp_0411.jpg"),
                        ),
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                    ),
                  ),
                  BigText(
                    text: "Trần Hồng Quân",
                    size: Dimensions.fontSize25,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  BigText(
                    text: "Tổ chức: CICT",
                    size: Dimensions.fontSize16,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                ],
              )),
            ),
          ),
          Positioned(
              top: Dimensions.pageListView,
              left: Dimensions.height10,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getUserInfoPage());
                      },
                      child: IconAndTextWidget(
                        text: "Thông tin tài khoản",
                        icon: Icons.person,
                        iconColor: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: EdgeInsets.only(top: 4),
                      color: Color(0xFFFccc7c5),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getChangePasswordPage());
                      },
                      child: IconAndTextWidget(
                        text: "Đổi mật khẩu",
                        icon: Icons.key,
                        iconColor: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: EdgeInsets.only(top: 4),
                      color: Color(0xFFFccc7c5),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    IconAndTextWidget(
                      text: "Đăng xuất",
                      icon: Icons.logout,
                      iconColor: Colors.orange,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: Dimensions.screenWidth,
                      height: 1.2,
                      margin: EdgeInsets.only(top: 4),
                      color: Color(0xFFFccc7c5),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
