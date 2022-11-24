import 'package:lcmobileapp/controller/attachment_controller.dart';
import 'package:lcmobileapp/controller/auth_controller.dart';
import 'package:lcmobileapp/controller/delivery_detail_controller.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/data/api/api_client.dart';
import 'package:lcmobileapp/data/repository/attachment_repo.dart';
import 'package:lcmobileapp/data/repository/auth_repo.dart';
import 'package:lcmobileapp/data/repository/delivery_detail_repo.dart';
import 'package:lcmobileapp/data/repository/user_repo.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  // api client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppContants.BASE_URL, sharedPreferences: Get.find()));

  // repos
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => UserRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => DeliveryDetailRepo(apiClient: Get.find()));
  Get.lazyPut(() => AttachmentRepo(apiClient: Get.find()));

  // controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => DeliveryDetailController(deliveryDetailRepo: Get.find()));
  Get.lazyPut(() => AttachmentController(attachmentRepo: Get.find()));
}
