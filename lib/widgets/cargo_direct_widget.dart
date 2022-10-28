import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/small_text.dart';

class CargoDirectWiget extends StatelessWidget {
  final String cargoDirectId;

  const CargoDirectWiget({super.key, required this.cargoDirectId});

  @override
  Widget build(BuildContext context) {
    String _getCargoDirectName() {
      String cargoDirectname = "";
      try {
        switch (int.parse(cargoDirectId)) {
          case 1:
            cargoDirectname = AppMessage.LOADING;
            break;
          case 2:
            cargoDirectname = AppMessage.UNLOADING;
            break;
          case 3:
            cargoDirectname = AppMessage.STORAGE_IMPORT;
            break;
          case 4:
            cargoDirectname = AppMessage.STORAGE_EXPORT;
            break;
          default:
            cargoDirectname = "";
            break;
        }
      } catch (e) {}
      return cargoDirectname;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmallText(
          text: AppMessage.CARGO_DIRECT,
          size: Dimensions.fontSize16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BigText(
              text: _getCargoDirectName(),
              size: Dimensions.fontSize14,
              color: Colors.black,
            ),
          ],
        )
      ],
    );
  }
}
