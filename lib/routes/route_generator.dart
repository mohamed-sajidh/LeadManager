import 'package:flutter/material.dart';
import 'package:leadmanager/routes/app_routes.dart';
import 'package:leadmanager/views/bottom_bar/bottom_bar.dart';
import 'package:leadmanager/views/lead/lead_detail_page.dart';
import 'package:leadmanager/views/login/login_screen.dart';
import 'package:leadmanager/views/profile/widgets/edit_profile.dart';
import 'package:leadmanager/views/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.bottom:
        return MaterialPageRoute(builder: (_) => const BottomBar());
      case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfile());
      case AppRoutes.leadDetail:
        return MaterialPageRoute(builder: (_) => const LeadDetailPage());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text("No Route Defined for ${settings.name}"),
                  ),
                ));
    }
  }
}
