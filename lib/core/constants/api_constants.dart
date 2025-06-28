import 'package:lead_manager/core/config.dart';

class ApiConstants {
  static String baseUrl = ApiConfig.baseUrl;

  // Authentication Api
  static String loginEndPoint = '$baseUrl/api/auth/login/';
}
