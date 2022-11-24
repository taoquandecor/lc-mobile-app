import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';

class CommingPage extends StatelessWidget {
  const CommingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        SizedBox(
          height: Dimensions.height20 * 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              width: Dimensions.width20 * 12,
              height: Dimensions.height45 * 1.5,
              child: const Image(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Center(
          child: BigText(
            text: "Comming soon",
            size: Dimensions.fontSize25,
            color: AppColor.mainColor,
          ),
        ),
      ]),
    );
  }
}
