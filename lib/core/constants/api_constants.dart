import 'package:lead_manager/core/config.dart';

class ApiConstants {
  static String baseUrl = ApiConfig.baseUrl;

  // Authentication URL
  static String loginEndPoint = '$baseUrl/api/auth/login/';

  // Profile URL
  static String profileEndPoint = '$baseUrl/api/profile/';

  // Lead URL
  static String leadEndPoint = '$baseUrl/api/leads/';
  static String leadByIdEndPoint(String userId) =>
      '$baseUrl/api/leads/$userId/';

  // Course URL
  static String courseEndPoint = '$baseUrl/api/courses/';

  // Status URL
  static String statusEndPoint = '$baseUrl/api/lead/statuses/';

  // Lead Source URL
  static String leadSourceEndPoint = '$baseUrl/api/lead/sources/';
}


// https://api.crm.luminartechnohub.com/api/leads/?course=7