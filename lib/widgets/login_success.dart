import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:leadmanager/core/utils/app_colors.dart';

void showSuccessMessage(BuildContext context, String message) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 3),
    builder: (context, controller) {
      return FlashBar(
        controller: controller,
        position: FlashPosition.bottom,
        behavior: FlashBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.black.withOpacity(0.1),
        elevation: 8,
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeIn,
        content: Row(
          children: [
            const Icon(Icons.check_circle,
                color: AppColors.primaryColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
