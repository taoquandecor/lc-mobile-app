import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/controller/auth_controller.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/edit_box_widget.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var userNameController = TextEditingController();
    var passwordController = TextEditingController();

    void login(AuthController authController) {
      String userName = userNameController.text;
      String passWord = passwordController.text;

      // String userName = 'quan.tran';
      // String passWord = '123456a@';

      // String userName = 'hungdh';
      // String passWord = '123456';

      if (userName.isEmpty) {
        showCustomSnackBar("UserName is not empty", title: "UserName");
      } else if (passWord.isEmpty) {
        showCustomSnackBar("Password is not empty", title: "Password");
      } else {
        authController.login(userName, passWord).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitialPage());
          } else {
            showCustomSnackBar(status.message, title: "Login");
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20),
                    height: Dimensions.pageLoginView,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/en.png"),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              width: Dimensions.width20 * 12,
                              height: Dimensions.height45 * 1.5,
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
                          text: "Đăng nhập",
                          size: Dimensions.fontSize25,
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        EditBoxWidget(
                          hint: "Tài khoản",
                          controller: userNameController,
                        ),
                        EditBoxWidget(
                          hint: "Mật khẩu",
                          password: true,
                          controller: passwordController,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: Dimensions.height10,
                                  left: Dimensions.width20 / 5,
                                  right: Dimensions.width20 / 5),
                              margin: EdgeInsets.only(
                                  top: Dimensions.height10,
                                  left: Dimensions.width20 / 5,
                                  right: Dimensions.width20 / 5),
                              child: SizedBox(
                                height: Dimensions.height20 * 2,
                                width: Dimensions.screenWidth * 0.8,
                                child: ElevatedButton(
                                  onPressed: () {
                                    login(authController);
                                  },
                                  child: BigText(
                                    text: "Đăng nhập",
                                    color: Colors.white,
                                  ),
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
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: Dimensions.height10,
                        // ),
                        // BigText(
                        //   text: "Bạn quên mật khẩu?",
                        //   size: Dimensions.fontSize14,
                        //   color: Colors.black,
                        //   fontWeight: FontWeight.bold,
                        // )
                      ],
                    ),
                  ),
                )
              : const CustomLoader();
        }));
  }
}
