import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_assets.dart';
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




// iconWithLabel(
//                             imagePath: AppAssets.callIcon,
//                             label: "Call",
//                             onTap: () {
//                               print("Clicked Call");
//                             },
//                           ),
//                           const SizedBox(height: 6),
//                           iconWithLabel(
//                             imagePath: AppAssets.whatsappIcon,
//                             label: "WhatsApp",
//                             onTap: () {
//                               print("Clicked WhatsApp");
//                             },
//                           ),



// councelors details

// Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF1F8E9), // light greenish-white
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.green.withOpacity(0.2)),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Counselors",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.green,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         ListView.separated(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: counselors.length,
//                           separatorBuilder: (_, __) =>
//                               const SizedBox(height: 12),
//                           itemBuilder: (context, index) {
//                             final counselor = counselors[index];
//                             return Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 24,
//                                   backgroundImage: counselor.profilePic != null
//                                       ? NetworkImage(counselor.profilePic!)
//                                       : const AssetImage(
//                                               AppAssets.defaultProfile)
//                                           as ImageProvider,
//                                   backgroundColor: Colors.grey[200],
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(counselor.fullName,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 15,
//                                           )),
//                                       const SizedBox(height: 2),
//                                       Text(counselor.email,
//                                           style: const TextStyle(
//                                             color: Colors.black54,
//                                             fontSize: 13,
//                                           )),
//                                       Text(counselor.phone,
//                                           style: const TextStyle(
//                                             color: Colors.black54,
//                                             fontSize: 13,
//                                           )),
//                                       Text(
//                                           "Role: ${counselor.roleDetails.label}",
//                                           style: const TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.black87,
//                                           )),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),