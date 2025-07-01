import 'package:flutter/material.dart';
import 'package:lead_manager/models/course_model.dart';
import 'package:lead_manager/models/lead_details_model.dart';
import 'package:lead_manager/models/lead_model.dart';
import 'package:lead_manager/repositories/lead_repository.dart';

class LeadViewModel extends ChangeNotifier {
  bool getLeadsLoader = false;
  bool getLeadsByIdLoader = false;
  bool getCoursesLoader = false;
  List<LeadModel> leadItem = [];
  List<CourseModel> coursesItem = [];
  LeadDetailsModel? singleLeadItem;

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
}
