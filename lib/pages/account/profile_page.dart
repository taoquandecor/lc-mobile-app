import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/controller/auth_controller.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/icon_and_text_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? Stack(
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
                            GestureDetector(
                              onTap: (() {
                                if (authController.userLoggedIn()) {
                                  authController.clearSharedData();
                                  Get.offNamed(RouteHelper.getLoginPage());
                                }
                              }),
                              child: BigText(
                                  text: "Đăng xuất",
                                  color: Colors.white,
                                  size: Dimensions.fontSize16),
                            ),
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
                                  width: Dimensions.width20 * 7,
                                  height: Dimensions.height20 * 7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius80)),
                                  child: Image.network(
                                    AppContants.BASE_URL +
                                        AppContants.SLASH +
                                        authController.userModel.imagePath!,
                                    height: Dimensions.height20 * 7,
                                    headers: AppContants.HEADER_IMAGE,
                                    fit: BoxFit.cover,
                                    frameBuilder:
                                        (_, image, loadingBuilder, __) {
                                      if (loadingBuilder == null) {
                                        return const SizedBox(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }
                                      return image;
                                    },
                                    loadingBuilder: (BuildContext context,
                                        Widget image,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return image;
                                      return SizedBox(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (_, __, ___) => Image.asset(
                                      "assets/images/user.png",
                                      height: Dimensions.height20 * 7,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              BigText(
                                text: authController.userModel.displayName!,
                                size: Dimensions.fontSize25,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                    text: "Tổ chức: ",
                                    size: Dimensions.fontSize16,
                                  ),
                                  BigText(
                                    text: authController
                                        .userModel.organizationName!,
                                    size: Dimensions.fontSize16,
                                  ),
                                ],
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
                                  child: const IconAndTextWidget(
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
                                    Get.toNamed(
                                        RouteHelper.getChangePasswordPage());
                                  },
                                  child: const IconAndTextWidget(
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
                                GestureDetector(
                                  onTap: () {
                                    if (authController.userLoggedIn()) {
                                      authController.clearSharedData();
                                      Get.offNamed(RouteHelper.getLoginPage());
                                    }
                                  },
                                  child: IconAndTextWidget(
                                    text: "Đăng xuất",
                                    icon: Icons.logout,
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
                              ],
                            ),
                          ))
                    ],
                  )
                : const CustomLoader();
          },
        ));
  }
}
