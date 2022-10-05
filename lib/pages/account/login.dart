import 'package:flutter/material.dart';
import 'package:lcmobileapp/utils/dimensions.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(
          Icons.language,
          color: Colors.white,
        ),
      ),
      body: Row(
        children: [
          SizedBox(
            height: 100,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png")))),
          ),
        ],
      ),
    );
  }
}
