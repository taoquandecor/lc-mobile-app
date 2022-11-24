import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var oldPassword = TextEditingController();
    var newPassword = TextEditingController();
    var reNewPassword = TextEditingController();

    void changePassword() {
      var userController = Get.find<UserController>();
      String oldPass = oldPassword.text.trim();
      String newPass = newPassword.text.trim();
      String reNewPass = reNewPassword.text.trim();

      if (oldPass.isEmpty) {
        showCustomSnackBar(AppMessage.EMPTY_OLDPASS_MESSAGE,
            title: AppMessage.OLD_PASSWORD);
      } else if (newPass.isEmpty) {
        showCustomSnackBar(AppMessage.EMPTY_NEWPASS_MESSAGE,
            title: AppMessage.NEW_PASSWORD);
      } else if (reNewPass.isEmpty) {
        showCustomSnackBar(AppMessage.EMPTY_RENEW_MESSAGE,
            title: AppMessage.RENEW_PASSWORD);
      } else if (newPass != reNewPass) {
        showCustomSnackBar(AppMessage.ERROR_MESSAGE4,
            title: AppMessage.PASSWORD);
      } else {
        userController
            .updatePassword(oldPass, newPass, reNewPass)
            .then((status) {
          if (status.isSuccess) {
            userController.clearSharedData();
            Get.offNamed(RouteHelper.getLoginPage());
          } else {
            showCustomSnackBar(status.message, title: AppMessage.ERROR);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: BigText(
          text: AppMessage.CHANGE_PASSWORD,
          size: Dimensions.fontSize25,
          color: AppColor.mainColor,
        ),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: AppColor.mainColor,
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              top: Dimensions.height20,
              left: Dimensions.width10,
              right: Dimensions.width10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(
                text: AppMessage.CURRENT_PASSWORD,
                size: Dimensions.fontSize16,
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              TextFormField(
                controller: oldPassword,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.key),
                  hintText: AppMessage.CURRENT_PASSWORD,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              SmallText(
                text: AppMessage.NEW_PASSWORD,
                size: Dimensions.fontSize16,
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              TextFormField(
                controller: newPassword,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.key),
                  hintText: AppMessage.NEW_PASSWORD,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              SmallText(
                text: AppMessage.RENEW_PASSWORD,
                size: Dimensions.fontSize16,
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              TextFormField(
                controller: reNewPassword,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.key),
                  hintText: AppMessage.RENEW_PASSWORD,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
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
                  onPressed: () {
                    changePassword();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor.mainColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            side: BorderSide(color: AppColor.mainColor))),
                  ),
                  child: BigText(
                    text: AppMessage.UPDATE,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
