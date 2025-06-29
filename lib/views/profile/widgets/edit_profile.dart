import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_assets.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/view_models/profile_view_model.dart';
import 'package:lead_manager/views/profile/widgets/update_button.dart';
import 'package:lead_manager/widgets/custom_text_widget.dart';
import 'package:lead_manager/widgets/custom_textfield_widget.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameTextController;
  late TextEditingController emailIdTextController;
  late TextEditingController mobileTextController;
  late TextEditingController whatsappTextController;
  bool isActive = true;
  String userRole = "User";

  @override
  void initState() {
    super.initState();

    final profileProvider =
        Provider.of<ProfileViewModel>(context, listen: false);

    // Optional: delay to ensure provider has loaded data if not already
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profile = profileProvider.profileItem;

      if (profile != null) {
        nameTextController.text = profile.firstName;
        emailIdTextController.text = profile.emailId;
        mobileTextController.text = profile.phone;
        whatsappTextController.text = profile.whatsappNumber;
        isActive = profile.isActive;
        userRole = profile.roleDetails?.label ?? 'User';
        setState(() {});
      }
    });

    nameTextController = TextEditingController();
    emailIdTextController = TextEditingController();
    mobileTextController = TextEditingController();
    whatsappTextController = TextEditingController();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    emailIdTextController.dispose();
    mobileTextController.dispose();
    whatsappTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: const Text(
          "Personal Details",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.black.withOpacity(0.08),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 228, 224, 224),
                    ),
                    child: Image.asset(AppAssets.profilePic),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.green.shade100
                              : AppColors.red.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isActive ? Icons.check_circle : Icons.cancel,
                              color: isActive ? AppColors.green : AppColors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isActive ? "Active" : "Inactive",
                              style: TextStyle(
                                color: isActive
                                    ? AppColors.green.shade800
                                    : AppColors.red.shade800,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Role Label
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          userRole,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: textWidget(
                      "Name",
                      color: AppColors.primaryColor,
                    ),
                  ),
                  CustomTextfieldWidget(
                    hintText: "Name",
                    textfield: nameTextController,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: textWidget(
                      "Email Id",
                      color: AppColors.primaryColor,
                    ),
                  ),
                  CustomTextfieldWidget(
                    hintText: "Email Id",
                    textfield: emailIdTextController,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: textWidget(
                      "Mobile Number",
                      color: AppColors.primaryColor,
                    ),
                  ),
                  CustomTextfieldWidget(
                    hintText: "Mobile Number",
                    textfield: mobileTextController,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: textWidget(
                      "Whatsapp Number",
                      color: AppColors.primaryColor,
                    ),
                  ),
                  CustomTextfieldWidget(
                    hintText: "Whatsapp Number",
                    textfield: whatsappTextController,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
