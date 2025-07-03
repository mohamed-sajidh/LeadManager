import 'package:flutter/material.dart';
import 'package:leadmanager/core/utils/app_assets.dart';
import 'package:leadmanager/core/utils/app_colors.dart';

void showCustomSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 100, left: 10, right: 10),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            color: AppColors.successSnackbarColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                AppAssets.logo,
                height: 28,
                width: 28,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
