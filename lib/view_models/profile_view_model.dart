import 'package:flutter/material.dart';
import 'package:leadmanager/models/profile_model.dart';
import 'package:leadmanager/repositories/profile_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileViewModel extends ChangeNotifier {
  bool getProfileLoader = false;
  ProfileModel? profileItem;
  String appVersion = "";

  ProfileViewModel() {
    getUserProfile();
    getAppVersion();
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

  Future<void> getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;
      notifyListeners();
    } catch (e) {
      print("Error getting app version: $e");
    }
  }
}
