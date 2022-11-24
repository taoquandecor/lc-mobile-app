import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<String?> getImgUrl(url) async {
    try {
      Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
          .buffer
          .asUint8List();
      return url;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            if (!authController.isLoading) {
              String file = AppContants.BASE_URL +
                  AppContants.SLASH +
                  authController.userModel.imagePath!;

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
                          size: Dimensions.fontSize16,
                        ),
                        BigText(
                          text: AppMessage.PROFILE,
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
                              text: AppMessage.LOG_OUT,
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
                                  Dimensions.radius80,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius80,
                                ),
                                child: Image.network(
                                  file,
                                  headers: AppContants.HEADER_IMAGE,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset("assets/images/user.png"),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
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
                                text:
                                    "${AppMessage.ORGANIZATION}: ${authController.userModel.organizationName ?? ""}",
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
                                text: AppMessage.ACCOUNT_INFORMATION,
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
                              child: const IconAndTextWidget(
                                text: AppMessage.CHANGE_PASSWORD,
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
                              child: const IconAndTextWidget(
                                text: AppMessage.LOG_OUT,
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
