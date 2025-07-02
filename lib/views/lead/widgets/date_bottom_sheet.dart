import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_manager/core/utils/app_colors.dart';

void showDateBottomSheet(BuildContext context) {
  DateTime? fromDate;
  DateTime? toDate;
  String? errorMessage;

  showModalBottomSheet<void>(
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
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 480,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Select Date",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child:
                              const Icon(Icons.close, color: AppColors.white),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // From Date
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("From Date",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () async {
                        final pickedDate = await showCustomDatePicker(
                            context, fromDate ?? DateTime.now());
                        if (pickedDate != null) {
                          setState(() {
                            fromDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.grey.withOpacity(0.5)),
                        ),
                        child: Text(
                          fromDate != null
                              ? DateFormat('yyyy-MM-dd').format(fromDate!)
                              : "Select From Date",
                          style: const TextStyle(color: AppColors.black),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // To Date
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("To Date",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () async {
                        final pickedDate = await showCustomDatePicker(
                            context, toDate ?? DateTime.now());
                        if (pickedDate != null) {
                          setState(() {
                            toDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.grey.withOpacity(0.5)),
                        ),
                        child: Text(
                          toDate != null
                              ? DateFormat('yyyy-MM-dd').format(toDate!)
                              : "Select To Date",
                          style: const TextStyle(color: AppColors.black),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Error Message (if any)
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade300),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline,
                                color: Colors.red, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.grey.shade300,
                              foregroundColor: AppColors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (fromDate == null || toDate == null) {
                                setState(() {
                                  errorMessage = "Please select both dates.";
                                });
                                return;
                              }

                              if (fromDate!.isAfter(toDate!)) {
                                setState(() {
                                  errorMessage =
                                      "From Date cannot be after To Date.";
                                });
                                return;
                              }

                              setState(() {
                                errorMessage = null;
                              });

                              Navigator.pop(context, {
                                'from': fromDate,
                                'to': toDate,
                              });
                            },
                            child: const Text("Apply"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

Future<DateTime?> showCustomDatePicker(BuildContext context, DateTime initial) {
  return showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryColor,
            onPrimary: Colors.white,
            onSurface: AppColors.black,
          ),
          dialogBackgroundColor: AppColors.white,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}
