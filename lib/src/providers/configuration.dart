class Configurations {
  static String _domain = "http://10.0.3.2:3002";
  static String _apiUrl = "$_domain/api/v1";
  static const String url = "";
  // static final forgotPasswordUrl = "http://localhost:3002/password/new";
  static final forgotPasswordUrl = "$_domain/password/new";
  static final sessions = "$_apiUrl/sessions";
  static final transfer_orders = "$_apiUrl/transfer_orders";

  Configurations();
}
