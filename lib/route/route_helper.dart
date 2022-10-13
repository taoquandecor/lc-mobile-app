import 'dart:developer';

import 'package:get/get.dart';
import 'package:lcmobileapp/pages/account/profile_page.dart';
import 'package:lcmobileapp/pages/account/user_info_page.dart';
import 'package:lcmobileapp/pages/auth/change_password.dart';
import 'package:lcmobileapp/pages/auth/login_page.dart';
import 'package:lcmobileapp/pages/home/home_page.dart';
import 'package:lcmobileapp/pages/tally/first_weight_detail_page.dart';
import 'package:lcmobileapp/pages/tally/second_weight_detail_page.dart';
import 'package:lcmobileapp/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initialPage = "/";
  static const String profilePage = "/profile-page";
  static const String userInfoPage = "/user-info-page";
  static const String changePasswordPage = "/change-password-page";
  static const String fistWeightDetail = "/first-weight-detail";
  static const String secondWeightDetail = "/second-weight-detail";
  static const String loginPage = "/login-page";

  static String getSplashPage() => "$splashPage";
  static String getInitialPage() => "$initialPage";
  static String getProfilePage() => "$profilePage";
  static String getUserInfoPage() => "$userInfoPage";
  static String getChangePasswordPage() => "$changePasswordPage";
  static String getFirstWeightDetailPage() => "$fistWeightDetail";
  static String getSecondWeightDetailPage() => "$secondWeightDetail";
  static String getLoginPage() => "$loginPage";

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initialPage, page: () => HomePage()),
    GetPage(name: profilePage, page: () => ProfilePage()),
    GetPage(name: userInfoPage, page: () => UserInfoPage()),
    GetPage(name: changePasswordPage, page: () => ChangePasswordPage()),
    GetPage(name: fistWeightDetail, page: () => FirstWeightDetailPage()),
    GetPage(name: loginPage, page: () => LoginPage()),
    GetPage(name: secondWeightDetail, page: () => SecondWeightDetailPage()),
  ];
}
