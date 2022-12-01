import 'package:flutter/material.dart';
import 'package:lcmobileapp/widgets/big_text.dart';

class DisplayRowDataWidget extends StatelessWidget {
  String firstField;
  String secondField;
  Color firstColor;
  Color secondColor;
  double firstSize;
  double secondSize;
  String char;
  FontWeight fontWeight1;
  FontWeight fontWeight2;

  DisplayRowDataWidget(
      {super.key,
      required this.firstField,
      this.secondField = "",
      required this.firstColor,
      this.secondColor = Colors.black,
      required this.firstSize,
      required this.secondSize,
      this.char = "-",
      this.fontWeight1 = FontWeight.bold,
      this.fontWeight2 = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    if (secondField.isNotEmpty) {
      return Row(
        children: [
          BigText(
            text: firstField,
            size: firstSize,
            color: firstColor,
            fontWeight: fontWeight1,
          ),
          BigText(
            text: "$char $secondField",
            size: secondSize,
            color: secondColor,
            fontWeight: fontWeight2,
          ),
        ],
      );
    }
    return Row(
      children: [
        BigText(
          text: firstField,
          size: firstSize,
          color: firstColor,
          fontWeight: fontWeight1,
        ),
      ],
    );
  }
}
