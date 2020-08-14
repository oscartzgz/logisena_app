class Configurations {
  // static String _domain = "http://sys.logisena.com/";
  static String _domain = "http://10.0.3.4:3002";
  static String _apiUrl = "$_domain/api/v1";
  static const String url = "";
  // static final forgotPasswordUrl = "http://localhost:3002/password/new";
  static final forgotPasswordUrl = "$_domain/password/new";
  static final sessions = "$_apiUrl/sessions";
  static final transferOrders = "$_apiUrl/transfer_orders";

  Configurations();
}
