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

  Future<Response> forgot(String userName) async {
    return await apiClient.postData(AppContants.FORGOT_URL, {
      "AccountCode": userName,
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
    sharedPreferences.remove(AppContants.TERMINAL);
    apiClient.token = '';
    apiClient.updateHeader('');
    apiClient.terminal = '';
    return true;
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppContants.TOKEN, token);
  }

  Future<void> saveUserTerminal(String terminal) async {
    try {
      apiClient.terminal = terminal;
      await sharedPreferences.setString(AppContants.TERMINAL, terminal);
    } catch (e) {
      throw e.toString();
    }
  }
}
