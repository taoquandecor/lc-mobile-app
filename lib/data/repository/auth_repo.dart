import 'package:lcmobileapp/data/api/api_client.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AuthRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(String userName, String password) async {
    return await apiClient.postData(AppContants.LOGIN_URL, {
      "Username": userName,
      "Password": password,
      "Platforms": AppContants.PLATFORMS
    });
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppContants.TOKEN) ?? "None";
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppContants.TOKEN);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppContants.TOKEN);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppContants.TOKEN, token);
  }
}
