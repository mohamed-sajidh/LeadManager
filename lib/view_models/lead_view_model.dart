import 'package:flutter/material.dart';
import 'package:lead_manager/models/course_model.dart';
import 'package:lead_manager/models/lead_details_model.dart';
import 'package:lead_manager/models/lead_model.dart';
import 'package:lead_manager/models/status_model.dart';
import 'package:lead_manager/repositories/lead_repository.dart';

class LeadViewModel extends ChangeNotifier {
  bool getLeadsLoader = false;
  bool getLeadsByIdLoader = false;
  bool getCoursesLoader = false;
  bool getFilteredLoader = false;
  bool getStatusLoader = false;
  List<LeadModel> leadItem = [];
  List<CourseModel> coursesItem = [];
  List<StatusModel> statusItem = [];
  List<LeadModel> filteredLeadItem = [];
  LeadDetailsModel? singleLeadItem;
  int? selectedCourseId;
  String? searchQuery;
  int? selectedStatus;
  String? selectedSource;
  List<LeadModel> _filteredLeads = [];
  List<LeadModel> get filteredLeads => _filteredLeads;

  void clearFilters() {
    selectedCourseId = null;
    searchQuery = null;
    selectedStatus = null;
    selectedSource = null;
    _filteredLeads = [];
    notifyListeners();
  }

  Future<void> fetchAndSetFilteredLeads() async {
    final Map<String, String> queryParams = {};
    if (selectedCourseId != null) {
      queryParams['course'] = selectedCourseId.toString();
    }
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      queryParams['search'] = searchQuery!;
    }
    if (selectedStatus != null) {
      queryParams['lead_status'] = selectedStatus.toString();
    }
    if (selectedSource != null && selectedSource!.isNotEmpty) {
      queryParams['source'] = selectedSource!;
    }

    try {
      final repo = LeadRepository();
      _filteredLeads = await repo.getPaginatedLeads(queryParams);
      notifyListeners();
    } catch (e) {
      print("Error fetching filtered leads: $e");
      _filteredLeads = [];
      notifyListeners();
    }
  }

  void updateFilters({
    int? course,
    String? search,
    int? status,
    String? source,
  }) {
    selectedCourseId = course;
    searchQuery = search;
    selectedStatus = status;
    selectedSource = source;
    notifyListeners();
  }

  Future<List<LeadModel>> getAllLeads(int page) async {
    try {
      print("page number:- $page");
      getLeadsLoader = true;
      notifyListeners();

      final leadRepo = LeadRepository();
      final leads = await leadRepo.getLeads(page);
      leadItem = leads;

      return leads;
    } catch (e) {
      print("Error Occurred while fetching the Leads: $e");
      rethrow;
    } finally {
      getLeadsLoader = false;
      notifyListeners();
    }
  }

  Future<void> getLeadById(String userId) async {
    try {
      getLeadsByIdLoader = true;
      notifyListeners();

      final profileRepo = LeadRepository();
      singleLeadItem = await profileRepo.getLeadById(userId);
    } catch (e) {
      print("Error Occured while fetching the profile: $e");
    } finally {
      getLeadsByIdLoader = false;
      notifyListeners();
    }
  }

  Future<List<CourseModel>> getAllCourses() async {
    try {
      getCoursesLoader = true;
      notifyListeners();

      final leadRepo = LeadRepository();
      final course = await leadRepo.getCourses();
      coursesItem = course;

      return course;
    } catch (e) {
      print("Error Occurred while fetching the Courses: $e");
      rethrow;
    } finally {
      getCoursesLoader = false;
      notifyListeners();
    }
  }

  Future<List<LeadModel>> fetchFilteredLeads({
    int? courseId,
    String? search,
    String? status,
    String? source,
  }) async {
    try {
      getFilteredLoader = true;
      notifyListeners();

      final Map<String, String> queryParams = {};
      if (courseId != null) queryParams['course'] = courseId.toString();
      if (search != null && search.trim().isNotEmpty) {
        queryParams['search'] = search.trim();
      }
      if (status != null && status.trim().isNotEmpty) {
        queryParams['lead_status'] = status.trim();
      }

      if (source != null && source.trim().isNotEmpty) {
        queryParams['source'] = source.trim();
      }

      final leadRepo = LeadRepository();
      final leads = await leadRepo.getFilteredLeads(queryParams);
      filteredLeadItem = leads;

      return leads;
    } catch (e) {
      print("Error fetching leads: $e");
      return [];
    } finally {
      getFilteredLoader = false;
      notifyListeners();
    }
  }

  Future<List<LeadModel>> getPaginatedFilteredLeads(int page) async {
    try {
      final Map<String, String> queryParams = {};

      // Add filters if available
      if (selectedCourseId != null) {
        queryParams['course'] = selectedCourseId.toString();
      }
      if (selectedStatus != null) {
        queryParams['lead_status'] = selectedStatus.toString();
      }
      if (searchQuery != null && searchQuery!.isNotEmpty) {
        queryParams['search'] = searchQuery!;
      }
      if (selectedSource != null && selectedSource!.isNotEmpty) {
        queryParams['source'] = selectedSource!;
      }

      // Only include page if no filters are applied
      final isFiltering = selectedCourseId != null ||
          (searchQuery != null && searchQuery!.isNotEmpty) ||
          selectedStatus != null ||
          (selectedSource != null && selectedSource!.isNotEmpty);

      if (!isFiltering) {
        queryParams['page'] = page.toString();
      }

      final repo = LeadRepository();
      final result = await repo.getPaginatedLeads(queryParams);
      return result;
    } catch (e) {
      print("Error in getPaginatedFilteredLeads: $e");
      return [];
    }
  }

  bool get isFiltering =>
      selectedCourseId != null ||
      (searchQuery != null && searchQuery!.isNotEmpty) ||
      selectedStatus != null ||
      (selectedSource != null && selectedSource!.isNotEmpty);

  Future<List<StatusModel>> getAllStatus() async {
    try {
      getStatusLoader = true;
      notifyListeners();

      final leadRepo = LeadRepository();
      final status = await leadRepo.getStatus();
      statusItem = status;

      return status;
    } catch (e) {
      print("Error Occurred while fetching the Status: $e");
      rethrow;
    } finally {
      getStatusLoader = false;
      notifyListeners();
    }
  }
}
