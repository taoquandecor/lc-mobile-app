import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/app_icon.dart';

class EditBoxIconWidget extends StatelessWidget {
  final String hint;
  final bool required;
  final Function(String)? onChange;
  final bool password;
  //final TextEditingController controller;
  final IconData icon;

  const EditBoxIconWidget({
    super.key,
    required this.hint,
    //required this.controller,
    this.required = false,
    this.onChange,
    this.password = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.height20 / 5),
      height: Dimensions.height55,
      width: 50,
      child: TextFormField(
        //controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius14),
            ),
            labelText: hint,
            suffixIcon: AppIcon(
              icon: icon,
              iconSize: Dimensions.iconSize16,
              iconColor: Colors.black,
            )),
        obscureText: password,
        validator: ((value) {
          if (required && value!.isEmpty) {
            return "field is required";
          }
        }),
        onChanged: onChange,
      ),
    );
  }
}
