import 'package:lead_manager/core/constants/api_constants.dart';
import 'package:lead_manager/core/constants/dio_client.dart';
import 'package:lead_manager/models/profile_model.dart';

class ProfileApiServices {
  Future<ProfileModel> getUserProfile() async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final response = await dio.get(ApiConstants.profileEndPoint);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        Map<String, dynamic> userJson = jsonData['user'];

        ProfileModel profile = ProfileModel.fromJson(userJson);

        return profile;
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      throw Exception('Error getting user profile: $e');
    }
  }
}
