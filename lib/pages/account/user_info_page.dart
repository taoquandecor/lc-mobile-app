import 'package:flutter/material.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/models/profile_model.dart';
import 'package:lcmobileapp/pages/account/profile_page.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
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
        showCustomSnackBar("Type in a valid email address",
            title: "Valid email address");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in a your email address",
            title: "Email address");
      } else if (name.isEmpty) {
        showCustomSnackBar("Type in a your name", title: "DisplayName");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in a your phone", title: "Phone number");
      } else {
        userController.updateProfile(name, phone, email).then((status) {
          if (status.isSuccess) {
            showCustomSnackBar(status.message,
                title: "Profile",
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
          text: "Thông tin người dùng",
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
                          text: "Tên đăng nhập",
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
                          text: "Nhóm quyền",
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
                          text: "Tên đầy đủ",
                          size: Dimensions.fontSize16,
                        ),
                        SizedBox(
                          height: Dimensions.height10 / 2,
                        ),
                        TextFormField(
                          controller: nameTextEdit,
                          decoration: InputDecoration(
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
                          text: "Số điện thoại",
                          size: Dimensions.fontSize16,
                        ),
                        SizedBox(
                          height: Dimensions.height10 / 2,
                        ),
                        TextFormField(
                          controller: phoneTextEdit,
                          decoration: InputDecoration(
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
                            child: BigText(
                              text: "Cập nhật",
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
                                      side: BorderSide(
                                          color: AppColor.mainColor))),
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
