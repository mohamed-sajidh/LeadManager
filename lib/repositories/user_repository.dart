import 'package:lead_manager/data/api/user_api_services.dart';

class UserRepository {
  final _api = UserApiServices();

  Future<String?> loginUser(emailId, password) async {
    var data = {
      'email': emailId,
      'password': password,
    };
    final response = await _api.loginUser(data);
    return response;
  }
}
