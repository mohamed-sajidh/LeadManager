import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/view_models/access_view_model.dart';
import 'package:provider/provider.dart';

class LeadPage extends StatelessWidget {
  const LeadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Lead Page",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          const Text("Welcome to Lead page"),
          Consumer<AccessViewModel>(builder: (context, provider, child) {
            return InkWell(
              onTap: () {
                provider.isLogout();
              },
              child: Container(
                height: 30,
                width: 100,
                color: AppColors.red,
              ),
            );
          })
        ],
      ),
    );
  }
}
