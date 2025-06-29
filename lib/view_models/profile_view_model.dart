import 'package:flutter/material.dart';
import 'package:lead_manager/models/profile_model.dart';
import 'package:lead_manager/repositories/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  bool getProfileLoader = false;
  ProfileModel? profileItem;

  ProfileViewModel() {
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    try {
      getProfileLoader = true;
      notifyListeners();

      final profileRepo = ProfileRepository();
      profileItem = await profileRepo.getProfile();
    } catch (e) {
      print("Error Occured while fetching the profile: $e");
    } finally {
      getProfileLoader = false;
      notifyListeners();
    }
  }
}
