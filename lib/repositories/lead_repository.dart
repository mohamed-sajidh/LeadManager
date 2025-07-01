import 'package:lead_manager/data/api/lead_api_services.dart';
import 'package:lead_manager/models/course_model.dart';
import 'package:lead_manager/models/lead_details_model.dart';
import 'package:lead_manager/models/lead_model.dart';
import 'package:lead_manager/models/lead_source_model.dart';
import 'package:lead_manager/models/status_model.dart';

class LeadRepository {
  final _api = LeadApiServices();

  Future<List<LeadModel>> getLeads(int page) async {
    final response = await _api.getLeads(page);
    return response;
  }

  Future<LeadDetailsModel> getLeadById(String userId) async {
    final response = await _api.getLeadsById(userId);
    return response;
  }

  Future<List<CourseModel>> getCourses() async {
    final response = await _api.getCourses();
    return response;
  }

  Future<List<LeadModel>> getFilteredLeads(queryParams) async {
    final response = await _api.getFilteredLeads(queryParams);
    return response;
  }

  Future<PaginatedLeadResponse> getPaginatedLeads(
      Map<String, String> queryParams) async {
    final response = await _api.getPaginatedLeads(queryParams);
    return response;
  }

  Future<List<StatusModel>> getStatus() async {
    final response = await _api.getStatus();
    return response;
  }

  Future<List<LeadSourceModel>> getLeadSource() async {
    final response = await _api.getLeadSource();
    return response;
  }
}
