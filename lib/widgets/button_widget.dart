import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color bgcolor;
  final Color textColor;

  const ButtonWidget(
      {super.key,
      required this.text,
      this.bgcolor = const Color(0xFFFFA31A),
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.width10 / 5, right: Dimensions.width10 / 5),
      width: Dimensions.screenHeight - (Dimensions.width10 / 5) * 2,
      height: Dimensions.height45,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgcolor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  side: BorderSide(color: bgcolor))),
        ),
        child: BigText(
          text: text,
          color: textColor,
        ),
      ),
    );
  }
}
