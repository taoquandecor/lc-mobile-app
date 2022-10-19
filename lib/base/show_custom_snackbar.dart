import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';

void showCustomSnackBar(String message,
    {bool isError = true,
    String title = "Errors",
    Color backColor = const Color(0xFFFF5252),
    Color textColor = const Color(0xFFFFFFFF)}) {
  Get.snackbar(
    title,
    message,
    titleText: BigText(
      text: title,
      color: textColor,
    ),
    messageText: Text(message, style: TextStyle(color: textColor)),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: backColor,
  );
}
