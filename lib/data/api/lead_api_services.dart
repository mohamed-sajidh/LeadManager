import 'package:lead_manager/core/constants/api_constants.dart';
import 'package:lead_manager/core/constants/dio_client.dart';
import 'package:lead_manager/models/course_model.dart';
import 'package:lead_manager/models/lead_details_model.dart';
import 'package:lead_manager/models/lead_model.dart';

class LeadApiServices {
  Future<List<LeadModel>> getLeads(int page) async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final response = await dio.get('${ApiConstants.leadEndPoint}?page=$page');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        final List<dynamic> leadJson = jsonData['results'];

        return leadJson.map((item) => LeadModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Leads');
      }
    } catch (e) {
      throw Exception('Error getting Leads: $e');
    }
  }

  Future<LeadDetailsModel> getLeadsById(String userId) async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final response = await dio.get(ApiConstants.leadByIdEndPoint(userId));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        Map<String, dynamic> leadJson = jsonData['lead'];

        LeadDetailsModel singleLead = LeadDetailsModel.fromJson(leadJson);
        return singleLead;
      } else {
        throw Exception('Failed to load Leads By Id');
      }
    } catch (e) {
      throw Exception('Error getting Leads By Id: $e');
    }
  }

  Future<List<CourseModel>> getCourses() async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final response = await dio.get(ApiConstants.courseEndPoint);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        final List<dynamic> courseJson = jsonData['courses'];

        return courseJson.map((item) => CourseModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Courses');
      }
    } catch (e) {
      throw Exception('Error getting Courses: $e');
    }
  }

  Future<List<LeadModel>> getFilteredLeads(
      Map<String, String> queryParams) async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final uri = Uri.parse(ApiConstants.leadEndPoint)
          .replace(queryParameters: queryParams);

      final response = await dio.getUri(uri);

      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>;
        final List<dynamic> leadJson = jsonData['results'];

        return leadJson.map((item) => LeadModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Leads');
      }
    } catch (e) {
      throw Exception('Error getting Leads: $e');
    }
  }

  Future<List<LeadModel>> getPaginatedLeads(
      Map<String, String> queryParams) async {
    try {
      print("params => $queryParams");
      final dio = await DioClient().getAuthorizedDio();
      final response = await dio.get(ApiConstants.leadEndPoint,
          queryParameters: queryParams);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        return jsonList.map((json) => LeadModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load leads");
      }
    } catch (e) {
      print("Error in getPaginatedLeads: $e");
      rethrow;
    }
  }
}
