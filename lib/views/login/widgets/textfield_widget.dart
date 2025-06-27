import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_colors.dart';

Widget textfieldWidget(String hintText) {
  return TextField(
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColors.white,
      hintText: hintText,
      hintStyle: const TextStyle(color: AppColors.grey),

      // When enabled but not focused
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),

      // When focusedsdfd
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
        borderRadius: BorderRadius.circular(10),
      ),

      // Default border (fallback)
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
