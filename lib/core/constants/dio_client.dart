import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lead_manager/core/services/navigation_service.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/data/local/token_storage.dart';
import 'package:lead_manager/routes/app_routes.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  final Dio _dio = Dio();

  factory DioClient() => _instance;

  DioClient._internal() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 401) {
          await TokenStorageService().deleteToken();

          scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text('Session expired. Please login again.'),
              backgroundColor: AppColors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );

          await Future.delayed(const Duration(seconds: 2));

          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppRoutes.login,
            (route) => false,
          );
        }
        return handler.next(error);
      },
    ));
  }

  Future<Dio> getAuthorizedDio() async {
    final token = await TokenStorageService().getToken();

    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      throw Exception('No token found');
    }

    return _dio;
  }
}
