import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
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
      body: Column(
        children: [
          const PersonDetailsTile(),
          const SizedBox(height: 10),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: AppColors.black.withOpacity(0.1),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
