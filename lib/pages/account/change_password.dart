import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/small_text.dart';

import '../../utils/dimensions.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width10,
            right: Dimensions.width10,
            child: Row(
              children: [
                BigText(
                  text: "Back",
                  size: Dimensions.fontSize16,
                  color: AppColor.mainColor,
                ),
                SizedBox(
                  width: Dimensions.width20 * 2.5,
                ),
                BigText(
                  text: "Đổi mật khẩu",
                  size: Dimensions.fontSize25,
                  color: AppColor.mainColor,
                )
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height50 * 2.5,
            left: Dimensions.height10,
            right: Dimensions.height10,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(
                    text: "Mật khẩu hiện tại",
                    size: Dimensions.fontSize14,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  TextFormField(
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SmallText(
                    text: "Mật khẩu mới",
                    size: Dimensions.fontSize14,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  TextFormField(
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SmallText(
                    text: "Nhắc lại mật khẩu",
                    size: Dimensions.fontSize14,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  TextFormField(
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SizedBox(
                    height: Dimensions.height20 * 3,
                    width: Dimensions.screenWidth,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: BigText(
                        text: "Cập nhật",
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.mainColor),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                side: BorderSide(color: AppColor.mainColor))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
