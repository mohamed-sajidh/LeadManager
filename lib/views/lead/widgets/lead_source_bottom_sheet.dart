import 'package:flutter/material.dart';
import 'package:leadmanager/core/utils/app_colors.dart';
import 'package:leadmanager/models/lead_source_model.dart';
import 'package:leadmanager/view_models/lead_view_model.dart';
import 'package:provider/provider.dart';

Future<LeadSourceModel?> showLeadSourceBottomSheet(BuildContext context) {
  final leadProvider = Provider.of<LeadViewModel>(context, listen: false);

  return showModalBottomSheet<LeadSourceModel>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.secondaryColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Select Lead Source",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: AppColors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// List of Lead Sources + Clear option
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: leadProvider.leadSourceItem.length + 1,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () => Navigator.pop(context, null),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.red.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.red.withOpacity(0.4)),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.clear, color: AppColors.red),
                              SizedBox(width: 10),
                              Text(
                                "Clear Source Filter",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final leadSource = leadProvider.leadSourceItem[index - 1];
                    return InkWell(
                      onTap: () => Navigator.pop(context, leadSource),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                leadSource.sourceLabel,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            const Icon(Icons.chevron_right,
                                color: AppColors.grey),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
