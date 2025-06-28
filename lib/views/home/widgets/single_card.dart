import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_colors.dart';

class SingleCard extends StatelessWidget {
  final IconData cardIcon;
  final String cardText;
  const SingleCard({super.key, required this.cardIcon, required this.cardText});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 8,
      shadowColor: AppColors.primaryColor.withOpacity(0.2),
      child: SizedBox(
        width: 180,
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Icon(cardIcon, size: 40, color: AppColors.primaryColor),
              const SizedBox(height: 10),
              Text(
                cardText,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "120",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
