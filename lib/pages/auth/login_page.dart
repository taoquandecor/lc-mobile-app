import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/controller/auth_controller.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.key),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  child: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: Dimensions.width10,
                                    horizontal: Dimensions.width10),
                                hintText: AppMessage.PASSWORD,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                ),
                              ),
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
                                    login(authController);
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
                                    text: "Đăng nhập",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getForgotPasswordPage());
                          },
                          child: BigText(
                            text: "Bạn quên mật khẩu?",
                            size: Dimensions.fontSize16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : const CustomLoader();
        }));
  }
}
