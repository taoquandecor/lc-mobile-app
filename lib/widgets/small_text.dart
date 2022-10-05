import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color color;
  final String text;
  double size;
  double height;
  SmallText(
      {super.key,
      this.color = const Color(0xFFFccc7c5),
      required this.text,
      this.size = 12,
      this.height = 1.2});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: "Roboto",
        fontSize: size,
        height: height,
      ),
    );
  }
}
