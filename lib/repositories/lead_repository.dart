import 'package:leadmanager/data/api/lead_api_services.dart';
import 'package:leadmanager/models/course_model.dart';
import 'package:leadmanager/models/lead_details_model.dart';
import 'package:leadmanager/models/lead_model.dart';
import 'package:leadmanager/models/lead_source_model.dart';
import 'package:leadmanager/models/status_model.dart';

class LeadRepository {
  final _api = LeadApiServices();

  Future<PaginatedLeadResponse> getLeads(int page) async {
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

  Future<PaginatedLeadResponse> getTodayLeads() async {
    final response = await _api.getTodayLeads();
    return response;
  }

  Future<PaginatedLeadResponse> getCompletedLeads() async {
    final response = await _api.getCompletedLeads();
    return response;
  }
}
