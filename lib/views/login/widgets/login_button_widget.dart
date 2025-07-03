import 'package:flutter/material.dart';
import 'package:leadmanager/core/utils/app_colors.dart';
import 'package:leadmanager/widgets/custom_loader.dart';

class LoginButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;
  final GlobalKey<FormState>? formKey;

  const LoginButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading
          ? null
          : () {
              if (formKey == null ||
                  (formKey!.currentState != null &&
                      formKey!.currentState!.validate())) {
                onPressed();
              }
            },
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: loading ? AppColors.buttonDisableColor : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: loading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: AppLoadingIndicator(),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
