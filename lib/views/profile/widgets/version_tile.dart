import 'package:flutter/material.dart';
import 'package:leadmanager/core/utils/app_colors.dart';
import 'package:leadmanager/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

class VersionTile extends StatelessWidget {
  const VersionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.info_outline,
              size: 20, color: AppColors.primaryColor),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'App Version',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
          Consumer<ProfileViewModel>(
            builder: (context, provider, child) {
              return Text(
                provider.appVersion,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.primaryColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
