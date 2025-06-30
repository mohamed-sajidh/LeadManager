import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_assets.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/routes/app_routes.dart';
import 'package:lead_manager/view_models/access_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkOnboardingScreen(context);
    });
  }

  void checkOnboardingScreen(context) {
    final accessProvider = Provider.of<AccessViewModel>(context, listen: false);
    accessProvider.checkLoginStatus();

    Timer(
      const Duration(seconds: 1),
      () {
        accessProvider.checkingIsLoggedIn
            ? Navigator.pushReplacementNamed(context, AppRoutes.bottom)
            : Navigator.pushReplacementNamed(context, AppRoutes.login);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              SizedBox(
                height: 250,
                child: Image.asset(
                  AppAssets.logo,
                ),
              ),
              const SizedBox(height: 24),

              // App Name
              const Text(
                "Lead Manager",
                style: TextStyle(
                  fontSize: 36,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),

              // Note / Subtitle
              const Text(
                "Simplify your lead tracking and boost productivity.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 40),

              // Optional: loading indicator
              const CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 2.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
