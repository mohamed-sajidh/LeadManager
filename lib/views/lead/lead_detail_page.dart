import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_manager/core/utils/app_assets.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/view_models/lead_view_model.dart';
import 'package:lead_manager/views/lead/widgets/build_widgets.dart';
import 'package:provider/provider.dart';

class LeadDetailPage extends StatefulWidget {
  const LeadDetailPage({super.key});

  @override
  State<LeadDetailPage> createState() => _LeadDetailPageState();
}

class _LeadDetailPageState extends State<LeadDetailPage> {
  @override
  Widget build(BuildContext context) {
    final leadProvider = Provider.of<LeadViewModel>(context);
    final singleLead = leadProvider.singleLeadItem;
    final initials = getInitials(singleLead?.name ?? '');

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: const Text(
          "Lead Detail Page",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.backIcon),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: singleLead == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor:
                                  const Color(AppColors.leadIconColor),
                              child: Text(
                                initials,
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    singleLead.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_rounded,
                                        size: 16,
                                        color: AppColors.grey,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        singleLead.createdAt != null
                                            ? DateFormat('MMMM d, y - h:mm a')
                                                .format(singleLead.createdAt)
                                            : 'N/A',
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
                            buildStatusChip(
                              singleLead.leadStatusDetails.isActive,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            iconWithLabel(
                              imagePath: AppAssets.callIcon,
                              label: "Call",
                              onTap: () {
                                print("Clicked Call");
                              },
                            ),
                            const SizedBox(width: 30),
                            iconWithLabel(
                              imagePath: AppAssets.whatsappIcon,
                              label: "WhatsApp",
                              onTap: () {
                                print("Clicked WhatsApp");
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(AppColors.softBlue),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primaryColor.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            "Address: ${singleLead.address.isNotEmpty == true ? singleLead.address : "No address found for this user"}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(AppColors.deepIndogo),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(AppColors.softCream),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFFFB74D).withOpacity(0.5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Counselor Details",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(AppColors.deepBrown),
                                ),
                              ),
                              const SizedBox(height: 12),
                              infoRow(
                                icon: Icons.person,
                                label: "Name",
                                value: singleLead.counselorDetails.fullName,
                                iconColor: const Color(AppColors.deepBrown),
                              ),
                              const SizedBox(height: 8),
                              infoRow(
                                icon: Icons.email_outlined,
                                label: "Email",
                                value:
                                    singleLead.counselorDetails.email,
                                iconColor: const Color(AppColors.deepBrown),
                              ),
                              const SizedBox(height: 8),
                              infoRow(
                                icon: Icons.phone,
                                label: "Phone",
                                value:
                                    singleLead.counselorDetails.phone,
                                iconColor: const Color(AppColors.deepBrown),
                              ),
                              const SizedBox(height: 8),
                              infoRow(
                                icon: Icons.badge_outlined,
                                label: "Role",
                                value: singleLead
                                        .counselorDetails.roleDetails.label,
                                iconColor: const Color(AppColors.deepBrown),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blueAccent.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tracker Details",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(height: 12),
                              trackerInfoRow(
                                label: "Form Name",
                                value: singleLead
                                    .websiteformDetails.tracker.formName,
                              ),
                              trackerInfoRow(
                                label: "Lead Count",
                                value: singleLead
                                        .websiteformDetails.tracker.leadCount
                                        .toString(),
                              ),
                              trackerInfoRow(
                                label: "Last Lead Time",
                                value: singleLead.websiteformDetails.tracker
                                            // ignore: unnecessary_null_comparison
                                            .lastLeadTime !=
                                        null
                                    ? DateFormat('MMMM dd, yyyy – h:mm a')
                                        .format(singleLead.websiteformDetails
                                            .tracker.lastLeadTime)
                                    : 'N/A',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
