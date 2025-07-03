import 'package:flutter/material.dart';
import 'package:leadmanager/core/utils/app_assets.dart';
import 'package:leadmanager/core/utils/app_colors.dart';
import 'package:leadmanager/routes/app_routes.dart';
import 'package:leadmanager/view_models/profile_view_model.dart';
import 'package:leadmanager/widgets/custom_loader.dart';
import 'package:provider/provider.dart';

class PersonDetailsTile extends StatelessWidget {
  const PersonDetailsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.editProfile);
      },
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.black.withOpacity(0.1),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Consumer<ProfileViewModel>(
          builder: (context, provider, child) {
            if (provider.getProfileLoader) {
              return const AppLoadingIndicator();
            }

            final profile = provider.profileItem;
            if (profile == null) {
              return const Center(
                child: Text(
                  "No profile data available",
                  style: TextStyle(color: AppColors.red),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 228, 224, 224),
                    ),
                    child: Image.asset(AppAssets.profilePic),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: double.infinity,
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          provider.profileItem!.firstName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Row(
                          children: [
                            const Icon(Icons.phone,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              provider.profileItem!.phone,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 1),
                        Row(
                          children: [
                            const Icon(
                              Icons.email,
                              size: 16,
                              color: AppColors.grey,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                provider.profileItem!.emailId,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right, color: AppColors.grey),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
