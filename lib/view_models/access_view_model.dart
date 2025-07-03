import 'package:flutter/material.dart';
import 'package:leadmanager/data/local/token_storage.dart';

class AccessViewModel extends ChangeNotifier {
  bool checkingIsLoggedIn = false;
  TokenStorageService tokenStorageService = TokenStorageService();

  Future<void> isLogin() async {
    checkingIsLoggedIn = true;
    notifyListeners();
  }

  Future<void> isLogout() async {
    await tokenStorageService.deleteToken();
    checkingIsLoggedIn = false;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    String? token = await tokenStorageService.getToken();
    checkingIsLoggedIn = token != null;
    notifyListeners();
  }
}
