import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_colors.dart';

class SingleLeadCard extends StatefulWidget {
  const SingleLeadCard({super.key});

  @override
  State<SingleLeadCard> createState() => _SingleLeadCardState();
}

class _SingleLeadCardState extends State<SingleLeadCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Row(
        children: [
          // example child widgets
          Icon(Icons.person, color: AppColors.primaryColor),
          SizedBox(width: 12),
          Text("Lead Name", style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
