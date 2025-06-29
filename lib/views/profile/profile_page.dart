import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/views/profile/widgets/logout_tile.dart';
import 'package:lead_manager/views/profile/widgets/person_details_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        ],
      ),
    );
  }
}
