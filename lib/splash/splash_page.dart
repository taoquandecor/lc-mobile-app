import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  // Future<void> _loadResource() async {
  //   await Get.find<PopularProductController>().getPopularProductList();
  //   await Get.find<RecommendedProductController>().getRecomendedProductList();
  // }

  @override
  void initState() {
    super.initState();
    //_loadResource();
    controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    animation = new CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );
    Timer(
        Duration(seconds: 4), () => Get.offNamed(RouteHelper.getInitialPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset("assets/images/logo.png",
                      width: Dimensions.splashImg))),
        ],
      ),
    );
  }
}
