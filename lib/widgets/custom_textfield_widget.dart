import 'package:flutter/material.dart';
import 'package:leadmanager/core/utils/app_colors.dart';

class CustomTextfieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController textfield;

  const CustomTextfieldWidget({
    super.key,
    required this.hintText,
    required this.textfield,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 48,
      child: TextFormField(
        controller: textfield,
        readOnly: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required';
          }
          return null;
        },
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontSize: 14,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

          // Not focused
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.grey, width: 1.2),
            borderRadius: BorderRadius.circular(12),
          ),

          // Focused
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.primaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),

          // Default
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
