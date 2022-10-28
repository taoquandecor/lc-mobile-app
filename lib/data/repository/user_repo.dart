import 'package:get/get.dart';
import 'package:lcmobileapp/data/api/api_client.dart';
import 'package:lcmobileapp/models/profile_model.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UserRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppContants.PROFILE_URL);
  }

  Future<Response> updateProfile(
      String displayName, String phone, String email) async {
    return await apiClient.putData(AppContants.UPDATE_PROFILE_URL,
        {"DisplayName": displayName, "Phone": phone, "Email": email});
  }

  Future<Response> updatePassword(
      String oldPass, String newPass, String reNewPass) async {
    return await apiClient.putData(AppContants.CHANGE_PASSWORD, {
      "OldPassword": oldPass,
      "NewPassword": newPass,
      "RePassword": reNewPass
    });
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppContants.TOKEN);
    sharedPreferences.remove(AppContants.TERMINAL);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
