import 'package:get/get.dart';

class Dimensions {
  static double screenHeight =
      (Get.context == null) ? 683.4 : Get.context!.height; //683.4
  static double screenWidth =
      (Get.context == null) ? 411.4 : Get.context!.width; //411.4

  static double pageProfileView = screenHeight / 2.73;
  static double pageListView = screenHeight / 1.71;

  static double height10 = screenHeight / 68.34;
  static double height20 = screenHeight / 34.17;
  static double height45 = screenHeight / 15.19;
  static double height50 = screenHeight / 13.67;

  static double width10 = screenHeight / 68.34;
  static double width20 = screenHeight / 34.17;

  static double fontSize14 = screenHeight / 48.81;
  static double fontSize16 = screenHeight / 42.71;
  static double fontSize25 = screenHeight / 27.34;

  static double radius80 = screenHeight / 8.54;
  static double radius15 = screenHeight / 45.56;

  //splash screen dimensions
  static double splashImg = screenHeight / 2.73;
}
