import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/models/login_model.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/edit_box_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var userNameController = TextEditingController();
    var passwordController = TextEditingController();

    void _login() {
      String userName = userNameController.text;
      String passWord = passwordController.text;

      if (userName.isEmpty) {
        showCustomSnackBar("UserName is not empty", title: "UserName");
      } else if (passWord.isEmpty) {
        showCustomSnackBar("Password is not empty", title: "Password");
      } else {
        LoginModel loginModel =
            LoginModel(userName: userName, passWord: passWord);
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                        child: Image(
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
                      width: Dimensions.width20 * 12,
                      height: Dimensions.height45 * 1.5,
                      child: Image(
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
                            _login();
                          },
                          child: BigText(
                            text: "Đăng nhập",
                            color: Colors.white,
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColor.mainColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    side:
                                        BorderSide(color: AppColor.mainColor))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                BigText(
                  text: "Bạn quên mật khẩu?",
                  size: Dimensions.fontSize14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
        ));
  }
}
