import 'package:lcmobileapp/controller/auth_controller.dart';
import 'package:lcmobileapp/data/api/api_client.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppContants.BASE_URL));

  // repos
  //Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  //Get.lazyPut(() => RecomendedProductRepo(apiClient: Get.find()));
  //Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  // controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  //Get.lazyPut(
  //     () => RecommendedProductController(recommendedProductRepo: Get.find()));
  //Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
