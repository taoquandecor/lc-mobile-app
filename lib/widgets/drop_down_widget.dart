import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';

class DropDownWidget extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String value;
  final Function(String?)? onChange;
  const DropDownWidget(
      {super.key,
      required this.hint,
      this.items = const ['0', '1', '2', '3', '4', '5'],
      required this.value,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height50,
      padding: EdgeInsets.only(
          left: Dimensions.width20 / 5, right: Dimensions.width20 / 5),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          fillColor: Colors.black,
          filled: false,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
        ),
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
              value: item,
              child: BigText(
                text: "Text $item",
                size: Dimensions.fontSize14,
              ));
        }).toList(),
        onChanged: onChange,
      ),
    );
  }
}
