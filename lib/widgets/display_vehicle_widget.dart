import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/small_text.dart';

class DisplayVehicleWidget extends StatelessWidget {
  String primaryCode;
  String secondaryCode;
  String char;
  String numOfTurn;
  String actualOfTurn;
  double size;

  DisplayVehicleWidget(
      {super.key,
      required this.primaryCode,
      this.secondaryCode = "",
      this.char = "/",
      required this.numOfTurn,
      required this.actualOfTurn,
      required this.size});

  @override
  Widget build(BuildContext context) {
    if (secondaryCode.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BigText(
            text: primaryCode,
            size: size,
            color: AppColor.mainColor,
            fontWeight: FontWeight.bold,
          ),
          BigText(
            text: " $char $secondaryCode",
            size: size,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          SmallText(
            text: " ($actualOfTurn/$numOfTurn)",
            size: size,
          )
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BigText(
          text: primaryCode,
          size: Dimensions.fontSize14,
          color: AppColor.mainColor,
          fontWeight: FontWeight.bold,
        ),
        SmallText(
          text: " ($actualOfTurn/$numOfTurn)",
          size: Dimensions.fontSize14,
        )
      ],
    );
  }
}
