import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';

class InfoWiget extends StatelessWidget {
  final String text;
  final Color color;
  final String quantity;
  const InfoWiget(
      {super.key,
      required this.text,
      required this.color,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.width10,
          right: Dimensions.width10,
          top: Dimensions.height10 / 2,
          bottom: Dimensions.height10 / 2),
      padding: EdgeInsets.only(
          left: Dimensions.width10,
          right: Dimensions.width10,
          top: Dimensions.height10 / 2,
          bottom: Dimensions.height10 / 2),
      width: Dimensions.width20 * 5.5,
      color: color,
      child: Center(
          child: Column(
        children: [
          BigText(
            text: text,
            color: Colors.white,
            size: Dimensions.fontSize14,
            fontWeight: FontWeight.w700,
          ),
          BigText(
            text: quantity,
            color: Colors.white,
            size: Dimensions.fontSize12,
            fontWeight: FontWeight.w400,
          ),
        ],
      )),
    );
  }
}
