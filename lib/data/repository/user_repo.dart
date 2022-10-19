import 'package:get/get.dart';
import 'package:lcmobileapp/data/api/api_client.dart';
import 'package:lcmobileapp/models/profile_model.dart';
import 'package:lcmobileapp/utils/app_constants.dart';

class UserRepo extends GetxService {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppContants.PROFILE_URL);
  }

  Future<Response> updateProfile(
      String displayName, String phone, String email) async {
    return await apiClient.putData(AppContants.UPDATE_PROFILE_URL,
        {"DisplayName": displayName, "Phone": phone, "Email": email});
  }
}
