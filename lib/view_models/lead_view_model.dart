import 'package:flutter/material.dart';
import 'package:lead_manager/core/services/navigation_service.dart';
import 'package:lead_manager/models/course_model.dart';
import 'package:lead_manager/models/lead_details_model.dart';
import 'package:lead_manager/models/lead_model.dart';
import 'package:lead_manager/models/lead_source_model.dart';
import 'package:lead_manager/models/status_model.dart';
import 'package:lead_manager/repositories/lead_repository.dart';
import 'package:lead_manager/routes/app_routes.dart';
import 'package:lead_manager/widgets/custom_snackbar.dart';

class LeadViewModel extends ChangeNotifier {
  bool getLeadsLoader = false;
  bool getLeadsByIdLoader = false;
  bool getCoursesLoader = false;
  bool getFilteredLoader = false;
  bool getStatusLoader = false;
  bool getLeadSourceLoader = false;
  bool isLoadingFilteredLeads = false;
  bool getTodaysLeadLoader = false;
  bool getCompletedLeadLoader = false;
  PaginatedLeadResponse? leadItem;
  List<CourseModel> coursesItem = [];
  List<StatusModel> statusItem = [];
  List<LeadModel> filteredLeadItem = [];
  List<LeadSourceModel> leadSourceItem = [];
  LeadDetailsModel? singleLeadItem;
  PaginatedLeadResponse? todayLeadItem;
  PaginatedLeadResponse? completedLeadItem;
  int? selectedCourseId;
  String? searchQuery;
  int? selectedStatus;
  String? selectedSource;
  String? selectedFromDate;
  String? selectedToDate;
  List<LeadModel> _filteredLeads = [];
  List<LeadModel> get filteredLeads => _filteredLeads;
  bool isFiltering = false;

  void clearFilters() {
    selectedStatus = null;
    selectedCourseId = null;
    selectedSource = null;
    selectedFromDate = null;
    selectedToDate = null;
    searchQuery = null;
    isFiltering = false;
    notifyListeners();
  }

  Future<void> fetchAndSetFilteredLeads(BuildContext context) async {
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
      queryParams['lead_source'] = selectedSource!;
    }
    if (selectedFromDate != null && selectedFromDate!.isNotEmpty) {
      queryParams['date_from'] = selectedFromDate!;
    }
    if (selectedToDate != null && selectedToDate!.isNotEmpty) {
      queryParams['date_to'] = selectedToDate!;
    }

    isLoadingFilteredLeads = true;
    notifyListeners();

    try {
      final repo = LeadRepository();
      final response = await repo.getPaginatedLeads(queryParams);

      _filteredLeads = response.results;
      isLoadingFilteredLeads = false;
      notifyListeners();

      if (isFiltering) {
        if (_filteredLeads.isNotEmpty) {
          if (context.mounted) {
            showCustomSnackbar(context, "${response.count} leads found.");
          }
        } else {
          if (context.mounted) {
            showCustomSnackbar(context, "No leads found.");
          }
        }
      }
    } catch (e) {
      print("Error fetching filtered leads: $e");
      _filteredLeads = [];
      isLoadingFilteredLeads = false;
      notifyListeners();

      if (isFiltering && context.mounted) {
        showCustomSnackbar(context, "Failed to fetch leads.");
      }
    }
  }

  void updateFilters({
    int? course,
    String? search,
    int? status,
    String? source,
    String? fromDate,
    String? toDate,
  }) {
    selectedCourseId = course;
    searchQuery = search;
    selectedStatus = status;
    selectedSource = source;
    selectedFromDate = fromDate;
    selectedToDate = toDate;
    notifyListeners();

    isFiltering = (search != null && search.isNotEmpty) ||
        status != null ||
        course != null ||
        source != null ||
        (fromDate != null && fromDate.isNotEmpty) ||
        (toDate != null && toDate.isNotEmpty);

    notifyListeners();
  }

  Future<PaginatedLeadResponse?> getAllLeads(int page) async {
    try {
      print("page number:- $page");
      getLeadsLoader = true;
      notifyListeners();

      final leadRepo = LeadRepository();
      final leads = await leadRepo.getLeads(page);
      leadItem = leads;

      return leads;
    } on Exception catch (e) {
      if (e.toString().contains("No token found")) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AppRoutes.login,
          (route) => false,
        );
        return null; // ✅ DO NOT rethrow
      } else {
        print("Error Occurred while fetching the Leads: $e");
        rethrow; // Optional: only if you want to escalate other errors
      }
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

  Future<List<LeadModel>> getPaginatedFilteredLeads(
      int page, BuildContext context) async {
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
        queryParams['lead_source'] = selectedSource!;
      }
      if (selectedFromDate != null && selectedFromDate!.isNotEmpty) {
        queryParams['date_from'] = selectedFromDate!;
      }
      if (selectedToDate != null && selectedToDate!.isNotEmpty) {
        queryParams['date_to'] = selectedToDate!;
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
      final response = await repo.getPaginatedLeads(queryParams);
      if (page == 1) {
        if (context.mounted) {
          showCustomSnackbar(context, "${response.count} leads");
        }
      }
      return response.results; // ✅ Extract leads list
    } catch (e) {
      print("Error in getPaginatedFilteredLeads: $e");
      return [];
    }
  }

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

  Future<List<LeadSourceModel>> getAllLeadSource() async {
    try {
      getLeadSourceLoader = true;
      notifyListeners();

      final leadRepo = LeadRepository();
      final leadSource = await leadRepo.getLeadSource();
      leadSourceItem = leadSource;

      return leadSource;
    } catch (e) {
      print("Error Occurred while fetching the Status: $e");
      rethrow;
    } finally {
      getLeadSourceLoader = false;
      notifyListeners();
    }
  }

  Future<PaginatedLeadResponse> getTodayLeads() async {
    try {
      getTodaysLeadLoader = true;
      notifyListeners();

      final leadRepo = LeadRepository();
      final leads = await leadRepo.getTodayLeads();
      todayLeadItem = leads;

      return leads;
    } catch (e) {
      print("Error Occurred while fetching the Leads: $e");
      rethrow;
    } finally {
      getTodaysLeadLoader = false;
      notifyListeners();
    }
  }

  Future<PaginatedLeadResponse> getCompletedLeads() async {
    try {
      getCompletedLeadLoader = true;
      notifyListeners();

      final leadRepo = LeadRepository();
      final leads = await leadRepo.getCompletedLeads();
      completedLeadItem = leads;

      return leads;
    } catch (e) {
      print("Error Occurred while fetching the Leads: $e");
      rethrow;
    } finally {
      getCompletedLeadLoader = false;
      notifyListeners();
    }
  }
}
