import 'package:lead_manager/core/config.dart';

class ApiConstants {
  static String baseUrl = ApiConfig.baseUrl;

  // Authentication URL
  static String loginEndPoint = '$baseUrl/api/auth/login/';

  // Profile URL
  static String profileEndPoint = '$baseUrl/api/profile/';

  // Lead URL
  static String leadEndPoint = '$baseUrl/api/leads/';
}
