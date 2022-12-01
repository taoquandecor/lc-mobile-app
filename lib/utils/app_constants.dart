class AppContants {
  static const String APP_NAME = "LCMobileApp";
  static const int APP_VERSION = 1;

  //static const String BASE_URL = "http://172.18.122.56:8000";
  static const String BASE_URL = "https://api-uat.cyberlogs.vn";
  //static const String BASE_URL = "http://192.168.1.7:8000";

  // profile and user
  static const String LOGIN_URL = "/mobile/login";
  static const String FORGOT_URL = "/mobile/forgot";
  static const String PROFILE_URL = "/mobile/profile";
  static const String UPDATE_PROFILE_URL = "/mobile/profile/profile";
  static const String CHANGE_PASSWORD = "/mobile/profile/password";

  // delivery detail
  static const String REGISTRATION_TICKET =
      "/mobile/delivery-details/registration-ticket-mobile";
  static const String PENDING_TICKET =
      "/mobile/delivery-details/pending-ticket-mobile";
  static const String HISTORY_WEIGHT_EMPTY =
      "/mobile/delivery-details/get-history-weight-empty";
  static const String UPDATE_URI = "/mobile/delivery-details/mobile-update/";
  static const String BARGE_VOYAGE_UPDATE_URI =
      "/mobile/delivery-details/barge-voyage-update/";
  static const String STORE_URI = "/mobile/delivery-details/store";
  static const String BARGE_VOYAGE_URI =
      "/mobile/delivery-details/get-barge-voyages/";
  static const String TIME_LINES_URI =
      "/mobile/delivery-detail/get-time-lines/";

  // attachment
  static const String GET_IMAGE_TICKET_URI =
      "/mobile/attachment/get-image-ticket/";
  static const String UPLOAD_IMAGE_TICKET_URI =
      "/mobile/attachment/store/image-ticket";

  static const String TOKEN = "";
  static const String TERMINAL = "";

  static const String PLATFORMS = "3"; // for mobile
  static const String SLASH = "/";
  static const String FORMAT_NUMER = "#,###";

  static const String DATE_FORMAT = "dd/MM/yyyy";
  static const String DATE_FORMAT2 = "HH:mm dd/MM";
  static const String DATE_FORMAT3 = "HH:mm dd/MM/yyyy";
  static const String SQL_DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
  static const String DATETIME_FORMAT = "dd/MM/yyyy HH:mm:ss";

  static const String LOADING = "1";
  static const String UNLOADING = "2";
  static const String STORAGE_IMPORT = "3";
  static const String STORAGE_EXPORT = "4";

  static const Map<String, String> HEADER_IMAGE = {"Connection": 'Keep-Alive'};
}
