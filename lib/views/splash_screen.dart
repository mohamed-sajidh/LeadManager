import 'dart:async';

import 'package:flutter/material.dart';
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final accessProvider = Provider.of<AccessViewModel>(context, listen: false);
    accessProvider.checkLoginStatus();

    Timer(
      const Duration(seconds: 1),
      () {
        accessProvider.checkingIsLoggedIn
            ? Navigator.pushReplacementNamed(context, AppRoutes.bottom)
            : Navigator.pushNamed(context, AppRoutes.login);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Text(
          "Lead Manager",
          style: TextStyle(
            fontSize: 42,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
