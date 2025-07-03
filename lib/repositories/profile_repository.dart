import 'package:leadmanager/data/api/profile_api_services.dart';
import 'package:leadmanager/models/profile_model.dart';

class ProfileRepository {
  final _api = ProfileApiServices();

  Future<ProfileModel> getProfile() async {
    final response = await _api.getUserProfile();
    return response;
  }
}
