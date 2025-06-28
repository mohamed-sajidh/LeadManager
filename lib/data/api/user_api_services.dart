import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lead_manager/core/constants/api_constants.dart';
import 'package:lead_manager/data/local/token_storage.dart';
import 'package:lead_manager/view_models/access_view_model.dart';
import 'package:provider/provider.dart';

class UserApiServices {
  Future<String?> loginUser(data, BuildContext context) async {
    try {
      final dio = Dio();

      final response = await dio.post(ApiConstants.loginEndPoint, data: data);

      if (response.statusCode == 200) {
        TokenStorageService tokenStorageService = TokenStorageService();

        Map<String, dynamic>? data = response.data;

        if (data != null) {
          final String accessToken = data['access'];
          await tokenStorageService.storeToken(accessToken);
          if (context.mounted) {
            final accessProvider =
                Provider.of<AccessViewModel>(context, listen: false);
            accessProvider.isLogin();
          }
        }

        return null;
      } else {
        return response.data.toString();
      }
    } on DioException catch (e) {
      Map<String, dynamic>? errorData = e.response?.data;

      if (errorData != null) {
        String? errorMessage = errorData.values.firstWhere(
          (value) => value is String,
          orElse: () => "Unknown error occurred",
        );
        return errorMessage;
      }
      return "Something went wrong. Please try again.";
    } catch (e) {
      return "Unexpected error: $e";
    }
  }
}
