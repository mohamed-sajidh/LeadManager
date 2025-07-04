import 'package:flutter/material.dart';
import 'package:leadmanager/core/utils/app_colors.dart';
import 'package:leadmanager/views/profile/widgets/logout_tile.dart';
import 'package:leadmanager/views/profile/widgets/person_details_tile.dart';
import 'package:leadmanager/views/profile/widgets/version_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: const Text(
          "Profile Page",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: const Column(
        children: [
          PersonDetailsTile(),
          SizedBox(height: 10),
          LogoutTile(),
          SizedBox(height: 10),
          VersionTile(),
        ],
      ),
    );
  }
}
