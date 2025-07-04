import 'package:flutter/material.dart';
import 'package:leadmanager/data/api/user_api_services.dart';

class UserRepository {
  final _api = UserApiServices();

  Future<String?> loginUser(emailId, password, BuildContext context) async {
    var data = {
      'email': emailId,
      'password': password,
    };
    final response = await _api.loginUser(data, context);
    return response;
  }
}
