import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:get/get.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/controller/auth_controller.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var userNameController = TextEditingController();

    void _forgotPassword(AuthController authController) {
      String userName = userNameController.text.trim();

      if (userName.isEmpty) {
        showCustomSnackBar(AppMessage.ERROR_MESSAGE6,
            title: AppMessage.USERNAME);
      } else {
        authController.forgot(userName).then((status) {
          if (status.isSuccess) {
          } else {
            showCustomSnackBar(status.message,
                title: AppMessage.FORGOT_PASSWORD);
          }
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.backgroundWhiteColor,
          elevation: 0,
          leading: BackButton(
            color: AppColor.mainColor,
            onPressed: () => Get.offNamed(RouteHelper.getLoginPage()),
          ),
        ),
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    height: Dimensions.pageLoginView,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.logoTop,
                                  left: Dimensions.logoLeft,
                                  right: Dimensions.logoRight),
                              color: Colors.white,
                              height: Dimensions.logoHeight,
                              child: const Image(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/logo.png"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        BigText(
                          text: AppMessage.FORGOT_PASSWORD,
                          size: Dimensions.fontSize20,
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: Column(children: [
                            TextFormField(
                              controller: userNameController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: Dimensions.width10,
                                    horizontal: Dimensions.width10),
                                hintText: AppMessage.USERNAME,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                ),
                              ),
                              style: TextStyle(fontSize: Dimensions.fontSize14),
                            ),
                          ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.height10,
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              child: SizedBox(
                                height: Dimensions.height20 * 2,
                                width: Dimensions.screenWidth -
                                    Dimensions.height20,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _forgotPassword(authController);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColor.mainColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15),
                                            side: BorderSide(
                                                color: AppColor.mainColor))),
                                  ),
                                  child: BigText(
                                    text: AppMessage.FORGOT_PASSWORD,
                                    color: Colors.white,
                                    size: Dimensions.fontSize16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : const CustomLoader();
        }));
  }
}
