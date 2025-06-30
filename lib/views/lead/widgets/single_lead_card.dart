import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/models/lead_model.dart';
import 'package:lead_manager/routes/app_routes.dart';
import 'package:lead_manager/view_models/lead_view_model.dart';
import 'package:provider/provider.dart';

class SingleLeadCard extends StatefulWidget {
  final LeadModel lead;
  const SingleLeadCard({super.key, required this.lead});

  @override
  State<SingleLeadCard> createState() => _SingleLeadCardState();
}

class _SingleLeadCardState extends State<SingleLeadCard> {
  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(widget.lead.name);
    final leadProvider = Provider.of<LeadViewModel>(context);

    return GestureDetector(
      onTap: () {
        leadProvider.getLeadById(widget.lead.id);
        // Navigator.pushNamed(context, AppRoutes.leadDetail);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with arrow
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: const Color(AppColors.leadIconColor),
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.lead.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded,
                              size: 16, color: AppColors.grey),
                          const SizedBox(width: 5),
                          Text(
                            DateFormat('MMMM d, y - h:mm a')
                                .format(widget.lead.createdAt),
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),

            const SizedBox(height: 16),

            // Email
            _infoRow(
              icon: Icons.email_outlined,
              text: widget.lead.email.isNotEmpty
                  ? widget.lead.email
                  : 'No email found for this user',
            ),

            const SizedBox(height: 10),

            // Phone
            _infoRow(
              icon: Icons.phone,
              text: widget.lead.phoneNumber.isNotEmpty
                  ? widget.lead.phoneNumber
                  : 'No mobile number found for this user',
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
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

  Widget _infoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
