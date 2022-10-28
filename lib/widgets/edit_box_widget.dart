import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/dimensions.dart';

class EditBoxWidget extends StatelessWidget {
  final String hint;
  final bool required;
  final bool password;
  final TextEditingController controller;
  final TextAlign textAlign;
  final bool obscureText;
  final bool showClearIcon;
  final bool readOnly;

  const EditBoxWidget({
    super.key,
    required this.hint,
    required this.controller,
    this.required = false,
    this.password = false,
    this.textAlign = TextAlign.left,
    this.obscureText = false,
    this.showClearIcon = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height45,
      child: TextFormField(
        controller: controller,
        textAlign: textAlign,
        obscureText: obscureText,
        readOnly: readOnly,
        decoration: InputDecoration(
          prefixIcon: showClearIcon
              ? (textAlign == TextAlign.left)
                  ? null
                  : IconButton(
                      onPressed: () {
                        controller.text = "";
                      },
                      icon: const Icon(Icons.clear))
              : null,
          suffixIcon: showClearIcon
              ? (textAlign == TextAlign.left)
                  ? IconButton(
                      onPressed: () {
                        controller.text = "";
                      },
                      icon: const Icon(Icons.clear))
                  : null
              : null,
          contentPadding: EdgeInsets.symmetric(
              vertical: Dimensions.width10, horizontal: Dimensions.width10),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
        ),
      ),
    );
  }
}
