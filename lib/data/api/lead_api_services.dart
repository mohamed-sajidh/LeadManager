import 'package:intl/intl.dart';
import 'package:leadmanager/core/constants/api_constants.dart';
import 'package:leadmanager/core/constants/dio_client.dart';
import 'package:leadmanager/models/course_model.dart';
import 'package:leadmanager/models/lead_details_model.dart';
import 'package:leadmanager/models/lead_model.dart';
import 'package:leadmanager/models/lead_source_model.dart';
import 'package:leadmanager/models/status_model.dart';

class LeadApiServices {
  Future<PaginatedLeadResponse> getLeads(int page) async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final response = await dio.get('${ApiConstants.leadEndPoint}?page=$page');

      if (response.statusCode == 200) {
        return PaginatedLeadResponse.fromJson(response.data);
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

  Future<PaginatedLeadResponse> getPaginatedLeads(
      Map<String, String> queryParams) async {
    try {
      print("params => $queryParams");

      final dio = await DioClient().getAuthorizedDio();
      final response = await dio.get(
        ApiConstants.leadEndPoint,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return PaginatedLeadResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to load leads");
      }
    } catch (e) {
      print("Error in getPaginatedLeads: $e");
      rethrow;
    }
  }

  Future<List<StatusModel>> getStatus() async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final response = await dio.get(ApiConstants.statusEndPoint);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        final List<dynamic> statusJson = jsonData['statuses'];

        return statusJson.map((item) => StatusModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Status');
      }
    } catch (e) {
      throw Exception('Error getting Status: $e');
    }
  }

  Future<List<LeadSourceModel>> getLeadSource() async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final response = await dio.get(ApiConstants.leadSourceEndPoint);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        final List<dynamic> leadSourceJson = jsonData['sources'];

        return leadSourceJson
            .map((item) => LeadSourceModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load Lead Source');
      }
    } catch (e) {
      throw Exception('Error getting Lead Source: $e');
    }
  }

  Future<PaginatedLeadResponse> getTodayLeads() async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final today = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(today);

      final response = await dio.get(
          '${ApiConstants.leadEndPoint}?date_from=$formattedDate&date_to=$formattedDate');

      if (response.statusCode == 200) {
        return PaginatedLeadResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load Today\'s Leads');
      }
    } catch (e) {
      throw Exception('Error getting Today\'s Leads: $e');
    }
  }

  Future<PaginatedLeadResponse> getCompletedLeads() async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final response =
          await dio.get('${ApiConstants.leadEndPoint}?lead_status=28');

      if (response.statusCode == 200) {
        return PaginatedLeadResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load Completed Leads');
      }
    } catch (e) {
      throw Exception('Error getting Completed Leads: $e');
    }
  }
}
