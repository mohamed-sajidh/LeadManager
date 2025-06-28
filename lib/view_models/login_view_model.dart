import 'package:flutter/material.dart';
import 'package:lead_manager/repositories/user_repository.dart';
import 'package:lead_manager/widgets/error_toast.dart';
import 'package:lead_manager/widgets/login_success.dart';

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  final _userRepository = UserRepository();

  Future<void> userLogin(
    String emailId,
    String password,
    BuildContext context,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      String? response = await _userRepository.loginUser(
        emailId,
        password,
        context,
      );

      if (response == null) {
        print("api is success");
        if (context.mounted) {
          showSuccessMessage(context, "You're in! Have a great time");
        }
      } else {
        if (!context.mounted) return;
        showOverlayError(context, response);
      }
    } catch (e) {
      print("error:- $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
