import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  Color color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  BigText(
      {super.key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.fade,
      this.fontWeight = FontWeight.w400});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontFamily: "Roboto",
        fontWeight: fontWeight,
        fontSize: size == 0 ? 20 : size,
      ),
    );
  }
}
