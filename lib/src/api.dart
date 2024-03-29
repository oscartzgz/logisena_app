class Api {
  static String domain = "http://sys.logisena.com:1061/";
  // static String domain = "http://10.0.3.4:3002";
  static String apiUrl = "$domain/api/v1";
  // static final forgotPasswordUrl = "http://localhost:3002/password/new";
  static final forgotPasswordUrl = "$domain/password/new";
  static final sessions = "$apiUrl/sessions";
  static final transferOrders = "$apiUrl/transfer_orders";
  static final profile = "$apiUrl/profile";
  static final debts = "$apiUrl/debts";

  Api();
}
