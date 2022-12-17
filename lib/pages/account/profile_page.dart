import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/controller/auth_controller.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:lcmobileapp/utils/app_message.dart';
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
            Widget showImage() {
              try {
                HttpOverrides.global = MyHttpOverrides();
                String imagePath = authController.userModel.imagePath ?? "";
                if (imagePath.isEmpty) {
                  return Image.asset(
                    "assets/images/user.png",
                    height: Dimensions.avartaHeight,
                    width: Dimensions.avartaWidth,
                  );
                }
                String imageURL =
                    AppContants.BASE_URL + AppContants.SLASH + imagePath;
                return Image.network(
                  imageURL,
                  height: Dimensions.avartaHeight,
                  width: Dimensions.avartaWidth,
                  headers: AppContants.HEADER_IMAGE,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/images/user.png",
                    height: Dimensions.avartaHeight,
                    width: Dimensions.avartaWidth,
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return Image.asset(
                        "assets/images/user.png",
                        height: Dimensions.avartaHeight,
                        width: Dimensions.avartaWidth,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              } catch (e) {
                return Image.asset(
                  "assets/images/user.png",
                  height: Dimensions.avartaHeight,
                  width: Dimensions.avartaWidth,
                );
              }
            }

            if (!authController.isLoading) {
              return Stack(
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
                          text: AppMessage.SETTING,
                          color: Colors.white,
                          size: Dimensions.fontSize14,
                        ),
                        BigText(
                          text: AppMessage.PROFILE,
                          color: Colors.white,
                          size: Dimensions.fontSize20,
                        ),
                        GestureDetector(
                          onTap: (() {
                            if (authController.userLoggedIn()) {
                              authController.clearSharedData();
                              Get.offNamed(RouteHelper.getLoginPage());
                            }
                          }),
                          child: BigText(
                            text: AppMessage.LOG_OUT,
                            color: Colors.white,
                            size: Dimensions.fontSize14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: Dimensions.height50 * 2.5,
                    left: Dimensions.width20 * 5,
                    right: Dimensions.width20 * 5,
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[showImage()],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            BigText(
                              text: authController.userModel.displayName ?? "",
                              size: Dimensions.fontSize14,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(
                                    text:
                                        "${AppMessage.ORGANIZATION}: ${authController.userModel.organizationName ?? ""}",
                                    size: Dimensions.fontSize12),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                                text: AppMessage.ACCOUNT_INFORMATION,
                                icon: Icons.person,
                                iconColor: Colors.orange,
                                size: Dimensions.fontSize14,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Container(
                              width:
                                  Dimensions.screenWidth - Dimensions.height10,
                              height: 1.2,
                              margin:
                                  EdgeInsets.only(top: Dimensions.height20 / 5),
                              color: AppColor.lineColor,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                    RouteHelper.getChangePasswordPage());
                              },
                              child: IconAndTextWidget(
                                text: AppMessage.CHANGE_PASSWORD,
                                icon: Icons.key,
                                iconColor: Colors.orange,
                                size: Dimensions.fontSize14,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Container(
                              width:
                                  Dimensions.screenWidth - Dimensions.height10,
                              height: 1.2,
                              margin:
                                  EdgeInsets.only(top: Dimensions.height20 / 5),
                              color: AppColor.lineColor,
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
                                text: AppMessage.LOG_OUT,
                                icon: Icons.logout,
                                iconColor: Colors.orange,
                                size: Dimensions.fontSize14,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Container(
                              width:
                                  Dimensions.screenWidth - Dimensions.height10,
                              height: 1.2,
                              margin:
                                  EdgeInsets.only(top: Dimensions.height20 / 5),
                              color: AppColor.lineColor,
                            ),
                          ],
                        ),
                      ))
                ],
              );
            } else {
              return const CustomLoader();
            }
          },
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
