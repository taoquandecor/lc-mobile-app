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
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

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
    void login(AuthController authController) {
      String userName = userNameController.text;
      String passWord = passwordController.text;

      // String userName = 'quan.tran';
      // String passWord = '123456a@';

      if (userName.isEmpty) {
        showCustomSnackBar(AppMessage.ERROR_MESSAGE6,
            title: AppMessage.USERNAME);
      } else if (passWord.isEmpty) {
        showCustomSnackBar(AppMessage.ERROR_MESSAGE7,
            title: AppMessage.PASSWORD);
      } else {
        authController.login(userName, passWord).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitialPage());
          } else {
            showCustomSnackBar(status.message, title: AppMessage.LOGIN_TEXT);
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
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    height: Dimensions.pageLoginView,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  showCustomSnackBar(
                                      AppMessage.WARNING_MESSAGE1,
                                      title: AppMessage.LOGIN_TEXT);
                                },
                                child: const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/en.png"),
                                ))
                          ],
                        ),
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
                          text: AppMessage.LOGIN_TEXT,
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
                                  child: _passwordVisible
                                      ? const Icon(Icons.visibility,
                                          color: Colors.blue)
                                      : const Icon(
                                          Icons.visibility_off,
                                          color: Colors.red,
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
                              style: TextStyle(fontSize: Dimensions.fontSize14),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
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
                                    text: AppMessage.LOGIN_TEXT,
                                    color: Colors.white,
                                    size: Dimensions.fontSize14,
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
                            text: AppMessage.FORGET_PASS_TEXT,
                            size: Dimensions.fontSize14,
                            color: Colors.black,
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
