import 'package:get/get.dart';
import 'package:lcmobileapp/pages/account/profile_page.dart';
import 'package:lcmobileapp/pages/account/user_info_page.dart';
import 'package:lcmobileapp/pages/auth/change_password.dart';
import 'package:lcmobileapp/pages/auth/forgot_password_page.dart';
import 'package:lcmobileapp/pages/auth/login_page.dart';
import 'package:lcmobileapp/pages/home/home_page.dart';
import 'package:lcmobileapp/pages/tally/delivery_detail_page.dart';
import 'package:lcmobileapp/pages/tally/first_weight_detail_page.dart';
import 'package:lcmobileapp/pages/tally/first_weight_page.dart';
import 'package:lcmobileapp/pages/tally/second_weight_detail_page.dart';
import 'package:lcmobileapp/pages/tally/tally_berth_detail_page.dart';
import 'package:lcmobileapp/pages/tally/ticket_detail_page.dart';
import 'package:lcmobileapp/pages/tally/upload_ticket_page.dart';
import 'package:lcmobileapp/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initialPage = "/";
  static const String profilePage = "/profile-page";
  static const String userInfoPage = "/user-info-page";
  static const String changePasswordPage = "/change-password-page";
  static const String fistWeightDetail = "/first-weight-detail";
  static const String firstWeightPage = "/first-weight-page";
  static const String secondWeightDetail = "/second-weight-detail";
  static const String uploadTicketPage = "/upload-ticket-page";
  static const String loginPage = "/login-page";
  static const String tallyBerthDetail = "/tally-berth-detail";
  static const String forgotPassword = "/forgot-password";
  static const String deliveryDetail = "/delivery-detail";
  static const String ticketDetail = "/ticket-detail";

  static String getSplashPage() => "$splashPage";
  static String getInitialPage() => "$initialPage";
  static String getProfilePage() => "$profilePage";
  static String getUserInfoPage() => "$userInfoPage";
  static String getChangePasswordPage() => "$changePasswordPage";
  static String getFirstWeightDetailPage(int pageId) =>
      "$fistWeightDetail?pageId=$pageId";
  static String getSecondWeightDetailPage(int pageId) =>
      "$secondWeightDetail?pageId=$pageId";
  static String getLoginPage() => "$loginPage";
  static String getTallyBerthDetailPage(int pageId) =>
      "$tallyBerthDetail?pageId=$pageId";
  static String getFirstWeightPage() => "$firstWeightPage";
  static String getForgotPasswordPage() => "$forgotPassword";
  static String getUploadTicketPage(int pageId) =>
      "$uploadTicketPage?pageId=$pageId";
  static String getDeliveryDetailPage(
          String vesselVoyageId, String fromDate, String toDate) =>
      "$deliveryDetail?vesselVoyageId=$vesselVoyageId&fromDate=$fromDate&toDate=$toDate";
  static String getTicketDetailPage(int pageId) =>
      "$ticketDetail?pageId=$pageId";

  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: () => const SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: initialPage,
      page: () => HomePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: profilePage,
      page: () => const ProfilePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: userInfoPage,
      page: () => const UserInfoPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: changePasswordPage,
      page: () => const ChangePasswordPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: fistWeightDetail,
      page: () {
        var pageId = Get.parameters["pageId"];

        return FirstWeightDetailPage(
          pageId: int.parse(pageId.toString()),
        );
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: loginPage,
      page: () => const LoginPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: secondWeightDetail,
      page: () {
        var pageId = Get.parameters["pageId"];
        return SecondWeightDetailPage(
          pageId: int.parse(pageId.toString()),
        );
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: tallyBerthDetail,
      page: () {
        var pageId = Get.parameters["pageId"];
        return TallyBerthDetailPage(
          pageId: int.parse(pageId.toString()),
        );
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: firstWeightPage,
      page: () => const FirstWeightPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: uploadTicketPage,
      page: () {
        var pageId = Get.parameters["pageId"];
        return UploadTicketPage(
          pageId: int.parse(pageId.toString()),
        );
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: deliveryDetail,
      page: () {
        var vesselVoyageId = Get.parameters["vesselVoyageId"];
        var fromDate = Get.parameters["fromDate"];
        var toDate = Get.parameters["toDate"];
        return DeliveryDetailPage(
          vesselVoyageId: vesselVoyageId.toString(),
          fromDate: fromDate.toString(),
          toDate: toDate.toString(),
        );
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: ticketDetail,
      page: () {
        var pageId = Get.parameters["pageId"];
        return TicketDetailPage(
          pageId: int.parse(pageId.toString()),
        );
      },
      transition: Transition.fade,
    ),
  ];
}
