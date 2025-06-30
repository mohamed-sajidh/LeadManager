import 'package:flutter/material.dart';
import 'package:lead_manager/models/lead_model.dart';
import 'package:lead_manager/repositories/lead_repository.dart';

class LeadViewModel extends ChangeNotifier {
  bool getLeadsLoader = false;
  LeadModel? profileItem;

  Future<List<LeadModel>> getAllLeads(int page) async {
    try {
      print("getAllLeads api called ========>");
      getLeadsLoader = true;
      notifyListeners();

      final leadRepo = LeadRepository();
      final leads = await leadRepo.getLeads(page);

      return leads;
    } catch (e) {
      print("Error Occurred while fetching the Leads: $e");
      rethrow;
    } finally {
      getLeadsLoader = false;
      notifyListeners();
    }
  }
}
