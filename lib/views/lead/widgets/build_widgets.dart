import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_colors.dart';

Widget buildStatusChip(bool isActive) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
    decoration: BoxDecoration(
      color: isActive ? AppColors.green.shade50 : AppColors.red.shade50,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isActive ? AppColors.green : AppColors.red,
      ),
    ),
    child: Text(
      isActive ? "Active" : "Inactive",
      style: TextStyle(
        color: isActive ? AppColors.green : AppColors.red,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    ),
  );
}

Widget infoRow({
  required IconData icon,
  required String label,
  required String value,
  Color iconColor = AppColors.black,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 18, color: iconColor),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 13, color: AppColors.grey[700]),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(AppColors.deepBrown), // deep brown
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget trackerInfoRow({required String label, required String value}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Text(
          "$label: ",
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}

Widget iconWithLabel({
  required String imagePath,
  required String label,
  required VoidCallback onTap,
}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Image.asset(
            imagePath,
            width: 28,
            height: 28,
          ),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    ],
  );
}

String getInitials(String name) {
  try {
    final cleanName = name.replaceAll(RegExp(r'[^\x00-\x7F]'), '').trim();
    final parts = cleanName.split(' ');

    if (parts.isEmpty || parts[0].isEmpty) return "??";
    if (parts.length == 1) return parts[0][0].toUpperCase();

    return (parts[0][0] + parts[1][0]).toUpperCase();
  } catch (e) {
    return "??";
  }
}

Widget buildFilterButton({
  required String label,
  IconData? icon,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primaryColor, width: 1.2),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: AppColors.primaryColor),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
