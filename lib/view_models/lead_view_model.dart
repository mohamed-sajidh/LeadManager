import 'package:flutter/material.dart';
import 'package:lead_manager/models/lead_model.dart';
import 'package:lead_manager/repositories/lead_repository.dart';

class LeadViewModel extends ChangeNotifier {
  bool getLeadsLoader = false;
  LeadModel? profileItem;

  Future<void> getAllLeads() async {
    try {
      getLeadsLoader = true;
      notifyListeners();

      final leadRepo = LeadRepository();
      profileItem = await leadRepo.getLeads();
    } catch (e) {
      print("Error Occured while fetching the Leads: $e");
    } finally {
      getLeadsLoader = false;
      notifyListeners();
    }
  }
}
