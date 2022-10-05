import 'package:get/get.dart';
import 'package:lcmobileapp/pages/home/home_page.dart';
import 'package:lcmobileapp/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initialPage = "/";
  static String getSplashPage() => "$splashPage";
  static String getInitialPage() => "$initialPage";

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initialPage, page: () => HomePage()),
  ];
}
