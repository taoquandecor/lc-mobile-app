import 'package:get/get.dart';
import 'package:lcmobileapp/pages/account/profile_page.dart';
import 'package:lcmobileapp/pages/account/user_info_page.dart';
import 'package:lcmobileapp/pages/auth/change_password.dart';
import 'package:lcmobileapp/pages/home/home_page.dart';
import 'package:lcmobileapp/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initialPage = "/";
  static const String profilePage = "/profile-page";
  static const String userInfoPage = "/user-info-page";
  static const String changePasswordPage = "/change-password-page";

  static String getSplashPage() => "$splashPage";
  static String getInitialPage() => "$initialPage";
  static String getProfilePage() => "$profilePage";
  static String getUserInfoPage() => "$userInfoPage";
  static String getChangePasswordPage() => "$changePasswordPage";

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initialPage, page: () => HomePage()),
    GetPage(name: profilePage, page: () => ProfilePage()),
    GetPage(name: userInfoPage, page: () => UserInfoPage()),
    GetPage(name: changePasswordPage, page: () => ChangePasswordPage()),
  ];
}
