import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';

class ProgressWidget extends StatelessWidget {
  final double progress;
  final double limit;
  final String text;
  const ProgressWidget(
      {super.key,
      required this.progress,
      required this.limit,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: BigText(
            text: text,
            size: Dimensions.fontSize12,
          ),
        ),
        SizedBox(
          height: Dimensions.height10 * 3,
          width: Dimensions.screenWidth - Dimensions.width10 * 3,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8BBD0),
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: Dimensions.width20),
                  child: BigText(
                    text: "$limit (tấn)",
                    color: Colors.white,
                    size: Dimensions.fontSize14,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width10, right: Dimensions.width10),
                width: MediaQuery.of(context).size.width / limit * progress,
                decoration: const BoxDecoration(
                  color: Color(0xFFEC4073),
                ),
                alignment: Alignment.centerLeft,
                child: BigText(
                  text: "$progress (tấn)",
                  color: Colors.white,
                  size: Dimensions.fontSize14,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
