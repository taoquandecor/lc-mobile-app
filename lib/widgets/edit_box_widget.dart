import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/dimensions.dart';

class EditBoxWidget extends StatelessWidget {
  final String hint;
  final bool required;
  final Function(String)? onChange;
  final bool password;
  final TextEditingController controller;
  final TextAlign textAlign;
  const EditBoxWidget(
      {super.key,
      required this.hint,
      required this.controller,
      this.required = false,
      this.onChange,
      this.password = false,
      this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.height20 / 5),
      height: Dimensions.height55,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius14),
          ),
          labelText: hint,
        ),
        obscureText: password,
        validator: ((value) {
          if (required && value!.isEmpty) {
            return "field is required";
          }
        }),
        textAlign: textAlign,
        onChanged: onChange,
      ),
    );
  }
}
