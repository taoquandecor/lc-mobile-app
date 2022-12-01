import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';

class ManifestWidget extends StatelessWidget {
  String billOfLading;
  String consigneeCode;
  String delegrateCode;
  String cargoCode;

  ManifestWidget(
      {super.key,
      required this.billOfLading,
      required this.consigneeCode,
      this.delegrateCode = "",
      required this.cargoCode});

  @override
  Widget build(BuildContext context) {
    if (delegrateCode.isEmpty) {
      return BigText(
        text: "$billOfLading*$consigneeCode*$cargoCode",
        size: Dimensions.fontSize12,
        color: Colors.black,
      );
    }
    return BigText(
      text: "$billOfLading*$consigneeCode*$delegrateCode*$cargoCode",
      size: Dimensions.fontSize12,
      color: Colors.black,
    );
  }
}
