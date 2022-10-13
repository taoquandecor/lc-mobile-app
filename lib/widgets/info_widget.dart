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
      padding: EdgeInsets.only(
          top: Dimensions.height10 / 2,
          left: Dimensions.width10,
          right: Dimensions.width10,
          bottom: Dimensions.height10 / 2),
      color: color,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
