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
      height: Dimensions.height55,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
        ),
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
              value: item,
              child: BigText(
                text: "Text $item",
                size: Dimensions.fontSize12,
              ));
        }).toList(),
        onChanged: onChange,
      ),
    );
  }
}
