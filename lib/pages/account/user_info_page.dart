import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/models/profile_model.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:get/get.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<UserController>().getUserInfo();
    var codeTextEdit = TextEditingController();
    var rolesTextEdit = TextEditingController();
    var emailTextEdit = TextEditingController();
    var nameTextEdit = TextEditingController();
    var phoneTextEdit = TextEditingController();

    String getListRoles(List<Roles> roles) {
      String result = "";
      if (roles.isNotEmpty) {
        result = roles[0].displayName!;
        for (int i = 1; i < roles.length; i++) {
          result += ',';
          result += roles[i].displayName!;
        }
      }
      return result;
    }

    void updateProfile(UserController userController) {
      String email = emailTextEdit.text.trim();
      String name = nameTextEdit.text.trim();
      String phone = phoneTextEdit.text.trim();

      if (!GetUtils.isEmail(email)) {
        showCustomSnackBar(AppMessage.INVALID_EMAIL_MESSAGE, title: "Email");
      } else if (email.isEmpty) {
        showCustomSnackBar(AppMessage.EMPTY_EMAIL_MESSAGE, title: "Email");
      } else if (name.isEmpty) {
        showCustomSnackBar(AppMessage.EMPTY_FULLNAME_MESSAGE,
            title: AppMessage.DISPLAYNAME);
      } else if (phone.isEmpty) {
        showCustomSnackBar(AppMessage.EMPTY_PHONE_MESSAGE,
            title: AppMessage.PHONE_NUMBER);
      } else {
        userController.updateProfile(name, phone, email).then((status) {
          if (status.isSuccess) {
            showCustomSnackBar(status.message,
                title: AppMessage.PROFILE,
                backColor: Colors.green,
                textColor: Colors.black);
            Get.find<UserController>().getUserInfo();
          } else {
            showCustomSnackBar(status.message, title: "Error");
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundWhiteColor,
        title: BigText(
          text: AppMessage.ACCOUNT_INFORMATION,
          size: Dimensions.fontSize25,
          color: AppColor.mainColor,
        ),
        leading: BackButton(
          color: AppColor.mainColor,
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          codeTextEdit.text = userController.profileModel.code.toString();
          rolesTextEdit.text =
              getListRoles(userController.profileModel.roles ?? []);
          emailTextEdit.text = userController.profileModel.email.toString();
          nameTextEdit.text =
              userController.profileModel.displayName.toString();
          phoneTextEdit.text = userController.profileModel.phone.toString();
          return userController.isLoading
              ? SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height20 + Dimensions.height10 / 2,
                        left: Dimensions.width10,
                        right: Dimensions.width10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: AppMessage.USERNAME,
                          size: Dimensions.fontSize16,
                        ),
                        SizedBox(
                          height: Dimensions.height10 / 2,
                        ),
                        TextFormField(
                          controller: codeTextEdit,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.code),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        SmallText(
                          text: AppMessage.GROUP_ROLE,
                          size: Dimensions.fontSize16,
                        ),
                        SizedBox(
                          height: Dimensions.height10 / 2,
                        ),
                        TextFormField(
                          controller: rolesTextEdit,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.group),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        SmallText(
                          text: "Email",
                          size: Dimensions.fontSize16,
                        ),
                        SizedBox(
                          height: Dimensions.height10 / 2,
                        ),
                        TextFormField(
                          controller: emailTextEdit,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        SmallText(
                          text: AppMessage.FULL_NAME,
                          size: Dimensions.fontSize16,
                        ),
                        SizedBox(
                          height: Dimensions.height10 / 2,
                        ),
                        TextFormField(
                          controller: nameTextEdit,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        SmallText(
                          text: AppMessage.PHONE_NUMBER,
                          size: Dimensions.fontSize16,
                        ),
                        SizedBox(
                          height: Dimensions.height10 / 2,
                        ),
                        TextFormField(
                          controller: phoneTextEdit,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
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
                              updateProfile(userController);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(AppColor.mainColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15),
                                      side: BorderSide(
                                          color: AppColor.mainColor))),
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
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
