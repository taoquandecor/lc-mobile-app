class AppContants {
  static const String APP_NAME = "LCMobileApp";
  static const int APP_VERSION = 1;

  //static const String BASE_URL = "http://172.18.122.56:8000";
  static const String BASE_URL = "https://api-uat.cyberlogs.vn";
  //static const String BASE_URL = "http://192.168.1.3:8000";

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
  static const String UPLOAD_TICKET = "/mobile/delivery-details/ticket-mobile";
  static const String TALLY_BERTH_TICKET =
      "/mobile/delivery-details/tally-berth-ticket-mobile";
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

  // Dasboard
  static const String VESSEL_VOYAGE_URI =
      "/mobile/dashboard/get-vessel-voyages";
  static const String DASHBOARD_STATISTIC = "/mobile/dashboard/get-statistic";
  static const String DELIVERY_DETAIL_STATISTIC =
      "/mobile/dashboard/get-statistic-delivery-detail";
  static const String FILTER_DATE = "/mobile/dashboard/get-filter-dates";

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
  static const String FORMAT_DECIMAL = "###.0#";

  static const String DATE_FORMAT = "dd/MM/yyyy";
  static const String DATE_FORMAT2 = "HH:mm dd/MM";
  static const String DATE_FORMAT3 = "HH:mm dd/MM/yyyy";
  static const String SQL_DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
  static const String SQL_DATE_FORMAT = "yyyy-MM-dd";
  static const String DATETIME_FORMAT = "dd/MM/yyyy HH:mm:ss";
  static const String SHORT_DATE_FORMAT = "dd/MM";

  static const String LOADING = "1";
  static const String UNLOADING = "2";
  static const String STORAGE_IMPORT = "3";
  static const String STORAGE_EXPORT = "4";

  static const String FIRST_WEIGHT = "FirstWeight";
  static const String SECOND_WEIGHT = "TallyBerth";

  static const Map<String, String> HEADER_IMAGE = {"Connection": 'Keep-Alive'};

  static const String TARE_WF = 'W.TARE';
  static const String UPLOAD_TICKET_WF = 'UPLOAD.TICKET';
  static const String GROSS_WF = 'W.GROSS';
  static const String VERIFY_TICKET_WF = 'VERIFY.TICKET';
  static const String BERTH_TALLY_WF = 'BERTH.TALLY';
}
